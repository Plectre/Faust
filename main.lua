-- Cette ligne permet d'afficher des traces dans la console pendant l'éxécution
io.stdout:setvbuf('no')

-- Empèche Love de filtrer les contours des images quand elles sont redimentionnées
-- Indispensable pour du pixel art
love.graphics.setDefaultFilter("nearest")

-- Cette ligne permet de déboguer pas à pas dans ZeroBraneStudio
if arg[#arg] == "-debug" then require("mobdebug").start() end


require("conf")
require("CreerSprite")
require("Heros")
require("map")
require("collide")

-- getWindowMode
largeur = love.graphics.getWidth()
hauteur= love.graphics.getHeight()
hauteurSaut = 1000
pesenteur = 4 * hauteurSaut

l_heros = {}
l_tirs = {}
l_sprites = {}
l_tiles = {}
l_ennemis = {}

-- Et un tableau de tuiles un!!!!!
local n
l_ImgTiles = {}
for n =1,2 do
  l_ImgTiles[n] = love.graphics.newImage("images/Plat_"..n..".png")
end

function StartGame()
  -- Load images GUI
  ui_Up = love.graphics.newImage("images/gui.png")
  -- Création de la map
  Map()
  largeurTile = l_ImgTiles[1]:getWidth()
  
    -- creation du heros ==> l_sprites
  heros = CreerHeros("1", largeur/2, hauteur, 0,0)
  hauteurHeros = heros.img:getHeight()
  largeurHeros = heros.img:getWidth()

end

function AppelTirs(pOrientationTir)
  
  tir = CreerTir("faux_r", heros.x, (heros.y - hauteurHeros), pOrientationTir)

end

function love.load()
  StartGame()
end

function love.update(dt)
  -- Mouvement Ennemis
  for i = #l_ennemis,1, -1 do
    local en = l_ennemis[i]
    en.x = en.x + en.vx
    if en.x >= largeur then
      table.remove(l_ennemis, i)
      en.supp = true
    end
  end
  
  -- gestion collision tir/mechant
  for t = #l_tirs, 2, -1  do
    for e = #l_ennemis,1 ,-1 do
      local en = l_ennemis[e]
      local tir = l_tirs[t]
      if tir.x >= en.x + en.img:getWidth() -- trop à droite
          or tir.x + tir.img:getWidth() <= en.x -- trop à gauche
          or tir.y >= en.y + en.img:getHeight() -- trop bas
          or tir.y + tir.img:getHeight() <= en.y then -- trop haut
            --print ("a cotés")
      else
        table.remove(l_tirs, t)
        table.remove(l_ennemis, e)
        end
    end
  end
  
  
  if heros.saut == false then
      heros.poids = pesenteur
      heros.y = heros.y + pesenteur/8 * dt
      collider()
  end
  

	  --aprés l'appuie de la touche le heros.vx est <> de 0
  if heros.vx ~= 0 then
    heros.y = heros.y - (heros.vx*dt) -- il saute jusqu'a que la pesenteur soit plus grande 
    heros.vx = heros.vx - pesenteur * dt -- on diminue heros.vx en augmentant la pesenteur

    if heros.vx < 0  then -- Faust redescent
    	-- Le test de collision ICI 
    	 -- ........................
    	 collider()
		-- ..........................
    end
  end

  if heros.y >= hauteur then
    heros.y = hauteur
    heros.vx = 0
  end
  
  if love.keyboard.isDown("right") then
    if heros.x+largeurHeros >= largeur then
        heros.x = largeur - largeurHeros
    end
    heros.flip = 1
    heros.x = heros.x + 5
  end
  
  if love.keyboard.isDown("left") then
    if heros.x - largeurHeros <= 0 then
      heros.x = largeurHeros
    end
    heros.flip = -1
    heros.x = heros.x - 5
  end

  -- Tirs à GAUCHE
  if heros.flip == -1 then 
    local n
    -- Là on parcours la liste des tirs
    -- et on les fait se deplacer
    for n = #l_tirs,1, -1 do
      local tir = l_tirs[n]
      if tir.orientation == -1  then
      tir.x = tir.x - 10
    else
      tir.x= tir.x + 10
  end
    -- Rotation de la faux
    tir.rot = tir.rot - dt * math.pi/0.5
  -- Si le tir sort de l'ecran on le retire de la table l_tirs
    if tir.x >= largeur or tir.x <=0 then
      table.remove(l_tirs, n)
    -- on passe la propriete a true afin de tagger le tir
    -- pour l'effacer aussi de la table l_sprites
      tir.supp = true
    end
  end
end

-- Tirs à DROITE
 if heros.flip == 1 then
    local n
    for n = #l_tirs,1, -1 do
      local tir = l_tirs[n]
      if tir.orientation == 1 then
        tir.x = tir.x + 10
      else
        tir.x = tir.x - 10
      end
  -- Rotation de la faux
  tir.rot = tir.rot - dt * math.pi/0.5

  -- Si le tir sort de l'ecran on le retire de la table l_tirs
    if tir.x >= largeur or tir.x <=0 then
      table.remove(l_tirs, n)
      -- on passe la propriete a true afin de tagger le tir
      -- pour l'effacer aussi de la table l_sprites
      tir.supp = true
    end
  end
 end
    -- On parcours la table l_sprite à l'envers
  -- si on trouve un l_sprite taggé sprite.supp == true
  -- on le retire de la table l_sprite
  for n = #l_sprites,1, -1 do
    if l_sprites[n].supp == true then
      table.remove(l_sprites, n)
      --tir.supp = true
    end
  end
end


function love.draw()
  
  -- GUI ..............................
  love.graphics.draw(ui_Up, 80, 450, 0, 1, 1,ui_Up:getWidth()/2, ui_Up:getHeight()/2)
--...............................................
  -- Dessin du niveau
      local l,c
      local x = 0
      local y = 0
  for l = 1,#niveau do
    for c = 1,25 do
      local n = niveau[l][c]
      if n == 1 then
        local tile = {}
        tile.x = x
        tile.y = y
        table.insert(l_tiles, tile)
        love.graphics.draw(l_ImgTiles[n], x, y, 0, 1, 1)
        x = x + 32
      end        
      if n == 2 then

        CreerEnnemis("Plat_2", x, y)
        niveau[l][c] = "0" -- On remplace l'ennemi par 0 pour ne pas les redessiner à chaque update de draw
        x = x + 32
      end
      if n == 0 then 
          x = x + 32
      end
  end
    y = y + 32
    x = 0
end
  
  
  local n
  -- On parcours la table des tirs et on dessine
  -- tous ce que l'on y trouve
  for n = #l_tirs, 1, -1 do
    local sp
    sp = l_tirs[n]
    love.graphics.draw(sp.img, sp.x, sp.y, sp.rot,1, 1)
        love.graphics.circle("fill", sp.x, sp.y, 5)

  end
  
  love.graphics.print("tirs = "..#l_tirs.." sprites = "..#l_sprites
    .." Heros = "..#l_heros.." Ennemis = "..#l_ennemis.." Heros.vx :"..heros.vx, 10, 0)
  
  --Dessines les sprites
  -- Mechants
  local i
  for i = #l_ennemis,1 ,-1 do
    local en
    en = l_ennemis[i]
    love.graphics.draw(en.img, en.x, en.y)
    love.graphics.circle("fill", en.x, en.y, 5)


  end

  -- Heros
  love.graphics.draw(heros.img, heros.x, heros.y, 0, 
    heros.flip * 1, 1, largeurHeros/2, hauteurHeros)
    --love.graphics.circle("fill", heros.x, heros.y, 2)

end

function love.keypressed(key)
    -- sur l'appuie de la touche si le joueur n'est is not jump 
  --on passe heros.vx la valeur de la hauteur du saut
  if love.keyboard.isDown ("up") then
    heros.saut = true
    if heros.vx == 0 then
      heros.vx = hauteurSaut
    end
  end
  
  if key == "space"  and heros.flip == 1 then
    -- Apres appui sur la touche espace on crée un tir
    -- que lon insere dans la table des tirs
    AppelTirs(1)
    end
  if key == "space"  and heros.flip == -1 then
    AppelTirs(-1)
  end  
end