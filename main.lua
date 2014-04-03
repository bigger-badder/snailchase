-- Dirt Bike Run
--
-- Copyright (c) Elliot Agro, Marcell Jusztin 2014.  
--
-- v1.0

-- App settings
display.setStatusBar( display.HiddenStatusBar )

-- Libraries
local mte = require("lib.mte").createMTE()

-- View Settings
local vW = display.viewableContentWidth
local vH = display.viewableContentHeight
local widthRatio = (vW/1440) 


--LOAD MAP ------------------------------------------------------------
mte.toggleWorldWrapX(true)
mte.toggleWorldWrapY(true)
mte.enableBox2DPhysics()
mte.physics.start()
mte.physics.setGravity(0, 0)
--mte.physics.setDrawMode("hybrid")
mte.enableTileFlipAndRotation()
mte.loadMap("map.tmx")
mte.drawObjects() 
local scale = widthRatio
mte.setCamera({ locX = 11, locY = 12, scale = scale})


-- SET CONTROL BUTTONS ------------------------------------------------------------
local buttonRight = display.newImage( "images/arrowRight.png" )
buttonRight.anchorY = 0.5;
buttonRight.anchorX = 1;
buttonRight:scale(0.5, 0.5)
buttonRight.x = vW - 10
buttonRight.y = vH/2 

local buttonLeft = display.newImage( "images/arrowLeft.png" )
buttonLeft.anchorY = 0.5;
buttonLeft.anchorX = 0;
buttonLeft:scale(0.5, 0.5)
buttonLeft.x = display.screenOriginX + 10
buttonLeft.y = vH/2 

local buttonLeftOverlay = display.newRect(display.screenOriginX, display.screenOriginY, vW / 2, vH)
buttonLeftOverlay.anchorX = 0;
buttonLeftOverlay.anchorY = 0;
buttonLeftOverlay:setFillColor( 0, 0, 0, 0.01)

local buttonRightOverlay = display.newRect(display.screenOriginX + vW / 2, display.screenOriginY, vW / 2, vH)
buttonRightOverlay.anchorX = 0;
buttonRightOverlay.anchorY = 0;
buttonRightOverlay:setFillColor( 0, 0, 0, 0.01 )


--CREATE PLAYER SPRITE ------------------------------------------------------------
local spriteSheet = graphics.newImageSheet("spriteSheet.png", {width = 32, height = 32, numFrames = 96})
local sequenceData = {		
		{name = "1", sheet = spriteSheet, frames = {85, 86}, time = 500, loopCount = 0},
		{name = "2", sheet = spriteSheet, frames = {73, 74}, time = 500, loopCount = 0},
		{name = "3", sheet = spriteSheet, frames = {49, 50}, time = 500, loopCount = 0},
		{name = "4", sheet = spriteSheet, frames = {61, 62}, time = 500, loopCount = 0}
		}
local player = display.newSprite(spriteSheet, sequenceData)
-- player.x = vW/2
-- player.y = vH/2
player:setSequence("3")
mte.physics.addBody(player, "dynamic", {friction = 5, radius = 20, bounce = 1, density = 1, filter = { categoryBits = 1, maskBits = 1 } })
player.isFixedRotation = false
player.linearDamping = 3
player.angularDamping = 220

local setup = {
	kind = "sprite", 
	layer =  mte.getSpriteLayer(1), 
	locX = 11, 
	locY = 12,
	levelWidth = 120,
	levelHeight = 120,
	name = "player"
}

mte.addSprite(player, setup)
mte.setCameraFocus(player)
player:play()


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

local xForce = 0;
local yForce = 0;

local function gameLoop( event )

	mte.update()

	local isGrass = mte.getTileProperties({ layer = 1, level = 1, locX = player.locX, locY = player.locY })
	local isRoad  = mte.getTileProperties({ layer = 2, level = 1, locX = player.locX, locY = player.locY })

	local accCoeff = 70

	if isRoad then
		accCoeff = 100
	end

	local newForceX = math.sin( math.rad(player.rotation) ) * accCoeff
	local newForceY = -math.cos( math.rad(player.rotation) ) * accCoeff

	local diffX = newForceX - xForce 
	xForce = xForce + (diffX / 2)
	
	local diffY = newForceY - yForce
	yForce = yForce + (diffY / 2)

	local vx, vy = player:getLinearVelocity()

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

	collectgarbage("step", 20)
end


buttonLeftOverlay:addEventListener("touch", move)
buttonRightOverlay:addEventListener("touch", move)
Runtime:addEventListener("enterFrame", gameLoop)