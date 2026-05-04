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
