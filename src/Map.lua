require 'src.Util'

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
        ss = love.graphics.newImage('assets/sprites/Dungeon_Tileset.png'),
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
    this.tileSprites = Util:makeQuads(this.ss, 16, 16)
    this.spriteBatch = love.graphics.newSpriteBatch(this.ss, this.mapWidth * this.mapHeight)
    setmetatable(this, self)

    for y = 1, this.mapHeight do -- fill map with empty tiles
        for x = 1, this.mapWidth do
            this:setTile(x, y, TILE_ID.EMPTY.BLACK)
        end
    end

    local num_rooms = math.random(5, 10)
    for i = 1, num_rooms do
        local room = self:generateRoom()
        local roomX, roomY
    
        -- Try up to 10 times to find a valid position
        for attempt = 1, 10 do
            roomX = math.random(1, this.mapWidth - room.width)
            roomY = math.random(1, this.mapHeight - room.height)
    
            if self:canPlaceRoom(roomX, roomY, room.width, room.height) then
                self:setRoom(roomX, roomY, room)
                break
            end
        end
    end
    this:refreshSpriteBatch()
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

    for j = 1, room.height do
        for i = 1, room.width do
            local tileIndex = (j - 1) * room.width + i
            local mapX = x + i - 1
            local mapY = y + j - 1

            -- Ensure we don't go out of bounds
            if mapX <= self.mapWidth and mapY <= self.mapHeight then
                self:setTile(mapX, mapY, room.tiles[tileIndex])
            end
        end
    end
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

    for y = 1, room.height do
        for x = 1, room.width do
            local index = (y - 1) * room.width + x

            -- Place corners
            if x == 1 and y == 1 then
                room.tiles[index] = TILE_ID.WALLS.LEFT[1] -- Top-left corner
            elseif x == room.width and y == 1 then
                room.tiles[index] = TILE_ID.WALLS.RIGHT[1] -- Top-right corner
            elseif x == 1 and y == room.height then
                room.tiles[index] = TILE_ID.WALLS.LEFT[#TILE_ID.WALLS.LEFT] -- Bottom-left corner
            elseif x == room.width and y == room.height then
                room.tiles[index] = TILE_ID.WALLS.RIGHT[#TILE_ID.WALLS.RIGHT] -- Bottom-right corner

            -- Place top and bottom walls
            elseif y == 1 then
                room.tiles[index] = TILE_ID.WALLS.TOP[math.random(#TILE_ID.WALLS.TOP)]
            elseif y == room.height then
                room.tiles[index] = TILE_ID.WALLS.BOTTOM[math.random(#TILE_ID.WALLS.BOTTOM)]

            -- Place left and right walls
            elseif x == 1 then
                room.tiles[index] = TILE_ID.WALLS.LEFT[math.random(2, #TILE_ID.WALLS.LEFT - 1)]
            elseif x == room.width then
                room.tiles[index] = TILE_ID.WALLS.RIGHT[math.random(2, #TILE_ID.WALLS.RIGHT - 1)]

            -- Fill floor
            else
                room.tiles[index] = TILE_ID.FLOOR[math.random(#TILE_ID.FLOOR)]
            end

 
        end
    end

    return room
end

function Map:canPlaceRoom(x, y, width, height)
    if x < 1 or y < 1 then
    -- or x + width - 1 > self.mapWidth or y + height - 1 > self.mapHeight then
        return false
    end

    -- Check if all tiles in the room's area are EMPTY.BLACK
    for j = 0, height - 1 do
        for i = 0, width - 1 do
            local tile = self:getTile(x + i, y + j)
            if tile ~= TILE_ID.EMPTY.BLACK then
                return false
            end
        end
    end
    return true
end

function Map:refreshSpriteBatch() -- from cs50/mario-demo
    -- sprite batch for efficient tile rendering
    self.spriteBatch = love.graphics.newSpriteBatch(self.ss, self.mapWidth *
    self.mapHeight)
    -- create sprite batch from tile quads
    for y = 1, self.mapHeight do
        for x = 1, self.mapWidth do
            self.spriteBatch:add(self.tileSprites[self:getTile(x, y)],
                (x - 1) * self.tileWidth, (y - 1) * self.tileHeight)
        end
    end
end

function Map:connectRooms()

end


function Map:render()
    love.graphics.draw(self.spriteBatch)
end