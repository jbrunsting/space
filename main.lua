local physics = require("physics")

function love.update(dt)
    physics:update(dt)
    if love.keyboard.isDown("d") or love.keyboard.isDown("right") then
        physics:updateAngle(dt)
    elseif love.keyboard.isDown("a") or love.keyboard.isDown("left") then
        physics:updateAngle(-dt)
    end
end

function love.draw()
    local width, height = love.graphics.getDimensions()
    love.graphics.circle("fill", physics.x_offset, physics.y_offset, 100)
    love.graphics.circle("fill", physics.x_offset + 400, physics.y_offset + 200, 100)
    local x_center = width / 2 + physics.x_offset
    local y_center = height / 2 + physics.y_offset
--    love.graphics.triangle("fill", , height / 2 + physics.y_offset, 100)
--    love.graphics.triangle( mode, x1, y1, x2, y2, x3, y3 )
end

function love.load()
    local clicks = tonumber((love.filesystem.read("save.txt"))) or 0
    print (clicks)
end

function love.quit()
    love.filesystem.write("save.txt", tostring(10))
end
