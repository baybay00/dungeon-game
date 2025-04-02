local player = {
    x = math.random(50, love.graphics.getWidth() - 50),
    y = math.random(50, love.graphics.getHeight() - 50),
    speed = 100,
    width = 75,
    height = 75,
}


function player.update(dt)
    if love.keyboard.isDown("w") or love.keyboard.isDown("up") then
        player.y = player.y - player.speed * dt
    end
    if love.keyboard.isDown("s") or love.keyboard.isDown("down") then
        player.y = player.y + player.speed * dt
    end
    if love.keyboard.isDown("a") or love.keyboard.isDown("left") then
        player.x = player.x - player.speed * dt
    end
    if love.keyboard.isDown("d") or love.keyboard.isDown("right") then
        player.x = player.x + player.speed * dt
    end

    local s_width = love.graphics.getWidth()
    local s_height = love.graphics.getHeight()

    player.x = math.max(0, math.min(player.x, s_width - player.width))
    player.y = math.max(0, math.min(player.y, s_height - player.height))

end

function player.draw()
    love.graphics.setColor(love.math.colorFromBytes(143, 135, 241))
    love.graphics.rectangle("fill", player.x, player.y, player.width, player.height)
end

return player
