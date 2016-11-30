function UpdateJeu(dt)
    -- Mouvement Ennemis
  for i = #l_ennemis,1, -1 do
    local en = l_ennemis[i]
    en.x = en.x + en.vx
    if en.x >= largeur then
      table.remove(l_ennemis, i)
      en.supp = true
    end
  end
  
  -- gestion collision tir/ennemi
  for e = #l_ennemis,1 ,-1 do
    for t = #l_tirs, 1, -1  do
      local en = l_ennemis[e]
      local tir = l_tirs[t]
      if tir.x >= en.x + en.img:getWidth() -- trop à droite
          or tir.x + tir.img:getWidth() <= en.x -- trop à gauche
          or tir.y >= en.y + en.img:getHeight() -- trop bas
          or tir.y + tir.img:getHeight() <= en.y  -- trop haut
          then
            --print ("a cotés")
      else
        --touche = ennemi.valeur
        en.sup = true
        if en.supp == true then
        end
        table.remove(l_ennemis, e)
        table.remove(l_tirs, t)
        --tir.supp = true 
        Score(en.valeur) -- incrementation du score en fonction de l'ennemi
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
    tir.rot = tir.rot - dt * math.pi/0.2
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
        tir.x = tir.x + 15
      else
        tir.x = tir.x - 15
      end
  -- Rotation de la faux
  tir.rot = tir.rot - dt * math.pi/-0.2

  -- Si le tir sort de l'ecran on le retire de la table l_tirs
    if tir.x >= largeur * 2 or tir.x <= 0 - largeur then
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
    end
  end
end
