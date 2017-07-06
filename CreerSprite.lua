

function CreerSprite(pNmImage, pX, pY)
    sprite = {}
    
    sprite.x = pX
    sprite.y = pY
    sprite.img = love.graphics.newImage("images/"..pNmImage..".png")
    sprite.rot = pRot
    sprite.supp = false
    sprite.flip = 1
    
    table.insert(l_sprites, sprite)
    return sprite
end

function CreerTir(pNmImage, pX, pY ,pOrien)
  tir = {}
  
  tir.img = love.graphics.newImage("images/"..pNmImage..".png")
  tir.x = pX
  tir.y = pY
  tir.rot = 0
  tir.orientation = pOrien
  tir.supp = false
  tir.l = tir.img:getWidth()
  tir.h = tir.img:getHeight()
  
  table.insert(l_tirs, tir)
  return tir
end
    

function CreerEnnemis(pNmImage, pX, pY, pVal)
    ennemi = {}
    
    ennemi.x = pX
    ennemi.y = pY
    ennemi.vx = math.random(1, 2) -- vitesse aléatoire de l'ennemi
    ennemi.img = love.graphics.newImage("images/"..pNmImage..".png")
    ennemi.rot = pRot
    ennemi.supp = false
    ennemi.flip = 1
    ennemi.valeur = pVal
    
    table.insert(l_ennemis, ennemi)
    --table.insert(l_sprites, ennemi)
    return ennemi
end