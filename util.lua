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
    love.graphics.line(0, floor, const.WINDOW_X, floor)
end

function drawBeats(b)
    if b == 1 then
        love.graphics.setColor(colors.darkGreen)
    else
        love.graphics.setColor(colors.lightGreen)
    end
    love.graphics.circle('fill', const.WINDOW_X - ((4-b) * 50), 30, 20)

    -- draw beat outines
    love.graphics.setColor(0.6, 0.6, 0.6)
    for i = 1, 3 do
        love.graphics.circle('line', const.WINDOW_X - (i * 50), 30, 20)
    end
end