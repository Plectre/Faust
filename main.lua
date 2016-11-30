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
require("Score")
require("updateJeu")
require("Draw")

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
touche = 0
ecran_courant = "menu"

-- Et un tableau de tuiles un!!!!!
local n
l_ImgTiles = {}

for n =1,2 do
  l_ImgTiles[n] = love.graphics.newImage("images/Plat_"..n..".png")
end

function StartGame()
  -- Load images GUI
  ui_Up = love.graphics.newImage("images/gui.png")
  bgTitre = love.graphics.newImage("images/EcranTitre.png")
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
-- *************************************************************************************
function love.load()
  StartGame()
end
 --**********************************************************************************
function love.update(dt)
UpdateJeu(dt)
end

-- **************************************************************************************

function love.draw()
  if ecran_courant == "jeu" then
    Draw()
  elseif ecran_courant == "menu" then
    DrawMenu()
  end
end

function love.keypressed(key)
  if ecran_courant == "jeu" then
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
  elseif ecran_courant == "menu" then
    if love.keyboard.isDown("space") then
      ecran_courant = "jeu"
    end
  end
end