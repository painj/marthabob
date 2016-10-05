-- Solar System controls Planets

local T = {}
T.__index=T

-- Create a new system
function T:new()
  local t = {}
  t.__index = self
  setmetatable(t, self)
  t.planets = {}
  t.drawOrder = {}
  t.scale = 1
  t.speed = 1
  t.showPlanets = true
  t.showOrbits = false
  return t
end

--Add planets to system
function T:add(n,p)
  self.planets[n] = p
  self.drawOrder[#self.drawOrder+1] = p
end

-- Update planets
function T:update(dt)
  for _,p in pairs(self.planets) do
    local s = p.scale
    local sp = p.speed
    p.scale = self.scale*p.scale
    p.speed = self.speed*p.speed
    p.rotate(p, dt)
    p.updateCenter(p)
    p.scale = s
    p.speed = sp
  end
end

-- Draw Orbits
function T:drawOrbits()
  for _,p in pairs(self.drawOrder) do
    local r = p.distance*p.scale*self.scale
    love.graphics.setColor(255,255,255)
    love.graphics.circle('line', p.center_x, p.center_y, r)
    love.graphics.setColor(0,128,128,32)
    love.graphics.circle('fill', p.center_x, p.center_y, r)
    love.graphics.setColor(255,255,255,255)
  end
end

-- Draw planets
-- SolarSystem scale and speed multiply planets settings
function T:drawPlanets()
  for _,p in pairs(self.drawOrder) do
    local sp = self.speed * p.speed
    local sc = self.scale * p.scale
    love.graphics.draw(p.img, p.quad, p.draw_x, p.draw_y,
                       p.rotation, sc, sc, p.width/2, p.height/2)
  end
end

-- Draw collector
function T:draw(...)
  if self.showPlanets then
    self:drawPlanets()
  end
  if self.showOrbits then
    self:drawOrbits()
  end
end
return T
