require "utils"
require "player"
local Collisions = require "collisions"
local Planet = require "planet"
local System = require "solarsystem"
local Camera = require "camera"
local love = love
local world
local system
local planet
local moon
local sun
local bgImage
local gp
local gpmoon
local gpmoon2
local cam
local doGravity = false
local GRAVDIST  = 400 -- distance that gravity force effects ship

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
  world = Collisions:newWorld()
  shipShape()
  planetShape()
end -- loveload

function love.update(dt)

  system:update(dt)

  player.update(dt)
  cam:lookAt(player.x, player.y)

  if doGravity then
    shipForce()
  end
  updateShipShape()


  updatePlantShape()
  world:checkObjects()
end --loveupdate

function love.draw()
  love.graphics.clear(8,8,8,255)
  local sx = love.graphics.getWidth()/bgImage:getWidth()
  local sy = love.graphics.getHeight()/bgImage:getHeight()
  love.graphics.draw(bgImage, 0, 0, 0, sx, sy)

  cam:attach()
  system:draw({distx=player.x,disty=player.y})
  --world:draw() -- Draw world shapes for debug

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
  if key == "g" then
    doGravity = toggle(doGravity)
  end
  if key=="=" then
    GRAVDIST = clamp(0,GRAVDIST+100,2000)
  end
  if key=="-" then
    GRAVDIST = clamp(0,GRAVDIST-100,2000)
  end
end

-- Display stats
function showStats()
  local str = string.format("Scale: %.2f\n",system.scale)
  str = str..string.format("Speed: %.2f\n",system.speed)
  if doGravity then
    str = str..string.format("Gravity Mode: Enabled\n")
    str = str..string.format("Gravity Distance: %d",GRAVDIST)
  end
  str = str..string.format("SHIP\n")
  str = str..string.format("Scale: %.2f\n",player.scale)
  str = str..string.format("Position: %.2f/%.2f\n",player.x,player.y)
  str = str..string.format("Velocity: %.2f/%.2f\n",player.xvel,player.yvel)
  str = str..string.format("Rotation: %.2f\n",player.rotation)
  love.graphics.print(str,10,10)
end

-- Add ship to world
function shipShape()
  local x, y = player.x, player.y
  local s = player.scale
  local w = player.img:getWidth()*s
  local h = player.img:getHeight()*s
  local ox, oy = x-w/2, y-h/2
  local shape = world:newRect(ox, oy, w, h)
  world:addToWorld(player, shape)
end

-- Add planets to world
function planetShape()
  for k,v in pairs(system.planets) do
    local shape = world:newCircle(v.draw_x, v.draw_y, v.img:getWidth()/2*v.scale)
    world:addToWorld(v, shape)
  end
end

-- Update ship in world
function updateShipShape()
  local s = player.scale
  local w = player.img:getWidth()
  local h = player.img:getHeight()
  w, h = w*s, h*s
  local ox, oy = player.x-w/2, player.y-h/2

  world.objects[player].shape.x, world.objects[player].shape.y = ox, oy
  world.objects[player].shape.w, world.objects[player].shape.h = w,h
  world.objects[player].shape.r = player.rotation
end

-- Update planets in world
function updatePlantShape()
  for k,v in pairs(system.planets) do
    local x, y = v.draw_x, v.draw_y
    local s = v.scale * system.scale
    local r = v.width/2
    r = r * s
    world.objects[v].shape.x, world.objects[v].shape.y = x,y
    world.objects[v].shape.radius = r
  end
end

-- Apply gravity
function shipForce()
  local vx,vy = 0,0
  local shshape = world.objects[player].shape
  for k,v in pairs(world.objects) do
    if v.shape.shape=='circle' then
      if math.dist(shshape.x,shshape.y,v.shape.x,v.shape.y) < GRAVDIST then

        local x,y = world:force(shshape,v.shape)
        vx,vy=vx+x,vy+y
      end

    end
  end

  player.xvel, player.yvel = player.xvel+vx,player.yvel+vy
end
