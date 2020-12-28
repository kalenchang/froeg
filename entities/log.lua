-- Log represents a type of obstacle that exists on top of the ground

Log = Base:extend()

function Log:new(x, y, size)
    Log.super.new(self, x, y, size)
    self.isLog = true
end

function Log:draw()
    local screenX, screenY = self:getScreenOrigin()
    love.graphics.setColor(colors.logBrown)
    love.graphics.rectangle('fill', screenX, screenY, self.sizeX, self.sizeY)
end

function Log:move(dt)
    --logs can't move, silly!

    --self.x = self.x - dt * self.speed
end

-- Set log to be garboratored after going out of bounds
function Log:setHitIfOutOfBounds()
    if self:isOutOfBounds() then
        self.isHit = true
    end
end

-- Reset the position of the log if it has collided with left bound or frög
-- Main garborator function
function Log:reset()
    if self.isHit then
        self.x = - translateX + windowX + 50
        self.isHit = false
    end
end