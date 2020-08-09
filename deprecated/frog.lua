--frog functions, maybe make into an object??
--original frog

gravy = 4000
bigHop = 800
smallHop = 500

frog = {
    x = 100,
    y = floor,
    speed = 300, -- not used rn
    angle = math.pi/3,
    xvel = 0,
    yvel = 0,
}

function drawFrog(f)
    --based on screen x and y, the bottom of the frog
    love.graphics.setColor(colors.frogGreen)
    love.graphics.rectangle('fill', f.x - (50/2), f.y - 50, 50, 50)

    --draw eye
    love.graphics.setColor(colors.black)
    love.graphics.circle('fill', f.x + (math.cos(f.angle)) * 20, f.y - (50/2) - (math.sin(f.angle)) * 20, 3)

end


-- TODO need to account for fluctuation between float positions
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

--TODO: add these functions to frog itself
function frogHop(f, b)
    
    local hopDistance = smallHop
    --if strong beat, hop more
    if b == 1 then
        hopDistance = bigHop
    end

    --make sure frog is touching floor
    if f.y > floor - 0.1 then
        f.xvel = f.xvel + hopDistance * math.cos(f.angle)
        local yboost = math.sin(f.angle)
        --if mouse is sufficiently low (horizontal or lower), make sure frog
        --still has some vertical velocity
        if yboost < 0.2 then
            yboost = 0.2
        end
        f.yvel = f.yvel + hopDistance * yboost
    end

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
    f.angle = math.atan2(f.y - mouseY, mouseX - f.x)
end
