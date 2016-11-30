
require("collide")

function CreerHeros(pNmImage, px, py, pRot, pVx)
    heros = {}
    
    heros.img = love.graphics.newImage("images/"..pNmImage..".png")
    heros.x = px
    heros.y = py
    heros.rot = pRot
    heros.flip = 1
    heros.vx = pVx
    heros.sol = heros.y
    heros.poids = 0
    heros.saut = false
    
    table.insert(l_heros, heros)
    table.insert(l_sprites, heros)
    
    return heros
end