local utils = {}

function utils.checkCollision(a, b)
    return a.x < b.x + b.radius and
    a.x + a.width > b.x and
    a.y < b.y + b.radius and
    a.y + a.height > b.y
end

function utils.makeQuads(atlas, tileWidth, tileHeight) --taken from cs50 mario-demo
    local sheetWidth = atlas:getWidth() / tileWidth
    local sheetHeight = atlas:getHeight() / tileHeight

    local sheetCounter = 1
    local quads = {}

    for j = 0, sheetHeight - 1 do
        for i = 0, sheetWidth - 1 do
            quads[sheetCounter] = love.graphics.newQuad(i * tileWidth, j * tileHeight, tileWidth, tileHeight, atlas:getDimensions())
            sheetCounter = sheetCounter + 1
        end
    end
    return quads
end

return utils