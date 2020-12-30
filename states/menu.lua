local Menu = Game:addState('Menu')

function Menu:enteredState()
    self.printSecret = false

    menu = MenuUI.new()
    menu:addItem {
		name = 'Start',
		action = function()
			self:popState('Menu')
		end
    }
    menu:addItem {
		name = 'Options',
        action = function()
            self.printSecret = true
		end
	}
    menu:addItem {
		name = 'Quit',
		action = function()
			love.event.quit(0)
		end
	}
end

function Menu:update(dt)
    menu:update(dt)
end

function Menu:draw()
    menu:draw(const.WINDOW_X / 2 - 175, const.WINDOW_Y / 2 - 100)
    if self.printSecret then 
        love.graphics.setColor(1, 1, 1)
        love.graphics.print('froeg 8)~~*', 10, 10)
    end
end

function Menu:keypressed(key, code)
    menu:keypressed(key)
end