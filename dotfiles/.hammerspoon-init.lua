local meh = {"ctrl", "shift", "alt"};
local hyper = {"ctrl", "shift", "alt", "cmd"};

local function moveWindow(unitRect)
  local win = hs.window.focusedWindow()
  if win then win:moveToUnit(unitRect) end
end

-- neg for left, pos for right
local function moveScreen(dir)
    local win = hs.window.focusedWindow()
    if win then
        if dir > 0 then
            win:moveOneScreenEast()
        else
            win:moveOneScreenWest()
        end
    end
end

hs.hotkey.bind(hyper, "w", function() moveWindow({0, 0, 1, 1}) end)
hs.hotkey.bind(hyper, "a", function() moveWindow({0, 0, 0.5, 1}) end)
hs.hotkey.bind(hyper, "d", function() moveWindow({0.5, 0, 0.5, 1}) end)
hs.hotkey.bind(hyper, "z", function() moveWindow({0, 0.5, 1, 0.5}) end)
hs.hotkey.bind(hyper, "x", function() moveWindow({0, 0, 1, 0.5}) end)
hs.hotkey.bind(hyper, "e", function() moveScreen(1) end)
hs.hotkey.bind(hyper, "q", function() moveScreen(-1) end)

hs.hotkey.bind(hyper, "h", function() hs.window.focusedWindow():focusWindowWest() end)
hs.hotkey.bind(hyper, "j", function() hs.window.focusedWindow():focusWindowSouth() end)
hs.hotkey.bind(hyper, "k", function() hs.window.focusedWindow():focusWindowNorth() end)
hs.hotkey.bind(hyper, "l", function() hs.window.focusedWindow():focusWindowEast() end)

local function moveToSpace(dir)
    local screen = hs.screen.mainScreen()
    local spaces = hs.spaces.spacesForScreen(screen)
    local current = hs.spaces.focusedSpace()
    for i, sid in ipairs(spaces) do
        if sid == current then
            local target = spaces[i + dir]
            if target then hs.spaces.gotoSpace(target) end
            return
        end
    end
end

hs.hotkey.bind(hyper, "t", function() moveToSpace(1) end)
hs.hotkey.bind(hyper, "r", function() moveToSpace(-1) end)
hs.hotkey.bind(hyper, "g", function() hs.spaces.toggleMissionControl() end)

-- ===== Zone-based window placement =====
-- Hardcoded layout (work setup, 4 monitors, left-to-right):
--   vertical | landscape | landscape | laptop
-- Slot 1 = laptop (rightmost landscape)
-- Slot 2 = one monitor left of laptop
-- Slot 3 = two monitors left of laptop (leftmost landscape)
-- Slot 4 = top half of vertical monitor
-- Slot 5 = bottom half of vertical monitor
--
-- meh+N   -> focus the (topmost) window currently in zone N
-- hyper+N -> move focused window to zone N; swap with any window already there
hs.window.setFrameCorrectness = true  -- mitigates known setFrame quirks at screen edges

-- Build a {[1..5] = hs.geometry.rect} table from the current screen arrangement.
-- Missing slots are simply absent (caller should handle nil).
local function computeZones()
    local landscape = {}
    local portrait = nil
    for _, s in ipairs(hs.screen.allScreens()) do
        local f = s:frame()
        if f.h > f.w then
            portrait = s
        else
            table.insert(landscape, s)
        end
    end
    table.sort(landscape, function(a, b) return a:frame().x < b:frame().x end)

    local zones = {}
    local n = #landscape
    if n >= 1 then zones[1] = landscape[n]:frame() end       -- rightmost
    if n >= 2 then zones[2] = landscape[n - 1]:frame() end   -- one left
    if n >= 3 then zones[3] = landscape[n - 2]:frame() end   -- two left
    if portrait then
        local f = portrait:frame()
        local halfH = f.h / 2
        zones[4] = hs.geometry.rect(f.x, f.y, f.w, halfH)
        zones[5] = hs.geometry.rect(f.x, f.y + halfH, f.w, halfH)
    end
    return zones
end

local function rectContainsPoint(r, x, y)
    return x >= r.x and x < r.x + r.w
       and y >= r.y and y < r.y + r.h
end

-- Find the topmost visible standard window whose CENTER lies inside `zoneRect`.
-- Center-based matching is robust to rounding, setFrameCorrectness drift,
-- and windows that don't exactly fill the zone.
local function findWindowInZone(zoneRect, exclude)
    for _, w in ipairs(hs.window.orderedWindows()) do
        if w:isVisible() and w:isStandard()
           and (not exclude or w:id() ~= exclude:id()) then
            local f = w:frame()
            local cx, cy = f.x + f.w / 2, f.y + f.h / 2
            if rectContainsPoint(zoneRect, cx, cy) then
                return w
            end
        end
    end
    return nil
end

local function swapToZone(n)
    local target = computeZones()[n]
    if not target then
        hs.alert.show("Zone " .. n .. " unavailable")
        return
    end
    local focused = hs.window.focusedWindow()
    if not focused then return end

    local occupant = findWindowInZone(target, focused)
    local oldFrame = focused:frame()
    focused:setFrame(target)
    if occupant then
        occupant:setFrame(oldFrame)
    end
end

local function focusZone(n)
    local target = computeZones()[n]
    if not target then
        hs.alert.show("Zone " .. n .. " unavailable")
        return
    end
    local w = findWindowInZone(target)
    if w then
        w:focus()
    else
        hs.alert.show("No window in zone " .. n)
    end
end

for i = 1, 5 do
    hs.hotkey.bind(hyper, tostring(i), function() swapToZone(i) end)
    hs.hotkey.bind(meh,   tostring(i), function() focusZone(i) end)
end
