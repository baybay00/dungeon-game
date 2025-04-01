local utils = {}

function utils.checkCollision(a, b)
    return a.x < b.x + b.radius and
    a.x + a.width > b.x and
    a.y < b.y + b.radius and
    a.y + a.height > b.y
end

return utils