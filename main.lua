require 'src.Map'
require 'src.Player'
require 'src.Enemy'

local map = Map:create()
-- local player = Player:create()

function love.load()
    love.window.setMode(1900, 1080)
end

function love.update(dt)
    -- player.update(dt)
end

function love.draw()
    map:render()
    -- player.draw()
end