class = require 'lib/middleclass'
stateful = require 'lib/stateful'
MenuUI = require '/lib/menuui'

Game = class('Game'):include(stateful)

require 'states/menu'
require 'states/pause'

function Game:initialize()
    self:gotoState('Menu')

    windowX = 800
    windowY = 600
    love.window.setMode(windowX, windowY)
    love.window.setTitle('froeg')

    translateX = 0
    translateY = 0

    floor= 500

    timer = 0
    beat = 1
    tempo = 120
    frequency = tempo/60

    colors = {
        darkGreen = convertColor('184d47'),
        frogGreen = convertColor('89ab35'),
        lightGreen = convertColor('d6efc7'),
        lightGrey = convertColor('aaaaaa'),
        logBrown = convertColor('661c07'),
        black = convertColor('000000'),
        treeGreen = convertColor('35a959'),
        darkBlue = convertColor('0c1675')
    }

    require 'entities/base'
    require 'entities/froeg'
    require 'entities/log'
    require 'entities/tree'
    
    entities = {
        frog = Frog(100, floor, 50),
        log = Log(windowX - 200, floor, 15),
        log2 = Log(windowX, floor, 15),
        tree = Tree(windowX, floor, 100, 300, -30)
    }

end

function Game:exit()
end

function Game:update(dt)
    local frogx, frogy = entities.frog:getScreenOrigin()

    for ename, eobj in pairs(entities) do
        if not eobj.isCharacter then
            eobj:reset()
            eobj:setHitIfOutOfBounds()
            if eobj.isLog then
                eobj:checkCollision(frogx, frogy, entities.frog.sizeX, entities.frog.sizeY)
            end
        end
    end


    entities.frog:lookAtMouse()

    timer = timer + dt * frequency
    if timer > 1 then
        timer = timer - 1
        beat = beat + 1
        if beat > 3 then
            beat = beat - 3
        end
        entities.frog:hop(beat)
    end

    for ename, eobj in pairs(entities) do
        eobj:move(dt)
    end
    
    --move camera 50px per sec right
    translateX = translateX - dt * 50
end

function Game:draw()
    love.graphics.setBackgroundColor(1, 1, 1)

    love.graphics.push()

    love.graphics.translate(translateX, translateY)

    for ename, eobj in pairs(entities) do
        if eobj.isbg then
            eobj:draw()
        end
    end
    for ename, eobj in pairs(entities) do
        if not eobj.isbg then
            eobj:draw()
        end
    end
    love.graphics.pop()

    drawFloor(floor)

    --DEBUG (temporary)
    love.graphics.setColor(0, 0, 0)
    love.graphics.print('coordinates: ('..
        (math.floor(10*entities.frog.x)/10)..', '..
        (math.floor(10*entities.frog.y)/10)..')'
        , 10, 10)

    love.graphics.print('velocity: ('..
        (math.floor(10*entities.frog.xvel)/10)..', '..
        (math.floor(10*entities.frog.yvel)/10)..')'
        , 10, 30)

    love.graphics.print('angle : '..(math.floor(10*entities.frog.angle)/10), 10, 50)

    love.graphics.print('mouse: ('..
        (math.floor(10*love.mouse.getX())/10)..', '..
        (math.floor(10*love.mouse.getY())/10)..')'
        , 10, 70)

    love.graphics.print('translate: ('..
        (math.floor(10*translateX)/10)..', '..
        (math.floor(10*translateY)/10)..')'
        , 10, 90)


    drawBeats(beat)
end

function Game:keypressed(key, code)
  -- Pause game
  if key == 'escape' then
    self:pushState('Pause')
  end
end

function Game:mousepressed(x, y, button, isTouch)
end

-- helper functions

function convertColor(hexcode)
    -- takes hexcode as a string, eg FFFFFF
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
    love.graphics.setColor(colors.black)
    love.graphics.line(0, floor, windowX, floor)
end

function drawBeats(b)
    if b == 1 then
        love.graphics.setColor(colors.darkGreen)
    else
        love.graphics.setColor(colors.lightGreen)
    end
    love.graphics.circle('fill', windowX - ((4-b) * 50), 30, 20)

    -- draw beat outines
    love.graphics.setColor(0.6, 0.6, 0.6)
    for i = 1, 3 do
        love.graphics.circle('line', windowX - (i * 50), 30, 20)
    end
end