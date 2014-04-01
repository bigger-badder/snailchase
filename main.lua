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
mte.physics.setDrawMode("hybrid")
mte.enableTileFlipAndRotation()
mte.loadMap("map.tmx")
mte.drawObjects() 
local scale = widthRatio
mte.setCamera({ locX = 11, locY = 12, scale = scale})


-- SET CONTROL BUTTONS ------------------------------------------------------------
local buttonRight = display.newImage( "images/arrowRight.png" )
buttonRight.anchorY = 0.5;
buttonRight.anchorX = 1;
buttonRight.x = vW - 10
buttonRight.y = vH/2 

local buttonLeft = display.newImage( "images/arrowLeft.png" )
buttonLeft.anchorY = 0.5;
buttonLeft.anchorX = 0;
buttonLeft.x = display.screenOriginX + 10
buttonLeft.y = vH/2 


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
mte.physics.addBody(player, "dynamic", {friction = 5, bounce = 5, density = 1, filter = { categoryBits = 1, maskBits = 1 } })
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

-- local physObj = display.newImage( "images/arrowLeft.png" );
-- mte.physics.addBody(physObj, "static", { friction=0.5, bounce=0.5  })
-- local setup = {
-- 	kind = "sprite", 
-- 	layer =  mte.getSpriteLayer(1), 
-- 	locX = 11, 
-- 	locY = 3,
-- 	levelWidth = 120,
-- 	levelHeight = 120,
-- 	name = "tree"
-- }
-- mte.addSprite(physObj, setup)


local direction = 0


local velocityX = 0
local velocityY = -2
local movement = 0

local function move( event )

	if event.phase == "began" or event.phase == "moved" then
		if event.target == buttonLeft then
			direction = 1
		end
		if event.target == buttonRight then
			direction = -1
		end
	elseif event.phase == "ended" or event.phase == "cancelled" then
		direction = 0
	end
end

local function gameLoop( event )

	mte.update()

	applyForceFromX = math.sin( math.rad(player.rotation) ) * 100
	applyForceFromY = -math.cos( math.rad(player.rotation) ) * 100

	local vx, vy = player:getLinearVelocity()
	print( "Linear X velocity = " .. vx .. ",  Linear Y velocity = " .. vy)

	-- if applyForceFromY > 10 then
	-- 	applyForceFromY = 10
	-- end

	-- if applyForceFromX > 20 then
	-- 	applyForceFromX = 20
	-- end

	player:applyForce(applyForceFromX, applyForceFromY, player.x, player.y)
	
	player.rotation = player.rotation + movement
	
	if direction < 0 then
		movement = movement + 0.6
	end
	if direction > 0 then
		movement = movement - 0.6
	end
	if direction == 0 then
		movement = 0
	end

	collectgarbage("step", 20)
end


buttonLeft:addEventListener("touch", move)
buttonRight:addEventListener("touch", move)
Runtime:addEventListener("enterFrame", gameLoop)