 function DrawMenu()
     -- GUI ..............................
  love.graphics.draw(bgTitre, 0, 0)
end

function Draw()
  love.graphics.draw(ui_Up, 80, 450, 0, 1, 1,ui_Up:getWidth()/2, ui_Up:getHeight()/2)

  AffichageScore()
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
        CreerEnnemis("Plat_2", x, y, 100)
        niveau[l][c] = "0" -- On remplace l'ennemi par 0 pour ne pas les redessiner à chaque update de draw
        x = x + 32
      end
      if n == 3 then
        CreerEnnemis("Plat_3", x, y, 150)
        niveau[l][c] = "0"
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
  end
  --love.graphics.print("tirs = "..#l_tirs.." sprites = "..#l_sprites
   -- .." Heros = "..#l_heros.." Ennemis = "..#l_ennemis.." Heros.vx :"..heros.vx, 10, 0)
  
  --Dessines les sprites
  -- Mechants
  local i
  for i = #l_ennemis,1 ,-1 do
    local en
    en = l_ennemis[i]
    love.graphics.draw(en.img, en.x, en.y)
  end

  -- Heros
  love.graphics.draw(heros.img, heros.x, heros.y, 0, 
    heros.flip * 1, 1, largeurHeros/2, hauteurHeros)
    --love.graphics.circle("fill", heros.x, heros.y, 2)
end
