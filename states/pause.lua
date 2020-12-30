local Pause = Game:addState('Pause')

function Pause:enteredState()
end

function Pause:exitedState()
end

function Pause:draw()
    love.graphics.setBackgroundColor(colors.frogGreen)

    love.graphics.setColor(colors.darkBlue)
    love.graphics.print('game paused', windowX / 2, windowY / 2)
end

function Pause:keypressed(key, code)
    if key == 'escape' then
        self:popState('Pause')
    end
end