require "player"
local Planet = require "planet"
local System = require "solarsystem"
local Camera = require "camera"
local love = love
local system
local planet
local moon
local sun
local bgImage
local gp
local gpmoon
local gpmoon2
local cam

function love.load()
    love.keyboard.setKeyRepeat(true)
    bgImage = love.graphics.newImage("assets/images/purplenebula_bk.tga")
    system = System:new()
    system:add('sun', Planet:newPlanet('large-yellow-sun', 'Sol', 0, 0, 0))
    system:add('planet', Planet:newPlanet('medium-blue-2', 'Terra', system.planets.sun, 120, -120))
    system:add('moon',Planet:newPlanet('small-grey-1', 'Moon', system.planets.planet, 100, 120))
    system:add('gp', Planet:newPlanet('large-green-2', 'Greenie', system.planets.sun, 400, -65))
    system:add('gpmoon', Planet:newPlanet('small-grey-2', 'GMoon', system.planets.gp, 80, 45))
    system:add('gpmoon2',Planet:newPlanet('small-grey-1', 'GMoon2', system.planets.gp, 100, -90))
    system:add('planet1',Planet:newPlanet('planet1', 'Planet1', system.planets.sun, 800, -20, hdatlas))
    system:add('p1m1', Planet:newPlanet('small-purple-1','p1m1',system.planets.planet1,120,30))
    system:add('p1m2', Planet:newPlanet('small-blue-1','p1m2',system.planets.planet1,120,30))
    system:add('p1m3', Planet:newPlanet('small-grey-3','p1m3',system.planets.planet1,120,30))
    system.planets.planet.scale = .75
    system.planets.planet1.scale = 1.2
    system.planets.p1m1.angle = 120
    system.planets.p1m2.angle = 240
    system.scale = 2.7
    system.speed = .1
    system.planets.sun.scale = .75
    cam = Camera:new()
    player.scale = .5
end -- loveload

function love.update(dt)
   system:update(dt)
   player.update(dt)
   cam:lookAt(player.x, player.y)
end --loveupdate

function love.draw()
    love.graphics.clear(8,8,8,255)
    local sx = love.graphics.getWidth()/bgImage:getWidth()
    local sy = love.graphics.getHeight()/bgImage:getHeight()
    love.graphics.draw(bgImage, 0, 0, 0, sx, sy)

    cam:attach()
    system:draw()
    player.draw()
    cam:detach()
    showStats()
 end -- lovedraw

function love.keypressed(key, u)
   --Debug
   if key == "rctrl" then --set to whatever key you want to use
      debug.debug()
   end
   if key == "escape" then
      love.event.quit()
   end
   if key == "," then
      system.scale = clamp(0.1, system.scale - .1, 4)
   end
   if key == "."  then
      system.scale = clamp(0.1,system.scale + .1, 4)
   end
   if key == ";" then
      system.speed = clamp(0.1,system.speed - .1, 4)
   end
   if key == "'" then
      system.speed = clamp(0.1,system.speed + .1, 4)
   end
   if key == "a" then
      system.planets.sun.center_x = system.planets.sun.center_x - 1
   end
   if key == "d" then
      system.planets.sun.center_x = system.planets.sun.center_x + 1
   end
   if key == "w" then
      system.planets.sun.center_y = system.planets.sun.center_y - 1
   end
   if key == "s" then
      system.planets.sun.center_y = system.planets.sun.center_y + 1
   end
   if key == "o" then
     system.showOrbits = toggle(system.showOrbits)
   end
end

-- Display stats
function showStats()
  local str = string.format("Scale: %.2f\n",system.scale)
  str = str..string.format("Speed: %.2f\n",system.speed)
  str = str..string.format("SHIP\n")
  str = str..string.format("Scale: %.2f\n",player.scale)
  str = str..string.format("Position: %.2f/%.2f\n",player.x,player.y)
  str = str..string.format("Velocity: %.2f/%.2f\n",player.xvel,player.yvel)
  str = str..string.format("Rotation: %.2f\n",player.rotation)
  love.graphics.print(str,10,10)
end

-- Toggle a boolean
function toggle(var)
  if var == true then
    return false
  end
  if var == false then
    return true
  end
end

-- Clamp a value
function clamp(low, n, high) return math.min(math.max(low,n),high) end
--[[function love.load()
  center_x, center_y = 256, 256
  angle = 0
  distance = 128
end

function love.update(dt)
  angle = angle + 360*dt
  sinn = math.sin(math.rad(angle))
  coss = math.cos(math.rad(angle-180))
end

function love.draw()
  love.graphics.circle('line', center_x, center_y, 64, 64)
  love.graphics.circle('fill', center_x+(distance*sinn), center_y+(distance*coss), 32, 32)
end
]]
