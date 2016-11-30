

function collider()
       for l = #l_tiles,1, -1 do
      local t = l_tiles[l]
      --print (math.floor(t.y))
        if heros.y >= (t.y) and heros.y <= (t.y + 32)
        	and heros.x >= (t.x) and heros.x <= (t.x + 32)then
          heros.y = t.y - 0.1
          heros.vx = 0
          heros.saut = false
        end
    end
end