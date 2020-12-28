-- Tree represents a background object purely for decoration

Tree = Base:extend()

function Tree:new(x, y, length, height, speed)
    Tree.super.new(self, x, y, length, height)
    self.speed = speed
    self.isbg = true
end

function Tree:draw()
    local screenX, screenY = self:getScreenOrigin()
    love.graphics.setColor(colors.treeGreen)
    love.graphics.rectangle('fill', screenX, screenY, self.sizeX, self.sizeY)
end

function Tree:move(dt)
    --should move backwards, since in the background (simulate parallax)

    self.x = self.x - dt * self.speed
end

-- Set log to be garboratored after going out of bounds
function Tree:setHitIfOutOfBounds()
    if self:isOutOfBounds() then
        self.isHit = true
    end
end

-- Reset the position of the log if it has collided with left bound or frög
-- Main garborator function
function Tree:reset()
    if self.isHit then
        self.x = - translateX + windowX + 50
        self.isHit = false
    end
end