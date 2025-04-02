local utils = require ('src.util')

Map = {}
Map.__index = Map

function Map:create()
    local this = {
        ss = love.graphics.newImage('assets.sprites.Dungeon_Tileset.png'),
        -- add music here later,
        tileWidth = 16,
        tileHeight = 16,
        mapWidth = 100,
        mapHeight = 100,
        tile = {},
        camX = 0, --tweak??
        camY = 0,
    }

    this.mapWidthPixels = this.mapWidth * this.tileWidth
    this.mapHeightPixels = this.mapHeight * this.tileHeight

    this.spriteBatch = love.graphics.newSpriteBatch(this.ss, this.mapWidth * this.mapHeight)

    setmetatable(this, self)

    for j = 1, this.mapHeight do
        for i = 1, this.mapWidth do

        end
    end
end

function Map:setTile(x, y, tile)
    self.tiles[(y - 1) * self.mapWidth + x] = tile
end
