local physics = require("physics")

local planets = {}

local accumulated_dt = 0

function love.update(dt)
    accumulated_dt = accumulated_dt + dt
    local dt_step = 1 / 6000
    while accumulated_dt > dt_step do
        accumulated_dt = accumulated_dt - dt_step
        physics:update(dt_step, planets)
        if love.keyboard.isDown("d") or love.keyboard.isDown("right") then
            physics:updateAngle(-dt_step)
        elseif love.keyboard.isDown("a") or love.keyboard.isDown("left") then
            physics:updateAngle(dt_step)
        end
        if love.keyboard.isDown("w") or love.keyboard.isDown("up") then
            physics:accelerate(dt_step)
        end
    end
end

function love.draw()
    local width, height = love.graphics.getDimensions()
    local x_center = width / 2
    local y_center = height / 2
    love.graphics.setColor(1, 1, 1)

    for i, planet in ipairs(planets) do
        love.graphics.circle("fill", x_center + planet.x + physics.x_offset, y_center + planet.y + physics.y_offset, planet.radius)
    end

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

    local function createPlanet(x, y, radius, mass)
        return {
            x = x,
            y = y,
            radius = radius,
            mass = mass
        }
    end

--    table.insert(planets, createPlanet(100, 180, 30, 0))
--    table.insert(planets, createPlanet(-300, -200, 40, 0))
    table.insert(planets, createPlanet(300, -120, 60, 1000000))
end

function love.quit()
    love.filesystem.write("save.txt", tostring(10))
end
