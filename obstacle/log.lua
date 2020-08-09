-- log obstacle lives on the ground

-- TODO eventually have an array of objects on screen
-- and have that do garbage collection
-- x,y represent bottom center point
log = {
    x = windowX,
    y = floor,
    speed = 100,
    size = 15,
    is_hit = false
}

function draw_log(log)
    love.graphics.setColor(colors.logBrown)
    love.graphics.rectangle('fill', log.x - (log.size/2), log.y - log.size, log.size, log.size)
end

function log_is_out_of_bounds(log)
    if is_out_of_bounds(log) then
        log.is_hit = true
    end
end

-- continuously move log to the left
function move_log(log, dt)
    log.x = log.x - dt * log.speed
end

function reset_log(log)
    if log.is_hit then
        log.x = windowX
        log.is_hit = false
    end
end

-- AABB collision detection between self and other object
-- x,y are the top-left corner of the box
function check_collision_with_frog(log, x1, y1, w1, h1)
    local x2, y2 = coords_to_top_left(log)
    local w2 = log.size
    local h2 = log.size

    if x1 < x2+w2 and x2 < x1+w1 and y1 < y2+h2 and y2 < y1+h1 then 
        log.is_hit = true
    end
  end

-- TODO eventually have both frog and log extend a base object class
function is_out_of_bounds(o)
    if o.x - (o.size / 2) < 0 then
        return true
    end 
    return false
end

-- given an object's coordinates repesented as the object's bottom center
-- return its top left origin
function coords_to_top_left(o)
    return o.x - (o.size / 2), o.y - o.size
end