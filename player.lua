player = {
  x = 150,
  y = 150,
  xvel = 0,
  yvel = 0,
  rotation = 0,
  rvel = 0,
  angaccel = 1,
  acceleration = 60,
  friction = 5,
  maxspeed = 40,
  img = love.graphics.newImage("assets/images/FrigateB.png"),
  imgAccel = love.graphics.newImage("assets/images/fireflash.png"),
  isAccel = false,
  scale = 1
}


function player.update(dt)
   player.isAccel = false
   if love.keyboard.isDown"[" then
      player.scale = player.scale - .1
   end
   if love.keyboard.isDown"]" then
      player.scale = player.scale + .1
   end
  if love.keyboard.isDown"right" then
    -- rotate clockwise
     --player.rotation = player.rotation + player.angaccel*dt
     player.rvel = player.rvel + player.angaccel*dt
     player.isAccel = true
  end
  if love.keyboard.isDown"left" then
    -- rotate counter-clockwise
     --player.rotation = player.rotation - player.angaccel*dt
     player.rvel = player.rvel - player.angaccel*dt
     player.isAccel = true
  end
  if love.keyboard.isDown"down" then
    -- decelerate / accelerate backwards
    player.xvel = player.xvel - player.acceleration*dt * math.cos(player.rotation)
    player.yvel = player.yvel - player.acceleration*dt * math.sin(player.rotation)
  end
  if love.keyboard.isDown"up" then
    -- accelerate
    player.xvel = player.xvel + player.acceleration*dt * math.cos(player.rotation)
    player.yvel = player.yvel + player.acceleration*dt * math.sin(player.rotation)
    player.isAccel = true
  end
  player.x = player.x + player.xvel*dt
  player.y = player.y + player.yvel*dt
  if player.xvel > player.maxspeed or player.yvel > player.maxspeed then
     player.yvel = player.yvel * 0.99
     player.xvel = player.xvel * 0.99
  end
  player.rotation = player.rotation + player.rvel*dt
  player.rvel = player.rvel * 0.99
end

function player.draw()
--  love.graphics.setColor(80, 80, 80)
  love.graphics.translate(player.x, player.y)
  love.graphics.rotate(player.rotation)
  if player.isAccel then
     love.graphics.draw(player.imgAccel,
                        0-(player.img:getWidth()*player.scale)/2-(player.imgAccel:getWidth()*player.scale)/2,
                        0, 0, player.scale, player.scale,
                        player.imgAccel:getWidth()/2, player.imgAccel:getHeight()/2)

  end
  love.graphics.draw(player.img, 0,0,0,player.scale,player.scale,
                     player.img:getWidth()/2,player.img:getHeight()/2)
--  love.graphics.rectangle("fill", -50, -10, 100, 20)
--  love.graphics.setColor(200, 200, 200)
--  love.graphics.line(20, 0, 50, 0)
end
