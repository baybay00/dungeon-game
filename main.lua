require 'Map'
require 'Player'
require 'Enemy'

function love.load()
    love.window.setMode(1900, 1080)
    
end

function love.update(dt)
    player.update(dt)
end

function love.draw()
    map:render()
    player.draw()

end