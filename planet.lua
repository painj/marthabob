-- Planets orbit planets, regardless.

-- Planet Tilesheet
-- Sizes: Huge, Large, Medium, Small
-- Colors: Blue, Brown, Green, Grey, Red, White, Yellow
-- Type: 1-n of size-color-#
-- Sun: large-yellow-sun


local T = {}
T.__index = T

regatlas = require "assets/planetatlas"
hdatlas = require "assets/hdplanets"

-- String explode
function stringExplode(str, div)
    assert(type(str) == "string" and type(div) == "string", "invalid arguments")
    local o = {}
    while true do
        local pos1,pos2 = str:find(div)
        if not pos1 then
            o[#o+1] = str
            break
        end
        o[#o+1],str = str:sub(1,pos1-1),str:sub(pos2+1)
    end
    return o
end -- string string:explode

-- New Planet 'size-color-number'
function T:newPlanet(id, name, primary, distance, speed,atlas )
    atlas = atlas or regatlas
    local o = {}
    setmetatable(o, self)
    o.__index = self
    o.img = atlas.texture
    o.name = name
    o.quad = atlas.quads[id]
    local vx, vy
    vx,vy,o.width,o.height = atlas.quads[id]:getViewport()
    o.primary = primary
    o.distance = distance
    o.center_x, o.center_y = 0, 0
    o.angle = 0
    o.speed = speed
    o.scale = 1
    o.rotation = 0
    o.draw_x = 0
    o.draw_y = 0
    return o
end -- T:newPlanet

function T:rotate(dt)
    t = self
    --print("Rotating", t.name)
    t.angle = t.angle + t.speed*dt
    local sinn = math.sin(math.rad(t.angle))
    local coss = math.cos(math.rad(t.angle-180))
    t.draw_x = t.center_x + (t.distance*t.scale*sinn)
    t.draw_y = t.center_y + (t.distance*t.scale*coss)
end -- rotate

function T:updateCenter()
   t = self
   if t.primary == 0 then
      return
   end
   t.center_x = t.primary.draw_x or t.center_x
   t.center_y = t.primary.draw_y or t.center_y
end

function T:draw()
   t = self
   love.graphics.draw(t.img, t.quad, t.draw_x, t.draw_y, t.rotation, t.scale,
                      t.scale, t.width/2, t.height/2)

end
return T
