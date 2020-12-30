require 'util'

const = {
    -- love2d configuration
    WINDOW_X = 800,
    WINDOW_Y = 600,

    -- game constants
    FLOOR = 500,
    TIMER = 0, --how is this a constant?
    BEAT = 1, --how is this a constant?
    TEMPO = 100,
    FREQ = 100 / 60  -- TEMPO / 60
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