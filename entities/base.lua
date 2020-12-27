Object = require("../lib/classic")

Base = Object:extend()

-- Base class for collision-based entities in the game
-- (x, y) origin represents the bottom center coordinates of the entity
function Base:new(x, y, size)
    self.x = x or 0
    self.y = y or 0
    self.size = size
    self.isHit = false
end

-- Return the entity origin represented by the top left coordinates
function Base:getScreenOrigin()
    return self.x - (self.size/2), self.y - self.size
end

-- Return whether the entity is past the left bound
-- TODO account for other bounds if necessary
function Base:isOutOfBounds()
    return self.x - (self.size / 2) < 0
end

-- Check for AABB collision between self and another rectangular object
function Base:checkCollision(x1, y1, w1, h1)
    local x2, y2 = self:getScreenOrigin()
    local w2 = self.size
    local h2 = self.size

    if x1 < x2+w2 and x2 < x1+w1 and y1 < y2+h2 and y2 < y1+h1 then 
      self.isHit = true
    end
end