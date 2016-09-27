local Planet = require "planet"
local planet
local moon
local sun
local bgImage
local gp
local gpmoon
local gpmoon2

function love.load()
    bgImage = love.graphics.newImage("assets/images/purplenebula_bk.tga")
    planet = Planet:newPlanet('medium-blue-2', 'Terra', 'Sol', 100)
    moon = Planet:newPlanet('small-grey-1', 'Moon', planet, 100)
    sun = Planet:newPlanet('large-yellow-sun', 'Sol', 0, 0)
    sun.scale = .5
    gp = Planet:newPlanet('large-green-2', 'Greenie', sun, 300)
    gpmoon = Planet:newPlanet('small-grey-2', 'GMoon', gp, 80)
    gpmoon2 = Planet:newPlanet('small-grey-1', 'GMoon2', gp, 100)
    planet.scale = .5
    moon.scale = .5
    moon.speed = -120
    planet.speed = 30
    gp.scale = .5
    gp.speed = 45
    gpmoon.scale = .5
    gpmoon.speed = -45
    gpmoon2.scale = .5
    gpmoon2.speed = 90
end -- loveload

function love.update(dt)
    planet.rotate(planet, dt)
    --moon.center_x = planet.draw_x
    --moon.center_y = planet.draw_y
    moon.updateCenter(moon)
    moon.rotate(moon, dt)
    gp.center_x = 0
    gp.center_y = 0
    gp.rotate(gp, dt)
    gpmoon.updateCenter(gpmoon)
    gpmoon.rotate(gpmoon, dt)
    gpmoon2.updateCenter(gpmoon2)
    gpmoon2.rotate(gpmoon2,dt)
end --loveupdate

function love.draw()
    love.graphics.clear(8,8,8,255)
    local sx = love.graphics.getWidth()/bgImage:getWidth()
    local sy = love.graphics.getHeight()/bgImage:getHeight()
    love.graphics.draw(bgImage, 0, 0, 0, sx, sy)
    love.graphics.translate(love.graphics.getWidth()/2,
                            love.graphics.getHeight()/2)
    love.graphics.scale(.5)
    love.graphics.draw(planet.img, planet.quad, planet.draw_x, planet.draw_y,
                       math.atan2(planet.draw_y, planet.draw_x)+math.pi/2,
                       planet.scale, planet.scale, planet.width/2, planet.height/2)
    love.graphics.draw(sun.img, sun.quad, sun.center_x, sun.center_y, 0,
                       sun.scale, sun.scale, sun.width/2, sun.height/2)
    love.graphics.draw(moon.img, moon.quad, moon.draw_x, moon.draw_y, 0,
                       moon.scale, moon.scale, moon.width/2, moon.height/2)
    --love.graphics.draw(gp.img, gp.quad, gp.draw_x, gp.draw_y, gp.rotation,
    --                 gp.scale, gp.scale, gp.width/2, gp.height/2)
    gp.draw(gp)
    gpmoon.draw(gpmoon)
    gpmoon2.draw(gpmoon2)
end -- lovedraw

function love.keypressed(key, u)
   --Debug
   if key == "rctrl" then --set to whatever key you want to use
      debug.debug()
   end
end
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
