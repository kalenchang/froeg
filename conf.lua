require 'constants'

function love.conf(t)
    t.identity = "froeg"
    t.version = "11.1"
    t.console = false

    t.window.title = "froeg"
    t.window.icon = nil
    t.window.width = const.WINDOW_X
    t.window.height = const.WINDOW_Y
    t.window.borderless = false
    t.window.resizable = false
    t.window.fullscreen = false
    t.window.vsync = true

end