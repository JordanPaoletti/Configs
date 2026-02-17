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
hs.hotkey.bind(hyper, "e", function() moveScreen(1) end)
hs.hotkey.bind(hyper, "q", function() moveScreen(-1) end)
