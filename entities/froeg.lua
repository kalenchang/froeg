-- making all the jumps the same duration
-- this makes small hops a lot more "floaty", esp at lower tempi

-- TODO consider moving these constants into a util file
gravy = 4000 -- TECHNICALLY gravy doesn't need to be a constant, since it's calculated before each hop...
bigHop = 600
smallHop = 200

-- length of a beat/jump
duration = 60 / tempo

Frog = Base:extend()

function Frog:new(x, y, size)
    Frog.super.new(self, x, y, size)
    self.xvel = 0
    self.yvel = 0
    self.angle = math.pi / 2
end

frog = Frog(100, floor, 50)

-- TODO make the following functions to extend Frog

function drawFrog(f)
    -- based on screen x and y, the bottom of the frog
    love.graphics.setColor(colors.frogGreen)
    love.graphics.rectangle('fill', f.x - (f.size/2), f.y - f.size, f.size, f.size)

    -- draw eye
    love.graphics.setColor(colors.black)
    love.graphics.circle('fill', f.x + (math.cos(f.angle)) * 20, f.y - (50/2) - (math.sin(f.angle)) * 20, 3)

end


function moveToMouse(dt)
    local mouse = {}
    mouse.x, mouse.y = love.mouse.getPosition()

    if frog.x < mouse.x then
        frog.x = frog.x + dt * frog.speed
    elseif frog.x > mouse.x then
        frog.x = frog.x - dt * frog.speed
    end

    if frog.y < mouse.y then
        frog.y = frog.y + dt * frog.speed
    elseif frog.y > mouse.y then
        frog.y = frog.y - dt * frog.speed
    end
end

-- TODO: add these functions to frog itself
function frogHop(f, b)
    
    local hopDistance = smallHop
    -- if strong beat, hop more
    if b == 3 then
        hopDistance = bigHop
    end

    -- make sure frog is touching floor
    -- if f.y > floor - 10 then
    f.xvel = hopDistance * math.cos(f.angle)
    f.yvel = hopDistance * math.sin(f.angle)
    gravy = 2.1 * hopDistance * math.sin(f.angle) / duration
    -- end


end

function frogMove(f, dt)
    f.x = f.x + f.xvel * dt
    f.y = f.y - f.yvel * dt
    
    if f.y > floor - 0.1 then
        f.y = floor
        f.xvel = 0
        f.yvel = 0
    else
        f.yvel = f.yvel - gravy * dt
    end

end

function lookAtMouse(f)
    local mouseX, mouseY = love.mouse.getPosition()
    f.angle = math.abs(math.atan2(f.y - mouseY, mouseX - f.x))

    -- if angle too upwards, make sure jump is not vertical
    if f.angle > 1.3 and f.angle < 1.57 then
        f.angle = 1.3
    elseif f.angle > 1.57 and f.angle < 1.8 then
        f.angle = 1.8
    -- if angle too horizontal, make sure jump is not horizontal
    elseif f.angle < 0.3 then
        f.angle = 0.3
    elseif f.angle > 2.84 then
        f.angle = 2.84
    end
end

-- TODO DEPRECATE after moving froeg to Object
function coords_to_top_left(o) 
    return o.x - (o.size/2), o.y - o.size
end