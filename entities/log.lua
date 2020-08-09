-- Log represents a type of obstacle that exists on top of the ground

Log = Base:extend()

function Log:new(x, y, size, speed)
    Log.super.new(self, x, y, size)
    self.speed = speed
end

log = Log(windowX, floor, 15, 100)

function Log:draw()
    local screenX, screenY = self:getScreenOrigin()
    love.graphics.setColor(colors.logBrown)
    love.graphics.rectangle('fill', screenX, screenY, self.size, self.size)
end

function Log:move(dt)
    self.x = self.x - dt * self.speed
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
        self.x = windowX
        self.isHit = false
    end
end