-- Dirt Bike Run
--
-- Copyright (c) Elliot Agro, Marcell Jusztin 2014.  
--
-- v1.0

-- Libraries
local mte = require("lib.mte").createMTE()
local TextCandy = require("lib.lib_text_candy")
local _ = require 'underscore'
local myData = require('myData')
require("pprint")

-- View Settings
local vW = display.viewableContentWidth
local vH = display.viewableContentHeight
local widthRatio = (vW / 1440) 

-- Score
local scoreText

-- add Corona's Storyboard module
local storyboard = require( "storyboard" )

-- create a new scene
local scene = storyboard.newScene()

local direction    = 0
local velocityX    = 0
local velocityY    = -2
local rotationDiff = 0
local xForce       = 0
local yForce       = 0
local score        = 0
local lastTileX, lastTileY = 0, 0;
local player, enemy, buttonLeftOverlay, buttonRightOverlay = nil

local function move( event )
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

local function isRoad (locXRef, locYRef)

	local isRoad  = mte.getTileProperties({ layer = 2, level = 1, locX = locXRef, locY = locYRef })

	if isRoad then
		return true
	end

	return false

end


function ScoreCreate()
	-- LOAD & ADD A CHARSET
	TextCandy.AddCharset ("DIGITS", "digits", "digits.png", "1234567890.m", 40)

	-- CREATE A TEXT OBJECT USING THIS CHARSET
	scoreText = TextCandy.CreateText({
		fontName     = "DIGITS", 						
		x            = vW / 2,						
		y            = vH - 100,
		text         = "0.0m",	
		originX      = "CENTER",							
		originY      = "TOP",							
		textFlow     = "CENTER",
		charSpacing  = 0,
		lineSpacing  = 0,
		wrapWidth    = 400, 			
		charBaseLine = "BOTTOM",
		showOrigin 	 = false						
		})
	scoreText:setColor(0.99, 0.84, 0.16)
end

function ScoreOnEnterFrame(score)
	scoreText:setText(score)
end

function scene:willEnterScene( event )
	local group = self.view

	--LOAD MAP ------------------------------------------------------------
	mte.toggleWorldWrapX(true)
	mte.toggleWorldWrapY(true)
	mte.enableBox2DPhysics()
	mte.physics.start()
	mte.physics.setGravity(0, 0)
	-- mte.physics.setDrawMode("hybrid")
	mte.loadMap("map2.tmx")
	mte.drawObjects() 
	local scale = widthRatio
	mte.setCamera({ locX = 10, locY = 39, scale = scale})

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
		locY = 45,
		levelWidth = 114,
		levelHeight = 240,
		name = "player"
	}

	mte.addSprite(player, setup)
	mte.setCameraFocus(player)
	player:play()



	--CREATE ENEMY SPRITE ------------------------------------------------------------
	enemy = display.newSprite( myImageSheet , {frames={1,2,3,4,5,6,7,8,9,10,11,12,13,14}} )
	enemy:setSequence("1");
	-- mte.physics.addBody(enemy, "dynamic", {friction = 500, radius = 20, bounce = 0, density = 1, filter = { categoryBits = 1, maskBits = 1 } })
	enemy.isFixedRotation = false
	-- enemy.linearDamping = 3
	-- enemy.angularDamping = 600
	-- mte.setCameraFocus(enemy)
	local setup = {
		kind = "sprite", 
		layer =  mte.getSpriteLayer(1), 
		locX = 11, 
		locY = 55,
		levelWidth = 114,
		levelHeight = 240,
		name = "enemy"
	}

	mte.addSprite(enemy, setup)
	enemy:play()

	group:insert(mte.getMapObj())
	mte.update()

	ScoreCreate()
	score = 0
	direction = 0
end

local function gameLoop( event )

	if lastTileY ~= player.locY then
		score = score + 1
		lastTileY = player.locY
	end

	ScoreOnEnterFrame(score .. 'm')
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


function gameover()
	myData.score    = score
	myData.gameOver = true
	storyboard.gotoScene( "menu", "flip", 200 )
end

-- Called immediately after scene has moved onscreen:
function scene:enterScene( event )
    local group = self.view

    buttonLeftOverlay:addEventListener("touch", move)
	buttonRightOverlay:addEventListener("touch", move)
	Runtime:addEventListener("enterFrame", gameLoop)
end


-- Called when scene is about to move offscreen:
function scene:exitScene( event )
    local group = self.view

    scoreText:delete()

    buttonLeftOverlay:removeEventListener("touch", move)
	buttonRightOverlay:removeEventListener("touch", move)
	Runtime:removeEventListener("enterFrame", gameLoop)
	
	--mte.cleanup()
end

-- Called prior to the removal of scene's "view" (display group)
function scene:destroyScene( event )
        local group = self.view
		
		mte.cleanup()
end


function scene:destroyScene( event )
	local group = self.view

end

scene:addEventListener( "willEnterScene", scene )
scene:addEventListener( "enterScene", scene )
scene:addEventListener( "exitScene", scene )
scene:addEventListener( "destroyScene", scene )

return scene