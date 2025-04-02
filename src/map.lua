local utils = require ('src.util')

Map = {}
Map.__index = Map

TILE_ID = {
    WALLS = {
        TOP = {2, 3, 4, 5},
        BOTTOM = {42, 43, 44, 45},
        LEFT = {1, 11, 21, 31, 41},
        RIGHT = {6, 16, 26, 36, 46},
    },
    DOORS = {
        FORWARD = {37, 38},
        LEFT = {48, 58},
        RIGHT = {49, 59},
        BOSS = {67, 68},
    },
    FLOOR = {7, 8, 9, 10, 17, 18, 19, 20, 27, 28, 29, 30},
    EMPTY = {
        BLACK = 79,
        BROWN = 70,
        PURPLE = 80,
    }
}


function Map:create()
    local this = {
        ss = love.graphics.newImage('assets.sprites.Dungeon_Tileset.png'),
        -- add music here later,
        tileWidth = 16,
        tileHeight = 16,
        mapWidth = 32,
        mapHeight = 32,
        tiles = {},
        rooms = {},
        camX = 0, --tweak??
        camY = 0,
    }

    this.mapWidthPixels = this.mapWidth * this.tileWidth
    this.mapHeightPixels = this.mapHeight * this.tileHeight
    this.spriteBatch = love.graphics.newSpriteBatch(this.ss, this.mapWidth * this.mapHeight)
    setmetatable(this, self)

    for j = 1, this.mapHeight do -- fill map with empty tiles
        for i = 1, this.mapWidth do
            this:setTile(i, j, TILE_ID.EMPTY.BLACK)
        end
    end

    local num_rooms = math.random(5, 10)
    for i = 1, num_rooms do
        local roomX = math.random(1, this.mapWidth - 8)
        local roomY = math.random(1, this.mapHeight - 8)
        local room = this:generateRoom()
        this:setRoom(roomX, roomY, room)
    end

    return this
end

function Map:getTile(x, y)
    return self.tiles[(y - 1) * self.mapWidth + x]
end

function Map:setTile(x, y, tile)
    self.tiles[(y - 1) * self.mapWidth + x] = tile
end

function Map:setRoom(x, y, room)
    self.rooms[(y - 1) * self.mapWidth + x] = room
end

function Map:getRoom(x, y)
    return self.rooms[(y - 1) * self.mapWidth + x]
end

function Map:generateRoom()
    local room = {
        tiles = {},
        width = math.random(4, 8),
        height = math.random(4, 8)
    }

    -- -- ensure corners are always corners
    -- room.tiles[1] = TILE_ID.WALLS.LEFT[1] 
    -- room.tiles[(maxRoomHeight - 1) * maxRoomWidth] = TILE_ID.WALLS.RIGHT[5] 
    -- room.tiles[maxRoomWidth] = TILE_ID.WALLS.RIGHT[1]
    -- room.tiles[((maxRoomHeight - 1) * maxRoomWidth) - maxRoomWidth] = TILE_ID.WALLS.LEFT[5]

    -- -- set top walls
    -- for i = 2, maxRoomWidth do 
    --     local randIdx= math.random(1, #TILE_ID.WALLS.TOP)
    --     local randElement = TILE_ID.WALLS.TOP[randIdx]
    --     room.tiles[i] = randElement
    -- end

    -- -- set left and right walls
    -- for i = maxRoomWidth + 1, ((maxRoomHeight - 1) * maxRoomWidth) - maxRoomWidth do 
    --     local FLAG = true -- true for left false for right
    --     local randIdx = math.random(1, #TILE_ID.WALLS.LEFT) -- can use same idx for left and right since they are same length
    --     local randElem_l = TILE_ID.WALLS.LEFT[randIdx]
    --     local randElem_r = TILE_ID.WALLS.RIGHT[randIdx]
    --     room.tiles[i] = randElem_l

    --     if FLAG then --alternates setting left or right wall 
    --         room.tiles[i] = randElem_r
    --         FLAG = false
    --     end
    -- end

    -- -- set bottom walls
    -- for i = #room.tiles, (maxRoomHeight - 1) * maxRoomWidth do 
    --     local randIdx = math.random(1, #TILE_ID.WALLS.BOTTOM)
    --     local randElem = TILE_ID.WALLS.BOTTOM[randIdx]
    --     room.tiles[i] = randElem
    -- end

    -- -- fill in the rest with floor
    -- for j = 2, maxRoomHeight - 1 do
    --     for i = 2 + maxRoomWidth, maxRoomWidth - 1 do
    --         local randIdx = math.random(1, #TILE_ID.WALLS.BOTTOM)
    --         local randElem = TILE_ID.FLOOR[randIdx]
    --         room.tiles[i] = randElem
    --     end
    -- end
end
