function love.load()

    windowX = 800
    windowY = 600
    love.window.setMode(windowX, windowY)

    floor= 500

    timer = 0
    beat = 1
    tempo = 120
    frequency = tempo/60

    colors = {
        darkGreen = convertColor("184d47"),
        frogGreen = convertColor("96bb7c"),
        lightGreen = convertColor("d6efc7"),
        lightGrey = convertColor("aaaaaa"),
        logBrown = convertColor("661c07"),
        black = convertColor("000000"),
    }

    require("entities/base")
    require("entities/froeg")
    require("entities/log")

end

function love.update(dt)
    log:reset()
    log:setHitIfOutOfBounds()

    local frogx, frogy = frog:getScreenOrigin()
    log:checkCollision(frogx, frogy, frog.size, frog.size)

    frog:lookAtMouse()

    timer = timer + dt * frequency
    if timer > 1 then
        timer = timer - 1
        beat = beat + 1
        if beat > 3 then
            beat = beat - 3
        end
        frog:hop(beat)
    end

    log:move(dt)
    frog:move(dt)

end

function love.draw()
    love.graphics.setBackgroundColor(1, 1, 1)

    drawFloor(floor)

    frog:draw()
    log:draw()

    --DEBUG (temporary)
    love.graphics.setColor(0, 0, 0)
    love.graphics.print('coordinates: ('..
        (math.floor(10*frog.x)/10)..', '..
        (math.floor(10*frog.y)/10)..')'
        , 10, 10)

    love.graphics.print('velocity: ('..
        (math.floor(10*frog.xvel)/10)..', '..
        (math.floor(10*frog.yvel)/10)..')'
        , 10, 30)

    love.graphics.print('angle : '..(math.floor(10*frog.angle)/10), 10, 50)

    drawBeats(beat)
    
end

--helper functions

function convertColor(hexcode)
    --takes hexcode as a string, eg FFFFFF
    local hexes = {
        string.sub(hexcode, 1, 2),
        string.sub(hexcode, 3, 4),
        string.sub(hexcode, 5, 6),
    }
    local colorNumbers = {}
    for i, hex in ipairs(hexes) do
        table.insert(colorNumbers, tonumber(hex, 16)/255)
    end

    return colorNumbers
end

function drawFloor(floor)
    love.graphics.setColor(0, 0, 0)
    love.graphics.line(0, floor, windowX, floor)
end

function drawBeats(b)
    if b == 1 then
        love.graphics.setColor(colors.darkGreen)
    else
        love.graphics.setColor(colors.lightGreen)
    end
    love.graphics.circle('fill', windowX - ((4-b) * 50), 30, 20)

    --draw outines
    love.graphics.setColor(0.6, 0.6, 0.6)
    for i = 1, 3 do
        love.graphics.circle('line', windowX - (i * 50), 30, 20)
    end
end