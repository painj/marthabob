-- Collision functions
local T = {}
T.__index = T
-- new world
function T:newWorld(...)
  t = {}
  t.__index = self
  setmetatable(t,self)
  t.objects = {}
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
  t.x = x
  t.y = y
  t.w = w
  t.h = h
  return t
end

-- Add objects to world
function T:addToWorld(obj, s)
  self.objects[obj] = {object= obj, shape = s}
end

-- Draw all objects
function T:draw()
  for k,v in self.objects do
    if v.isColliding then
      love.graphics.setColor(255,0,0)
    else
      love.graphics.setColor(0,255,0)
    end
    if v.shape == 'circle' then
      love.graphics.circle('line',v.x,v.y,v.radius)
    else
      love.graphics.rect('line',v.x,v.y,v.w,v.h)
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
function checkDistColl(circleA, circleB)
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
    return self:checkCircleColl(objectA, objectB)
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
  for i=1, #self.objects-1 do
    local partA = self.objects[i].shape
    for j=i+1, #self.objects do
      local partB = self.objects[j].shape
      -- check collision between partA and partB
      if self:checkColl(partA, partB) then
        partA.isColliding = true
      else
        partA.isColliding = false
      end
    end
  end
end

return T
