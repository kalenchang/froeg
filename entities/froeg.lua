-- making all the jumps the same duration
-- this makes small hops a lot more "floaty", esp at lower tempi

BIG_HOP = 650
SMALL_HOP = 200

-- length of a beat/jump
duration = 60 / const.TEMPO

Frog = class('Frog', Base)

function Frog:initialize(x, y, size)
    Base.initialize(self, x, y, size)
    self.xvel = 0
    self.yvel = 0
    self.angle = math.pi / 2
    self.gravity = 4000
    self.isCharacter = true
    self.testvel = 0
end

function Frog:draw()
    local frogX, frogY = self:getScreenOrigin()
    --QUESTION: is it not weird that we're using colors not defined in this file?
    love.graphics.setColor(colors.frogGreen)
    love.graphics.rectangle('fill', frogX, frogY, self.sizeX, self.sizeY)

    -- draw eye
    love.graphics.setColor(colors.black)
    love.graphics.circle('fill', self.x + (math.cos(self.angle)) * 20, self.y - (self.sizeY/2) - (math.sin(self.angle)) * 20, 3)
end

function Frog:hop(beat)
    local hopConstant = SMALL_HOP
    --if strong beat, hop more
    if beat == 3 then
        hopConstant = BIG_HOP
    end

    local hopVelocity = math.abs( hopConstant  / (math.abs(math.cos(self.angle)) + (math.sin(self.angle) / 4) ) )

    if hopVelocity > self.testvel then
        self.testvel = hopVelocity
    end

    --make sure frog is touching floor
    --TODO: can we make the vertical hops taller? so that the distance traveled is around the same regardless of the angle?
    self.xvel = hopVelocity * math.cos(self.angle)
    self.yvel = hopVelocity * math.sin(self.angle)
    self.gravity = 2.3 * hopVelocity * math.sin(self.angle) / duration
end

function Frog:move(dt)
    self.x = self.x + self.xvel * dt
    self.y = self.y - self.yvel * dt

    if self.y > const.FLOOR - 0.1 then
        self.y = const.FLOOR
        self.xvel = 0
        self.yvel = 0
    else
        self.yvel = self.yvel - self.gravity * dt
    end

end

function Frog:lookAtMouse()
    local mouseX, mouseY = love.mouse.getPosition()

    --since mouse coordinates are screen coordinates, but frog coordinates are game coordinates, need to shift mouse coordinates to game
    mouseX = mouseX - translateX
    mouseY = mouseY - translateY

    self.angle = math.abs(math.atan2(self.y - mouseY, mouseX - self.x))

    --if angle too upwards, make sure jump is not vertical
    if self.angle > 1.4 and self.angle < 1.57 then
        self.angle = 1.4
    elseif self.angle > 1.57 and self.angle < 1.74 then
        self.angle = 1.74
    --if angle too horizontal, make sure jump is not horizontal
    elseif self.angle < 0.3 then
        self.angle = 0.3
    elseif self.angle > 2.84 then
        self.angle = 2.84
    end
end
