-- HUD module

local T = {}
T.__index = T

function T:new()
  t = {}
  t.__index = self
  setmetatable(t, self)
  t.font = arg['font'] or nil
  t.x = arg['x'] or 0
  t.y = arg['y'] or 0
  t.entries = {}
  return t
end

function T:addEntry(label, value)
  self.entries[#self.entries+1] = {label,value}
end

function T:draw()
  local str
  for k,v in self.entries do
    str = str + k + ": " + v
  end
  love.graphics.print()
end
