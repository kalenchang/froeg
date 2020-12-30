require 'util'

const = {
    -- love2d configuration
    WINDOW_X = 800,
    WINDOW_Y = 600,

    -- game constants
    FLOOR = 500,
    TIMER = 0,
    BEAT = 1,
    TEMPO = 120,
    FREQ = 2  -- TEMPO / 60
}

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