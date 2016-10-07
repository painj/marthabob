-- Utilities
local T = {}

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

-- Returns true if two boxes overlap, false if they don't
-- x1,y1 are the left-top coords of the first box, while w1,h1 are its width and height
-- x2,y2,w2 & h2 are the same, but for the second box
function checkCollision(x1,y1,w1,h1, x2,y2,w2,h2)
  return x1 < x2+w2 and
    x2 < x1+w1 and
    y1 < y2+h2 and
    y2 < y1+h1
end

-- Direction from pointA to pointB
function findRotation(x1,y1,x2,y2)

  local t = -math.deg(math.atan2(x2-x1,y2-y1))
  if t < 0 then t = t + 360 end;
  return t;

end


return T
