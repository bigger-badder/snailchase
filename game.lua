----------------------------------------------------------------------------------
--
-- scenetemplate.lua
--
----------------------------------------------------------------------------------

local storyboard = require( "storyboard" )
local scene = storyboard.newScene()

local mte       = require("lib.mte").createMTE()
local TextCandy = require("lib.lib_text_candy")
local _         = require 'underscore'
local myData    = require('myData')
local pprint    = require("pprint")
local widget    = require( "widget" )

----------------------------------------------------------------------------------
-- 
--  NOTE:
--  
--  Code outside of listener functions (below) will only be executed once,
--  unless storyboard.removeScene() is called.
-- 
---------------------------------------------------------------------------------

local vW                                                   = 0
local vH                                                   = 0
local scale                                                = 0
local direction                                            = 0
local velocityX                                            = 0
local velocityY                                            = -2
local rotationDiff                                         = 0
local xForce                                               = 0
local yForce                                               = 0
local score                                                = 0
local scoreText                                            = nil
local lastTileX, lastTileY                                 = 0
local countDown                                            = 3
local thisGroup                                            = nil
local player, enemy, fight, buttonLeftOverlay, buttonRightOverlay = nil
local restartBtn, gameOverBg, gameOverText, gameOverScore, gameOverHS = nil
local instructionBgL, instructionBgR, instructionCD, instructionTextL, instructionTextR = nil

vW    = display.viewableContentWidth
vH    = display.viewableContentHeight
scale = (vW / 1440)

--LOAD MAP ------------------------------------------------------------
mte.toggleWorldWrapX(true)
mte.toggleWorldWrapY(true)
mte.enableBox2DPhysics()
mte.physics.start()
mte.physics.setGravity(0, 0)
mte.loadMap("map2.tmx")
mte.drawObjects()
mte.setCamera({ locX = 10, locY = 39, scale = scale, overDraw=1})

TextCandy.AddCharset ("DIGITS", "digits", "digits.png", "1234567890.m", 40)
TextCandy.AddVectorFont("Mecha", "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz1234567890.,;:/?!", 50)
TextCandy.AddVectorFont("Covered By Your Grace", "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz1234567890.,;:/?!", 60)

---------------------------------------------------------------------------------
-- BEGINNING OF YOUR IMPLEMENTATION
---------------------------------------------------------------------------------

function resetGame()

  local adX = display.screenOriginX
  local adY = (display.screenOriginY + display.viewableContentHeight) - 30;

  print("adX : "..adX);
  print("adY : "..adY);

  playMusic()
  playWings()

  showAd( "banner", { x=adX, y=adY, interval=30, testMode=true } )

  mte.setCamera({ locX = 11, locY = 96, scale = scale, overDraw=1})
  
  score           = 0  
  direction       = 0
  velocityX       = 0
  velocityY       = -2
  xForce          = 0
  yForce          = 0  
  player.x        = mte.locToLevelPosX(11, mte.getSpriteLayer(1))
  player.y        = mte.locToLevelPosY(96, mte.getSpriteLayer(1))
  player.rotation = 0  
  player.alpha     = 1
  enemy.x         = mte.locToLevelPosX(11, mte.getSpriteLayer(1))
  enemy.y         = mte.locToLevelPosY(106, mte.getSpriteLayer(1))
  enemy.alpha     = 1
  lastTileY       = 96
  fight.alpha     = 0
  countDown       = 3
  scoreText.alpha = 0

  player:play()
  enemy:play()
  fight:pause()

  showInstructions()

  mte.update()
end

function startGame()

  instructionBgL:removeSelf()
  instructionBgR:removeSelf()
  instructionCD:removeSelf()
  instructionTextL:removeSelf()
  instructionTextR:removeSelf()

  scoreText.alpha = 1

  buttonLeftOverlay:addEventListener("touch", move)
  buttonRightOverlay:addEventListener("touch", move)
  Runtime:addEventListener("enterFrame", gameLoop)
end

function countDownTimer( event )

  countDown = countDown - 1

  instructionCD:setText(countDown)

  if countDown < 1 then
    startGame()
  end
end

function showInstructions()

  instructionBgL = display.newRect( 0, 0, vW / 2, vH )
  instructionBgL:setFillColor( 229 / 256, 132 / 256, 28 / 256, 0.2 )
  instructionBgL.anchorX = 0
  instructionBgL.anchorY = 0

  instructionBgR = display.newRect( vW / 2, 0, vW / 2, vH )
  instructionBgR:setFillColor( 0, 0, 1, 0.2 )
  instructionBgR.anchorX = 0
  instructionBgR.anchorY = 0

  instructionCD = TextCandy.CreateText({
    fontName     = "Mecha",             
    x            = display.screenOriginX + vW / 2,         
    y            = display.screenOriginY + 200,
    text         = countDown,  
    originX      = "CENTER",              
    originY      = "TOP",             
    textFlow     = "CENTER",
    charSpacing  = 0,
    lineSpacing  = 0,
    wrapWidth    = 20,       
    charBaseLine = "BOTTOM",
    showOrigin   = false,
    fontSize     = 300         
  })
  instructionCD:setColor(256 / 256, 256 / 256, 256 / 256)
  instructionCD:addDropShadow(1, 1, 1)

  instructionTextL = TextCandy.CreateText({
    fontName     = "Covered By Your Grace",             
    x            = display.screenOriginX + vW /4,         
    y            = 500,
    text         = 'Tap or hold to \nturn left',  
    originX      = "CENTER",              
    originY      = "TOP",             
    textFlow     = "CENTER",
    charSpacing  = 0,
    lineSpacing  = 0,
    wrapWidth    = vW / 2 * 0.8,       
    charBaseLine = "BOTTOM",
    showOrigin   = false,
    fontSize     = 60         
  })
  instructionTextL:setColor(256 / 256, 256 / 256, 256 / 256)
  instructionTextL:addDropShadow(1, 1, 1)

  instructionTextR = TextCandy.CreateText({
    fontName     = "Covered By Your Grace",             
    x            = display.screenOriginX + (display.viewableContentWidth - vW /4),         
    y            = 500,
    text         = 'Tap or hold to \nturn right',  
    originX      = "CENTER",              
    originY      = "TOP",             
    textFlow     = "CENTER",
    charSpacing  = 0,
    lineSpacing  = 0,
    wrapWidth    = vW / 2 * 0.8,       
    charBaseLine = "BOTTOM",
    showOrigin   = false,
    fontSize     = 60         
  })
  instructionTextR:setColor(256 / 256, 256 / 256, 256 / 256)
  instructionTextR:addDropShadow(1, 1, 1)

  timer.performWithDelay( 1000, countDownTimer, 3 )
end

function updateScore()
  scoreText:setText( score..'m' )
end

function move( event )

  if event.phase == "began" or event.phase == "moved" then
    if event.target == buttonLeftOverlay then
      direction = 1
    end
    if event.target == buttonRightOverlay then
      direction = -1
    end
  elseif event.phase == "ended" or event.phase == "cancelled" then
    display.currentStage:setFocus(nil)
    direction = 0
  end
end

function isRoad (locXRef, locYRef)

  local isRoad  = mte.getTileProperties({ layer = 2, level = 1, locX = locXRef, locY = locYRef })

  if isRoad then
    return true
  end

  return false
end

function gameLoop( event )

  if lastTileY ~= player.locY then
    score = score + 1
    lastTileY = player.locY
  end

  updateScore()

  mte.update()

  -- PLAYER MOVEMENT
  local isGrass = mte.getTileProperties({ layer = 1, level = 1, locX = player.locX, locY = player.locY })

  local accCoeff = 70

  if isRoad(player.locX, player.locY ) then
    accCoeff = 100
  end

  local newForceX = math.sin( math.rad(player.rotation) ) * accCoeff
  local newForceY = -math.cos( math.rad(player.rotation) ) * accCoeff

  local diffX = newForceX - xForce 
  xForce = xForce + (diffX / 2)
  
  local diffY = newForceY - yForce
  yForce = yForce + (diffY / 2)

  player:applyForce(xForce, yForce, player.x, player.y)
  
  player.rotation = player.rotation + rotationDiff
  
  if direction < 0 then
    rotationDiff = 5
  end
  if direction > 0 then
    rotationDiff = -5
  end
  if direction == 0 then
    rotationDiff = 0
  end


  -- ENEMY MOVEMENT

  enemy.y = enemy.y - 17

  if player.y >= enemy.y then
    gameover()
  end

  local xDist = player.x - enemy.x
  enemy.x = enemy.x + xDist * 1.1
  
  collectgarbage("step", 20)
end

function restartGame()
  storyboard.gotoScene( "intermediate")
end

function displayGameOver()

  gameOverBg = display.newRect( display.screenOriginX + vW / 2, display.screenOriginY + vH / 2, vW, vH )
  gameOverBg:setFillColor( 0, 0.4 )

  restartBtn = display.newImage( 'images/restart.png', {width=359, height=93} )
  restartBtn.x = display.screenOriginX + vW / 2
  restartBtn.y = (display.screenOriginY + vH)  - 250
  restartBtn.anchorX = 0.5
  restartBtn.anchorY = 0
  restartBtn:addEventListener("touch", restartGame)

  gameOverText = display.newImage( 'images/gameOver.png' )
  gameOverText.x = display.screenOriginX + vW / 2
  gameOverText.y = 50
  gameOverText:scale( 0.7, 0.7 )
  gameOverText.anchorX = 0.5
  gameOverText.anchorY = 0

  if(score > myData.settings.highscore) then

      myData.setHighscore(myData.score)

	  gameOverScoreImg = display.newImage( 'images/newHighScore.png' )
	  gameOverScoreImg.x = display.screenOriginX + vW / 2
	  gameOverScoreImg.y = (display.screenOriginY + vH / 2) - 160
	  gameOverScoreImg.anchorX = 0.5
	  gameOverScoreImg.anchorY = 0

	  gameOverHS = TextCandy.CreateText({
	    fontName     = "Mecha",             
	    x            = display.screenOriginX + display.contentWidth / 2,            
	    y            = gameOverScoreImg.y + 125,
	    text         = score .. 'm',
	    originX      = "CENTER",              
	    originY      = "TOP",             
	    textFlow     = "CENTER",
	    charSpacing  = 10,
	    lineSpacing  = 0,
	    wrapWidth    = 400,       
	    charBaseLine = "BOTTOM",
	    showOrigin   = false,
	    fontSize     = 80         
	  })
	  gameOverHS:setColor(256 / 256, 256 / 256, 256 / 256)
	  gameOverHS:addDropShadow(1, 1, 1)

  else

	  gameOverScoreImg = display.newImage( 'images/score.png', {width=540, height=353} )
	  gameOverScoreImg.x = display.screenOriginX + vW / 2
	  gameOverScoreImg.y = (display.screenOriginY + vH / 2) - 160
	  gameOverScoreImg.anchorX = 0.5
	  gameOverScoreImg.anchorY = 0

	  gameOverScore = TextCandy.CreateText({
	    fontName     = "Mecha",             
	    x            = (display.screenOriginX + display.contentWidth / 2) + 90,            
	    y            = gameOverScoreImg.y + 100,
	    text         = score .. 'm',  
	    originX      = "CENTER",              
	    originY      = "TOP",             
	    textFlow     = "CENTER",
	    charSpacing  = 10,
	    lineSpacing  = 0,
	    wrapWidth    = 400,       
	    charBaseLine = "CENTER",
	    showOrigin   = false,
	    fontSize     = 80         
	  })
	  gameOverScore:setColor(256 / 256, 256 / 256, 256 / 256)
	  gameOverScore:addDropShadow(1, 1, 1)

	  highScoreText = TextCandy.CreateText({
	    fontName     = "Mecha",             
	    x            = (display.screenOriginX + display.contentWidth / 2) + 200,            
	    y            = gameOverScoreImg.y + 215,
	    text         = myData.settings.highscore .. 'm',  
	    originX      = "CENTER",              
	    originY      = "TOP",             
	    textFlow     = "CENTER",
	    charSpacing  = 10,
	    lineSpacing  = 0,
	    wrapWidth    = 400,       
	    charBaseLine = "CENTER",
	    showOrigin   = false,
	    fontSize     = 80         
	  })
	  highScoreText:setColor(256 / 256, 256 / 256, 256 / 256)
	  highScoreText:addDropShadow(1, 1, 1)

  end


end

function gameover()
  
  stopMusic()
  stopWings()

  playSound ("scream")

  playSound ("fight")

  Runtime:removeEventListener("enterFrame", gameLoop)

  fight.x = player.x
  fight.y = player.y
  fight.alpha = 1;
  fight:play()

  player.alpha = 0
  enemy.alpha = 0

  local function onTimeOut()

    myData.score    = score
    myData.gameOver = true

    fight:pause()
    player:pause()
    enemy:pause()


    scoreText.alpha = 0

    displayGameOver()
  end

  timer.performWithDelay( 1500, onTimeOut )

end

-- Called when the scene's view does not exist:
function scene:createScene( event )
  local group = self.view

  -----------------------------------------------------------------------------
    
  --  CREATE display objects and add them to 'group' here.
  --  Example use-case: Restore 'group' from previously saved state.
  
  -----------------------------------------------------------------------------
  
  thisGroup = group;

  buttonLeftOverlay = display.newRect(display.screenOriginX, display.screenOriginY, vW / 2, vH)
  buttonLeftOverlay.anchorX = 0;
  buttonLeftOverlay.anchorY = 0;
  buttonLeftOverlay:setFillColor( 0, 0, 0, 0.01)

  buttonRightOverlay = display.newRect(display.screenOriginX + vW / 2, display.screenOriginY, vW / 2, vH)
  buttonRightOverlay.anchorX = 0;
  buttonRightOverlay.anchorY = 0;
  buttonRightOverlay:setFillColor( 0, 0, 0, 0.01 )

  group:insert( buttonLeftOverlay )
  group:insert( buttonRightOverlay )

  --CREATE PLAYER SPRITE ------------------------------------------------------------

  local sheetInfo = require("snail")
  local myImageSheet = graphics.newImageSheet( "snail.png", sheetInfo:getSheet() )
  player = display.newSprite( myImageSheet , {frames={1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20}} )
  mte.physics.addBody(player, "dynamic", {friction = 5, radius = 20, bounce = 1, density = 1, filter = { categoryBits = 1, maskBits = 1 } })
  player.isFixedRotation = false
  player.linearDamping = 3
  player.angularDamping = 220
  group:insert( player )

  local setup = {
    kind = "sprite", 
    layer =  mte.getSpriteLayer(1), 
    locX = 11, 
    locY = 96,
    levelWidth = 114,
    levelHeight = 240,
    name = "player"
  }

  mte.addSprite(player, setup)
  mte.setCameraFocus(player)
  player:play()


  --CREATE ENEMY SPRITE ------------------------------------------------------------
  local birdSheetInfo = require("bird")
  local birdImageSheet = graphics.newImageSheet( "bird.png", birdSheetInfo:getSheet() )
  enemy = display.newSprite( birdImageSheet , {frames={1,2,3,4,5,6}} )
  enemy:setSequence("1");
  enemy.isFixedRotation = false
  group:insert( enemy )

  local setup = {
    kind = "sprite", 
    layer =  mte.getSpriteLayer(1), 
    locX = 11, 
    locY = 106,
    levelWidth = 252,
    levelHeight = 252,
    name = "enemy"
  }

  mte.addSprite(enemy, setup)
  enemy:play()

  --CREATE FIGHT SPRITE ------------------------------------------------------------
  local sheetInfo = require("fight")
  local myImageSheet = graphics.newImageSheet( "fight.png", sheetInfo:getSheet() )
  fight = display.newSprite( myImageSheet , {frames={1,2,3,4,5,6,7,8,9,10}} )

  group:insert( fight )

  local setup = {
    kind = "sprite", 
    layer =  mte.getSpriteLayer(1), 
    locX = player.locX, 
    locY = player.locY,
    levelWidth = 240,
    levelHeight = 240,
    name = "fight"
  }
  mte.addSprite(fight, setup)
  fight.alpha = 0;


  -- CREATE A TEXT OBJECT USING THIS CHARSET
  scoreText = TextCandy.CreateText({
    fontName     = "Mecha",            
    x            = display.screenOriginX + vW / 2,            
    y            = display.screenOriginY + 100,
    text         = "0m",  
    originX      = "CENTER",              
    originY      = "BOTTOM",             
    textFlow     = "CENTER",
    fontSize	 = 150,
    charSpacing  = 45,
    lineSpacing  = 0,
    wrapWidth    = 400,       
    charBaseLine = "BOTTOM",
    showOrigin   = false            
    })
  scoreText:setColor(1, 1, 1)

  group:insert( mte.getMapObj() )

  group:insert( scoreText )
end


-- Called immediately after scene has moved onscreen:
function scene:enterScene( event )

--[[
    local group = self.view

    showAd( "banner" ) 

    buttonLeftOverlay:addEventListener("touch", move)
	buttonRightOverlay:addEventListener("touch", move)
	Runtime:addEventListener("enterFrame", gameLoop)
--]]

  local group = self.view
  
  -----------------------------------------------------------------------------
    
  --  INSERT code here (e.g. start timers, load audio, start listeners, etc.)
  
  -----------------------------------------------------------------------------
  
  resetGame()
  
end


-- Called when scene is about to move offscreen:
function scene:exitScene( event )
  local group = self.view
  
  -----------------------------------------------------------------------------
  
  --  INSERT code here (e.g. stop timers, remove listeners, unload sounds, etc.)
  
  -----------------------------------------------------------------------------

  if(highScoreText)then
  	highScoreText:removeSelf()
  end
  if(restartBtn)then
  	restartBtn:removeSelf()
  end
    if(gameOverBg)then
  	gameOverBg:removeSelf()
  end
    if(gameOverText)then
  	gameOverText:removeSelf()
  end
    if(gameOverScore)then
  	gameOverScore:removeSelf()
  end
  if(gameOverScoreImg)then
  	gameOverScoreImg:removeSelf()
  end
  if(gameOverHS)then
  	gameOverHS:removeSelf()
  end
  
end


-- Called prior to the removal of scene's "view" (display group)
function scene:destroyScene( event )
  local group = self.view
  
  -----------------------------------------------------------------------------
  
  --  INSERT code here (e.g. remove listeners, widgets, save state, etc.)
  
  -----------------------------------------------------------------------------

end

---------------------------------------------------------------------------------
-- END OF YOUR IMPLEMENTATION
---------------------------------------------------------------------------------


-- "createScene" event is dispatched if scene's view does not exist
scene:addEventListener( "createScene", scene )

-- "enterScene" event is dispatched whenever scene transition has finished
scene:addEventListener( "enterScene", scene )

-- "exitScene" event is dispatched before next scene's transition begins
scene:addEventListener( "exitScene", scene )

-- "destroyScene" event is dispatched before view is unloaded, which can be
-- automatically unloaded in low memory situations, or explicitly via a call to
-- storyboard.purgeScene() or storyboard.removeScene().
scene:addEventListener( "destroyScene", scene )

---------------------------------------------------------------------------------

return scene