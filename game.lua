class = require 'lib/middleclass'
stateful = require 'lib/stateful'
MenuUI = require '/lib/menuui'

Game = class('Game'):include(stateful)

require 'states/menu'
require 'states/pause'

function Game:initialize()
    self:gotoState('Menu')

    translateX = 0
    translateY = 0

    require 'entities/base'
    require 'entities/froeg'
    require 'entities/log'
    require 'entities/tree'
    
    entities = {
        frog = Frog(100, const.FLOOR, 50),
        log = Log(const.WINDOW_X - 200, const.FLOOR, 15),
        log2 = Log(const.WINDOW_X, const.FLOOR, 15),
        tree = Tree(const.WINDOW_X, const.FLOOR, 100, 300, -30)
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

    const.TIMER = const.TIMER + dt * const.FREQ
    if const.TIMER > 1 then
        const.TIMER = const.TIMER - 1
        const.BEAT = const.BEAT + 1
        if const.BEAT > 3 then
            const.BEAT = const.BEAT - 3
        end
        entities.frog:hop(const.BEAT)
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

    drawFloor(const.FLOOR)

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

    love.graphics.print('topvelocity: '..
        (math.floor(10*entities.frog.testvel)/10)
        , 10, 110)


    drawBeats(const.BEAT)
end

function Game:keypressed(key, code)
  -- Pause game
  if key == 'escape' then
    self:pushState('Pause')
  end
end

function Game:mousepressed(x, y, button, isTouch)
end
