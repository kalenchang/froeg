function love.load()
    windowX = 800
    windowY = 600
    love.window.setMode(windowX, windowY)

    horizon = 0.8 --what percent from the bottom of the screen
    origin = 0.2 --what percent from the bottom of the screen
    viewDist = 5 --idk the units...
    gridSize = 100 --in px

    --create a grid based system 
    --for now, let's say x/y goes from -25 to 25
    maxX = 25
    maxY = 25

    frog = {
        x = 0,
        y = 0,
        z = 0,
        speed = 5
    }
    frogGrid = {
        x = 0,
        y = 0,
        z = 0
    }
    frogScreen = {
        x = 0,
        y = 0,
        z = 0
    }


    minimapX = 50
    minimapY = 50
end

function love.update(dt)
    if love.keyboard.isDown('right') then
        frog.x = frog.x + dt * frog.speed
    end
    if love.keyboard.isDown('left') then
        frog.x = frog.x - dt * frog.speed
    end
    if love.keyboard.isDown('up') then
        frog.y = frog.y + dt * frog.speed
    end
    if love.keyboard.isDown('down') then
        frog.y = frog.y - dt * frog.speed
    end

    frogGrid.x, frogGrid.y, frogGrid.z = worldToGrid(frog.x, frog.y, frog.z, viewDist)
    frogScreen.x, frogScreen.y, frogScreen.z = gridToScreen(frogGrid.x, frogGrid.y, frogGrid.z, gridSize)


end

function love.draw()
    love.graphics.setBackgroundColor(1, 1, 1)

    love.graphics.setColor(0.3, 0.8, 0.5)
    --draw horizon
    local horizonY = (1-horizon) * windowY
    love.graphics.line(0, horizonY, windowX, horizonY)

    love.graphics.setColor(0, 0, 0)
    --draw minimap
    love.graphics.circle('fill', frog.x + 25, 25 - frog.y, 2)

    drawFrog(frogScreen.x, frogScreen.y, 1 - frogGrid.y)

    love.graphics.setColor(0, 0, 0)
    love.graphics.print('grid: ('..
        (math.floor(10*frogGrid.x)/10)..', '..
        (math.floor(10*frogGrid.y)/10)..', '..
        (math.floor(10*frogGrid.z)/10)..')'
        , 10, 10)
    love.graphics.print('screen: ('..
        math.floor(frogScreen.x)..', '..
        math.floor(frogScreen.y)..', '..
        math.floor(frogScreen.z)..')'
        , 10, 20)

    
end

--grid: y is a range from 0 to 1
--x and z range from whatever you want (same as world)
function worldToGrid (worldX, worldY, worldZ, viewDist)
    local gridY = worldY / (viewDist + worldY)
    local gridX = (1 - gridY) * worldX
    local gridZ = (1 - gridY) * worldZ
    return gridX, gridY, gridZ
end

function gridToScreen(gridX, gridY, gridZ, gridSize)
    local originY = (1 - origin) * windowY
    local horizonY = (1 - horizon) * windowY

    local screenX = gridX * gridSize + windowX / 2
    local screenY = originY - gridY * (originY - horizonY)
    local screenZ = gridZ * gridSize

    --actually, when rendering the sprite, the real Y should be screenY-screenZ
    --however, we return both so we can properly render a shadow, for instance
    return screenX, screenY, screenZ
end

function drawFrog(x, y, scale)
    --based on screen x and y, the bottom of the frog
    local size = scale * 50
    love.graphics.setColor(0.3, 0.8, 0.5)
    love.graphics.rectangle('fill', x - (size/2), y - size, size, size)

end