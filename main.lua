local physics = require("physics")

function love.update(dt)
    physics:update(dt)
end

function love.draw()
    local width, height = love.graphics.getDimensions()
    love.graphics.circle("fill", width / 2 + physics.offset, height / 2, 100)
end

function love.load()
    local clicks = tonumber((love.filesystem.read("save.txt"))) or 0
    print (clicks)
end

function love.quit()
    love.filesystem.write("save.txt", tostring(10))
end
