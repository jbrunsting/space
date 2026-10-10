local physics = require("physics")

function love.update(dt)
    physics:update(dt)
    if love.keyboard.isDown("d") or love.keyboard.isDown("right") then
        physics:updateAngle(-dt)
    elseif love.keyboard.isDown("a") or love.keyboard.isDown("left") then
        physics:updateAngle(dt)
    end
    if love.keyboard.isDown("space") then
        physics:accelerate(dt)
    end
end

function love.draw()
    local width, height = love.graphics.getDimensions()
    local x_center = width / 2
    local y_center = height / 2
    love.graphics.setColor(1, 1, 1)
    love.graphics.circle("fill", physics.x_offset, physics.y_offset, 100)
    love.graphics.circle("fill", physics.x_offset + 400, physics.y_offset + 200, 100)
    love.graphics.setColor(1, 0, 0)
    love.graphics.polygon(
        "fill",
        x_center - 20 * math.sin(physics.angle),
        y_center - 20 * math.cos(physics.angle),
        x_center + 20 * math.sin(physics.angle + math.pi / 4),
        y_center + 20 * math.cos(physics.angle + math.pi / 4),
        x_center + 20 * math.sin(physics.angle - math.pi / 4),
        y_center + 20 * math.cos(physics.angle - math.pi / 4)
    )
end

function love.load()
    local clicks = tonumber((love.filesystem.read("save.txt"))) or 0
    print (clicks)
end

function love.quit()
    love.filesystem.write("save.txt", tostring(10))
end
