function love.load()
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
