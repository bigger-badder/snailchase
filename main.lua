-- Dirt Bike Run
--
-- Copyright (c) Elliot Agro, Marcell Jusztin 2014.  
--
-- v1.0

-- App settings
display.setStatusBar( display.HiddenStatusBar )

-- Libraries
local mte = require("lib.mte").createMTE()
local TextCandy = require("lib.lib_text_candy")
local _ = require 'underscore'
require("pprint")
local Grid = require ("jumper.grid") -- The grid class
local Pathfinder = require ("jumper.pathfinder") -- The pathfinder lass


-- View Settings
local vW = display.viewableContentWidth
local vH = display.viewableContentHeight
local widthRatio = (vW / 1440) 

-- Score
local scoreText

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

--LOAD MAP ------------------------------------------------------------
mte.toggleWorldWrapX(true)
mte.toggleWorldWrapY(true)
mte.enableBox2DPhysics()
mte.physics.start()
mte.physics.setGravity(0, 0)
--mte.physics.setDrawMode("hybrid")
mte.loadMap("map2.tmx")
mte.drawObjects() 
local scale = widthRatio
mte.setCamera({ locX = 10, locY = 39, scale = scale})

-- CREATE PATHFINDER ARRAY ------------------------------------------------------------
local layer = 3
local mapWidth = mte.getMap().width;
local mapHeight = mte.getMap().height;
local mapData = {};

for i=1, mapHeight do
	
	mapDataRow = {}

	for j=1, mapWidth do
		
		local isObstical  = mte.getTileProperties({ layer = 3, level = 1, locX = j, locY = i })

		if isObstical then
			table.insert(mapDataRow, 1)
		else
			table.insert(mapDataRow, 0)
		end

	end 

	table.insert(mapData, mapDataRow)

end

pprint("mapData", mapData)

local buttonLeftOverlay = display.newRect(display.screenOriginX, display.screenOriginY, vW / 2, vH)
buttonLeftOverlay.anchorX = 0;
buttonLeftOverlay.anchorY = 0;
buttonLeftOverlay:setFillColor( 0, 0, 0, 0.01)

local buttonRightOverlay = display.newRect(display.screenOriginX + vW / 2, display.screenOriginY, vW / 2, vH)
buttonRightOverlay.anchorX = 0;
buttonRightOverlay.anchorY = 0;
buttonRightOverlay:setFillColor( 0, 0, 0, 0.01 )


--CREATE PLAYER SPRITE ------------------------------------------------------------

local sheetInfo = require("oldlady")
local myImageSheet = graphics.newImageSheet( "oldlady.png", sheetInfo:getSheet() )
local player = display.newSprite( myImageSheet , {frames={1,2,3,4,5,6,7,8,9,10,11,12,13,14}} )


--local spriteSheet = graphics.newImageSheet("spriteSheet.png", {width = 32, height = 32, numFrames = 96})
--local sequenceData = {		
		--{name = "1", sheet = spriteSheet, frames = {85, 86}, time = 500, loopCount = 0},
		--{name = "2", sheet = spriteSheet, frames = {73, 74}, time = 500, loopCount = 0},
		--{name = "3", sheet = spriteSheet, frames = {49, 50}, time = 500, loopCount = 0},
		--{name = "4", sheet = spriteSheet, frames = {61, 62}, time = 500, loopCount = 0}
		--}
--local player = display.newSprite(spriteSheet, sequenceData)
-- player.x = vW/2
-- player.y = vH/2
--player:setSequence("3")
mte.physics.addBody(player, "dynamic", {friction = 5, radius = 20, bounce = 1, density = 1, filter = { categoryBits = 1, maskBits = 1 } })
player.isFixedRotation = false
player.linearDamping = 3
player.angularDamping = 220

local setup = {
	kind = "sprite", 
	layer =  mte.getSpriteLayer(1), 
	locX = 11, 
	locY = 45,
	levelWidth = 120,
	levelHeight = 120,
	name = "player"
}

mte.addSprite(player, setup)
mte.setCameraFocus(player)
player:play()



--CREATE ENEMY SPRITE ------------------------------------------------------------
local enemy = display.newSprite( myImageSheet , {frames={1,2,3,4,5,6,7,8,9,10,11,12,13,14}} )
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
	locY = 51,
	levelWidth = 120,
	levelHeight = 120,
	name = "enemy"
}

mte.addSprite(enemy, setup)
enemy:play()


local direction = 0
local velocityX = 0
local velocityY = -2
local rotationDiff = 0

local function move( event )

	-- if event.phase == "began" then
	-- display.currentStage:setFocus(event.target)
	-- end

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


	-- if event.phase == "moved" then
	
	-- 	if(event.x < event.target.x - (event.target.width/2) or event.x > event.target.x + (event.target.width/2) ) then
	-- 		direction = 0
	-- 	end

	-- 	if(event.y < event.target.y - (event.target.height/2) or event.y > event.target.y + (event.target.height/2) ) then
	-- 		direction = 0
	-- 	end

	-- end


end

local function isRoad (locXRef, locYRef)

	local isRoad  = mte.getTileProperties({ layer = 2, level = 1, locX = locXRef, locY = locYRef })

	if isRoad then
		return true
	end

	return false

end


local xForce = 0;
local yForce = 0;
local lastTileX, lastTileY = 0, 0;

ScoreCreate()
local score = 0

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
	print('Game Over!')
	enemy:pause()
	player:pause()
	Runtime:removeEventListener("enterFrame", gameLoop)
end

buttonLeftOverlay:addEventListener("touch", move)
buttonRightOverlay:addEventListener("touch", move)
Runtime:addEventListener("enterFrame", gameLoop)