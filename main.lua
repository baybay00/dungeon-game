local player = require("src/player")
local enemies = require("src/enemy")
local utils = require("src/util")

function love.load()
    love.window.setMode(1900, 1080)
end

function love.update(dt)
    player.update(dt)
    enemies.update(dt)

    for _, enemy in ipairs(enemies) do
        if utils.checkCollision(player, enemy) then Dead = true end
    end
end

function love.draw()
    -- local s_width = love.graphics.getWidth()
    -- local s_height = love.graphics.getHeight()

    -- local cam_x = -player.x + s_width/2 - player.width/2
    -- local cam_y = -player.y + s_height/2 - player.height/2

    -- love.graphics.push()
    -- love.graphics.translate(cam_x, cam_y)


    if Dead == true then
        love.graphics.clear()
        love.graphics.print("Dead", love.graphics.getWidth() / 2, love.graphics.getHeight() / 2)
    else
        player.draw()
        enemies.draw()
    end

    -- love.graphics.pop()
end