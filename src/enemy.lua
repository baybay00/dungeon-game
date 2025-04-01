math.randomseed(os.time())

local enemies = {}

local directions = {
    {x = 0, y = -1}, -- up
    {x = 0, y = 1}, -- down
    {x = -1, y = 0}, -- left
    {x = 1, y = 0}, -- right
}

function enemies.spawn()
    return {
        x = math.random(50, love.graphics.getWidth() - 50),
        y = math.random(50, love.graphics.getHeight() -50),
        speed = 75,
        radius = math.random(10, 30),
        direction = directions[math.random(#directions)],
        changeTime = 0
    }
end

for i = 1, 10 do
    table.insert(enemies, enemies.spawn())
end

function enemies.update(dt)
    for _, enemy in ipairs(enemies) do
        enemy.x = enemy.x + (enemy.direction.x * enemy.speed * dt)
        enemy.y = enemy.y + (enemy.direction.y * enemy.speed * dt)

        enemy.x = math.max(0, math.min(enemy.x, love.graphics.getWidth()))
        enemy.y = math.max(0, math.min(enemy.y, love.graphics.getHeight()))

        enemy.changeTime = enemy.changeTime * dt
        if enemy.changeTime <= 0 then
            enemy.direction = directions[math.random(#directions)]
            enemy.changeTime = math.random(1, 2)
        end
    end
end

function enemies.draw()
    love.graphics.setColor(love.math.colorFromBytes(254, 210, 226))
    for _, enemy in ipairs(enemies) do
        love.graphics.circle("fill", enemy.x, enemy.y, enemy.radius)
    end
end

return enemies