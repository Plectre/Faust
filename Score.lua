local point = 0


function Score(pTouche)
  point = point + pTouche
  print (pTouche)
end

function AffichageScore()
    love.graphics.print("Score "..point, 50 ,50)
end

