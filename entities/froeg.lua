--making all the jumps the same duration
--this makes small hops a lot more "floaty", esp at lower tempi

-- TODO consider moving these constants into a util file
bigHop = 600
smallHop = 200

--length of a beat/jump
duration = 60 / tempo

Frog = Base:extend()

function Frog:new(x, y, size)
    Frog.super.new(self, x, y, size)
    self.xvel = 0
    self.yvel = 0
    self.angle = math.pi / 2
    self.gravity = 4000
end

frog = Frog(100, floor, 50)

function Frog:draw()
    local frogX, frogY = self:getScreenOrigin()
    love.graphics.setColor(colors.frogGreen)
    love.graphics.rectangle('fill', frogX, frogY, self.size, self.size)

    --draw eye
    love.graphics.setColor(colors.black)
    love.graphics.circle('fill', self.x + (math.cos(self.angle)) * 20, self.y - (self.size/2) - (math.sin(self.angle)) * 20, 3)
end

function Frog:hop(beat)
    local hopDistance = smallHop
    --if strong beat, hop more
    if beat == 3 then
        hopDistance = bigHop
    end

    --make sure frog is touching floor
    self.xvel = hopDistance * math.cos(self.angle)
    self.yvel = hopDistance * math.sin(self.angle)
    self.gravity = 2.1 * hopDistance * math.sin(self.angle) / duration
end

function Frog:move(dt)
    self.x = self.x + self.xvel * dt
    self.y = self.y - self.yvel * dt
    
    if self.y > floor - 0.1 then
        self.y = floor
        self.xvel = 0
        self.yvel = 0
    else
        self.yvel = self.yvel - self.gravity * dt
    end

end

function Frog:lookAtMouse()
    local mouseX, mouseY = love.mouse.getPosition()
    self.angle = math.abs(math.atan2(self.y - mouseY, mouseX - self.x))

    --if angle too upwards, make sure jump is not vertical
    if self.angle > 1.3 and self.angle < 1.57 then
        self.angle = 1.3
    elseif self.angle > 1.57 and self.angle < 1.8 then
        self.angle = 1.8
    --if angle too horizontal, make sure jump is not horizontal
    elseif self.angle < 0.3 then
        self.angle = 0.3
    elseif self.angle > 2.84 then
        self.angle = 2.84
    end
end
