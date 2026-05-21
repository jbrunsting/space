function love.draw()
    love.graphics.print("Hello World", 400, 300)
    love.graphics.print("Hello", 400, 200)
end

function love.load()
    Clicks = tonumber((love.filesystem.read("save.txt"))) or 0
end

function love.quit()
    love.filesystem.write("save.txt", tostring(Clicks))
end
