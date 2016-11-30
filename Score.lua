local point = 0

function Score(pTouche)
  point = point + pTouche
end

function AffichageScore()
    love.graphics.print("Score "..point, 50 ,15, 0, 1.5, 1.5)
end

