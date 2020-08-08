function love.load()
    windowX = 800
    windowY = 600
    love.window.setMode(windowX, windowY)

    floor= 500

    timer = 0
    beat = 1
    tempo = 60

    gravy = 500

    frog = {
        x = 100,
        y = floor,
        speed = 300, -- not used rn
        angle = math.pi/3,
        xvel = 0,
        yvel = 0,
    }

    colors = {
        darkGreen = convertColor("184d47"),
        frogGreen = convertColor("96bb7c"),
        lightGreen = convertColor("d6efc7"),
        lightGrey = convertColor("aaaaaa"),
    }
end

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

function love.update(dt)
    local frequency = tempo/60

    timer = timer + dt * frequency
    if timer > 1 then
        timer = timer - 1
        beat = beat + 1
        if beat > 3 then
            beat = beat - 3
        end
        frogHop(frog, beat)
    end

    frogMove(frog, dt)

    --moveToMouse(dt)

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

    love.graphics.print('velocity: ('..
        (math.floor(10*frog.xvel)/10)..', '..
        (math.floor(10*frog.yvel)/10)..')'
        , 10, 30)

    drawBeats(beat)
    
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

--TODO: add these functions to frog itself
function frogHop(f, b)
    local hopDistance = 100
    if b == 1 then
        hopDistance = 250
    end
    f.xvel = f.xvel + hopDistance * math.cos(f.angle)
    f.yvel = f.yvel + hopDistance * math.sin(f.angle)

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