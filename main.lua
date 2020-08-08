function love.load()
    windowX = 800
    windowY = 600
    love.window.setMode(windowX, windowY)

    frog = {
        x = 300,
        y = 300,
        speed = 300
    }
end

function love.update(dt)
    moveToMouse(dt)

end

function love.draw()
    love.graphics.setBackgroundColor(1, 1, 1)

    love.graphics.setColor(0.3, 0.8, 0.4)

    drawFrog(frog.x, frog.y)

    love.graphics.setColor(0, 0, 0)
    love.graphics.print('coordinates: ('..
        (math.floor(10*frog.x)/10)..', '..
        (math.floor(10*frog.y)/10)..')'
        , 10, 10)
    
end

function drawFrog(x, y)
    --based on screen x and y, the bottom of the frog
    love.graphics.setColor(0.3, 0.8, 0.5)
    love.graphics.rectangle('fill', x - (50/2), y - 50, 50, 50)

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