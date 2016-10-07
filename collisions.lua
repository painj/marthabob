-- Collision functions
local T = {}
T.__index = T
-- new world
function T:newWorld(...)
  t = {}
  t.__index = self
  setmetatable(t,self)
  t.objects = {}
  t.objectIndex = {}
  t.areColliding = {}
  t.debug = false
  t.debugColorColl = {255,0,0}
  t.debugColorOk = {0,255,0}
  return t
end

-- Shapes circle
function T:newCircle(x, y, radius)
  t = {}
  t.shape = 'circle'
  t.isColliding = false
  t.collidesWith = {}
  t.x = x
  t.y = y
  t.radius = radius
  return t
end

-- Shapes rectangle
function T:newRect(x,y,w,h)
  t = {}
  t.shape = 'rect'
  t.isColliding = false
  t.collidesWith = {}
  t.x = x
  t.y = y
  t.w = w
  t.h = h
  t.r = 0
  return t
end

-- Add objects to world
function T:addToWorld(obj, s)
  self.objects[obj] = {object= obj, shape = s}
  self.objectIndex[#self.objectIndex+1] = {object=obj, shape=s}
end

-- Check collision list and set true false on shape
function T:setColliding(shape)
  local result = 0
  for k,v in pairs(shape.collidesWith) do
    if v == true then
      result = result +1
     -- print("Collision! <-- in setColliding")
    end
  end
  if result > 0 then
    shape.isColliding = true
  else
    shape.isColliding = false
  end
end

-- Draw all objects
function T:draw()
  for k,v in pairs(self.objectIndex) do
    if v.shape.isColliding then
      love.graphics.setColor(255,0,0)
    else
      love.graphics.setColor(0,255,0)
    end
    if v.shape.shape == 'circle' then
      love.graphics.circle('line',v.shape.x,v.shape.y,v.shape.radius)
    elseif (v.shape.shape == 'rect' and v.shape.shape.r ~= 0) then
      love.graphics.push()
      love.graphics.translate(v.shape.x,v.shape.y)
      love.graphics.rotate(v.shape.r)
      love.graphics.rectangle('line',0,0,v.shape.w,v.shape.h)
      love.graphics.rotate(-v.shape.r)
      love.graphics.pop()
    else
      love.graphics.rectangle('line',v.shape.x,v.shape.y,v.shape.w,v.shape.h)
    end
    love.graphics.setColor(255,255,255)
  end

end

-- detect rect collisions
-- Returns true if two boxes overlap, false if they don't
-- x1,y1 are the left-top coords of the first box, while w1,h1 are its width and height
-- x2,y2,w2 & h2 are the same, but for the second box
function T:checkRectColl(rectA, rectB)
  local x1, y1, w1, h1 = rectA.x, rectA.y, rectA.w, rectA.h
  local x2, y2, w2, h2 = rectB.x, rectB.y, rectB.w, rectB.h
  return x1 < x2+w2 and
    x2 < x1+w1 and
    y1 < y2+h2 and
    y2 < y1+h1
end

--detect circle collisions by distance
function T:checkDistColl(circleA, circleB)
  local dist = (circleA.x - circleB.x)^2 + (circleA.y - circleB.y)^2
  return dist <= (circleA.radius + circleB.radius)^2
end

-- detect circle and rect collision
function T:checkDistCollCirRect(circle, rect)
  dx = circle.x - math.max(rect.x, math.min(circle.x, rect.x + rect.w))
  dy = circle.y - math.max(rect.y, math.min(circle.y, rect.y + rect.h))
  return (dx * dx + dy * dy) < (circle.radius * circle.radius)
end

-- collision point between two circles
function T:checkCollPoint(circleA, circleB)
  collPointX =  ((circleA.x * circleB.radius) + (circleB.x * circleA.radius))/
    (circleA.radius + circleB.radius)
  collPointY = ((circleA.y * circleB.radius) + (circleB.y * circleA.radius))/
    (circleA.radius + circleB.radius)
end

-- circle collision resolution
function circleResolution(circleA, circleB)
    if checkCircleColl(circleA, circleB) then
        -- Find the new velocities
        local vxTotal = circleA.vx - circleB.vx
        local vyTotal = circleA.vy - circleB.vy
        local newVelX1 = (circleA.vx * (circleA.mass - circleB.mass) + (2 * circleB.mass * circleB.vx)) / (circleA.mass + circleB.mass)
        local newVelY1 = (circleA.vy * (circleA.mass - circleB.mass) + (2 * circleB.mass * circleB.vy)) / (circleA.mass + circleB.mass)
        local newVelX2 = vxTotal + newVelX1
        local newVelY2 = vyTotal + newVelY1

        -- Move the circles so that they don't overlap
        local midpointX = (circleA.x + circleB.x)/2
        local midpointY = (circleA.y + circleA.y)/2
        local dist = math.sqrt((circleA.x - circleB.x)^2 + (circleA.y - circleB.y)^2)
        circleA.x = midpointX + circleA.radius * (circleA.x - circleB.x)/dist
        circleA.y = midpointY + circleA.radius * (circleA.y - circleB.y)/dist
        circleB.x = midpointX + circleB.radius * (circleB.x - circleA.x)/dist
        circleB.y = midpointY + circleB.radius * (circleB.y - circleA.y)/dist

        -- Update the velocities
        circleA.vx = newVelX1
        circleA.vy = newVelY1
        circleB.vx = newVelX2
        circleB.vy = newVelY2
    end
end

-- run checkColl function based on shape
function T:checkColl(objectA, objectB)
  if objectA.shape == 'circle' and objectB.shape == 'circle' then
    return self:checkDistColl(objectA, objectB)
  elseif objectA.shape == 'circle' and objectB.shape == 'rect' then
    return self:checkDistCollCirRect(objectA, objectB)
  elseif objectA.shape == 'rect' and objectB.shape == 'circle' then
    return self:checkDistCollCirRect(objectB, objectA)
  elseif objectA.shape == 'rect' and objectB.shape == 'rect' then
    return self:checkRectColl(objectA, objectB)
  end
end

-- check many objects
function T:checkObjects()

  for i=1, #self.objectIndex-1 do
    local partA = self.objectIndex[i].shape
    for j=i+1, #self.objectIndex do
      local partB = self.objectIndex[j].shape
      -- check collision between partA and partB
      if self:checkColl(partA, partB) then
        --print("Collision!")
        self.objectIndex[i].shape.collidesWith[self.objectIndex[j].object.name] = true
      else
        --print(partA)
        self.objectIndex[i].shape.collidesWith[self.objectIndex[j].object.name] = false
        --partA.isColliding = false
        --partB.isColliding = false
      end
    end
  end
  for k,v in pairs(self.objectIndex) do
    self:setColliding(v.shape)
  end
end

-- Find Newton Force equation
function T:force(shapeA, shapeB)
  local dist = math.dist(shapeA.x, shapeA.y, shapeB.x, shapeB.y)
  local massA, massB = shapeA.radius or shapeA.w/2, shapeB.radius or shapeB.w/2
  local force = math.sqrt(massA * massB / dist*dist)/100
  local angle = math.atan2(shapeA.y - shapeB.y,shapeA.x-shapeB.x) + math.rad(180)
  local vx, vy = force*math.cos(angle), force*math.sin(angle)
  return vx, vy
end

return T
