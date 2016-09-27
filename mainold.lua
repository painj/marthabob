-- SpaceWar clone minigame
-- Our vessel fights for survival as an unknown
-- vessel springs a trap from the safety of an
-- uncharted solar body.



function love.load()
        myAtlas = require "assets/planetatlas"
        batch = love.graphics.newSpriteBatch( myAtlas.texture, 100 )
        solsys = {}
        solsys.batch = batch
        solsys.center = {x=0, y=0}
        solsys.sun = newPlanet(myAtlas, 'large-yellow-sun', solsys.center, 0, 1, 1)
        solsys.primus = newPlanet(myAtlas, 'large-blue-1', solsys.sun, 120, 1, 45)
        solsys.secundus = newPlanet(myAtlas, 'small-grey-2', solsys.primus, 80, 3, 180)
        
end -- love.load

-- Position = Distance * sin(angle), Distance * cos(angle)
function getPosition (distance, angle, speed)
    return distance * math.sin( angle+speed ), distance * math.cos(angle+speed)
end -- getPosition

-- make a Planet table with image and start coordinates
function newPlanet (texture, quad, host, distance, speed, angle)
    p = {}
    p.texture = texture
    p.quad = myAtlas.quads[quad]
    p.host = host
    p.distance = distance
    p.speed = speed
    p.angle = angle
    p.x, p.y = getPosition(distance, angle, speed)
    return p
end -- newPlanet

-- Updates batch for drawing our planets
function updatePlanet(p, dt)
    p.angle = p.angle + p.speed*dt 
    local x, y = getPosition(p.distance, p.angle, p.speed)
    
    p.x, p.y = p.x + x, p.y + y 
    return p.x, p.y
end -- updatePlanets

function info(p)
    return p.texture, p.quad, p.x, p.y
end -- info

-- Update deltically
function love.update(dt)
    updatePlanet(solsys.sun, dt)
    updatePlanet(solsys.primus, dt)
    updatePlanet(solsys.secundus, dt)
end -- love.update

function love.draw()
        love.graphics.clear(0, 0, 0, 255)
        --batch:clear()
        love.graphics.translate(love.graphics.getWidth()/2, love.graphics.getHeight()/2)
        love.graphics.scale(.1, .1)
        --love.graphics.draw(myAtlas.texture, myAtlas.quads['large-yellow-sun'], 100, 100)
        s = solsys.sun
        p = solsys.primus
        sec = solsys.secundus
        t = myAtlas.texture 
        love.graphics.draw(t, s.quad, s.host.x, s.host.y, 0, 1, 1, s.x, s.y, 0, 0)
        love.graphics.draw(t, p.quad, p.host.x, p.host.y, 0, 1, 1, p.x, p.y, 0, 0)
        love.graphics.draw(t, sec.quad, sec.host.x, sec.host.y, 1, 1, 1, sec.x, sec.y, 0, 0)
end

