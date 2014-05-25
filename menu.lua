local TextCandy = require("lib.lib_text_candy")
-- LOAD & ADD A CHARSET
TextCandy.AddCharset ("EXOBIG", "exo", "exo.png", "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz1234567890.,;:/?!", 20)
TextCandy.AddCharset ("EXOMID", "exo", "exo.png", "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz1234567890.,;:/?!", 20)
TextCandy.AddCharset ("EXOSMALL", "exo", "exo.png", "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz1234567890.,;:/?!", 20)
TextCandy.AddCharset ("MechaBitmap", "mecha", "mecha.png", "0123456789ABCDEFGHIJKLMNOPRSTUVWXYZ:!", 30)
TextCandy.AddVectorFont("Mecha", "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz1234567890.,;:/?!", 50)
-- TextCandy.AddVectorFont("Mecha Bold", "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz1234567890.,;:/?!", 50)
TextCandy.ScaleCharset('MechaBitmap', 0.2)
TextCandy.ScaleCharset('EXOMID', 0.5)
TextCandy.ScaleCharset('EXOSMALL', 0.3)
-- add Corona's Storyboard module
local storyboard = require( "storyboard" )

-- create a new scene
local scene = storyboard.newScene()

-- include Corona's "widget" library, we need it for buttons
local widget = require "widget"

-- forward declarations for our level selection buttons
-- needed to remove the buttons from the scene in destroyScene
local playBtn
local bestScoreLabel
local gameOverLabel
local scoreLabel

local musicOffBtn, musicOnBtn, soundOnBtn, soundOffBtn = nil

local myData = require('myData')

function startGame()
	storyboard.gotoScene('game', 'slideLeft', 200)
end

function toggleMusicBtn( event )

	myData.setMusic( event )

	if myData.settings.musicOn == true then
		musicOnBtn.alpha = 0
		musicOffBtn.alpha = 1
	else
		musicOnBtn.alpha = 1
		musicOffBtn.alpha = 0
	end
end

function toggleSoundBtn( event )

	myData.setSound( event )

	if myData.settings.soundOn == true then
		soundOnBtn.alpha = 0
		soundOffBtn.alpha = 1
	else
		soundOnBtn.alpha = 1
		soundOffBtn.alpha = 0
	end
end

-- Called when the scene's view does not exist:
function scene:createScene( event )
	local group = self.view

	-- background should appear behind all scenes
	local background = display.newImage( "images/menuBG.png" )
	background.width = display.contentWidth
	background.height = display.contentHeight
	background.anchorX = 0
	background.anchorY = 0
	background.x = display.screenOriginX
	background.y = display.screenOriginY
	group:insert(background)

	local playBtn = display.newImage( "images/newGame.png" )
	playBtn.width = 410;
	playBtn.height = 93;
	playBtn.x = display.screenOriginX + (display.contentWidth / 2)
	playBtn.y = display.screenOriginY + (display.contentHeight / 2) + 160
	group:insert(playBtn)
	playBtn:addEventListener("touch", startGame)

	soundOnBtn = display.newImage( "images/turnOnSounds.png" )
		soundOnBtn.width = 659;
		soundOnBtn.height = 93;
		soundOnBtn.x = display.screenOriginX + (display.contentWidth / 2)
		soundOnBtn.y = display.screenOriginY + 860
		group:insert(soundOnBtn)
		soundOnBtn:addEventListener("touch", toggleSoundBtn)

	soundOffBtn = display.newImage( "images/turnOffSounds.png" )
		soundOffBtn.width = 709;
		soundOffBtn.height = 93;
		soundOffBtn.x = display.screenOriginX + (display.contentWidth / 2)
		soundOffBtn.y = display.screenOriginY + 860
		group:insert(soundOffBtn)
		soundOffBtn:addEventListener("touch", toggleSoundBtn)

	if myData.settings.soundOn == true then
		soundOnBtn.alpha  = 0
		soundOffBtn.alpha = 1
	else
		soundOnBtn.alpha  = 1
		soundOffBtn.alpha = 0
	end

	musicOnBtn = display.newImage( "images/turnOnMusic.png" )
		musicOnBtn.width = 597;
		musicOnBtn.height = 93;
		musicOnBtn.x = display.screenOriginX + (display.contentWidth / 2)
		musicOnBtn.y = soundOffBtn.y + 100
		group:insert(musicOnBtn)
		musicOnBtn:addEventListener("touch", toggleMusicBtn)

	musicOffBtn = display.newImage( "images/turnOffMusic.png" )
		musicOffBtn.width = 647;
		musicOffBtn.height = 93;
		musicOffBtn.x = display.screenOriginX + (display.contentWidth / 2)
		musicOffBtn.y = soundOffBtn.y + 100
		group:insert(musicOffBtn)
		musicOffBtn:addEventListener("touch", toggleMusicBtn)

	if myData.settings.musicOn == true then
		musicOnBtn.alpha  = 0
		musicOffBtn.alpha = 1
	else
		musicOnBtn.alpha  = 1
		musicOffBtn.alpha = 0
	end

	scoreLabel = TextCandy.CreateText({
		fontName     = "Mecha", 						
		x            = display.contentWidth / 2,						
		y            = 0,
		text         = 'HIGH SCORE : '.. myData.settings.highscore .. 'm',	
		originX      = "CENTER",							
		originY      = "TOP",							
		textFlow     = "CENTER",
		charSpacing  = 0,
		lineSpacing  = 0,
		wrapWidth    = display.contentWidth, 			
		charBaseLine = "BOTTOM",
		showOrigin 	 = false						
	})
	scoreLabel.x = display.screenOriginX + ( display.contentWidth * 0.5 ) 
	scoreLabel.y = ( display.screenOriginY + display.contentHeight ) - 150
	--scoreLabel.alpha = 0

	--[[
	bestScoreLabel = display.newText(group, 'HIGH SCORE : '..myData.currentHighScore, 20, 20, "Mecha", 70 )
	bestScoreLabel:setFillColor( 255 / 255, 255 / 255, 255 / 255 )
	bestScoreLabel.x = display.contentWidth * 0.5
	bestScoreLabel.y = display.contentHeight * 0.92
	]]

	group:insert( playBtn )
	--group:insert( gameOverLabel )
	group:insert( scoreLabel )
	--group:insert( bestScoreLabel )
	group:insert( scoreLabel )
	--group:insert( gameOverLabel )
end

function scene:destroyScene( event )
	local group = self.view

	playBtn:removeEventListener("touch", startGame)

	if playBtn then
		playBtn:removeSelf()
		playBtn = nil
	end
end

function scene:enterScene(event)

	local group = self.view

	ads.hide( )

	if myData.gameOver == true then

		gameOverLabel.alpha = 1
		scoreLabel:setText(myData.score)
		scoreLabel.alpha = 1

		if myData.score > myData.settings.highscore then
			myData.setHighscore(myData.score)
		end
	end

	scoreLabel.text = 'HIGH SCORE : '.. myData.settings.highscore .. 'm'
end

-- "createScene" event is dispatched if scene's view does not exist
scene:addEventListener( "createScene", scene )
scene:addEventListener( "enterScene", scene )
-- "destroyScene" event is dispatched before view is unloaded, which can be
-- automatically unloaded in low memory situations, or explicitly via a call to
-- storyboard.purgeScene() or storyboard.removeScene().
scene:addEventListener( "destroyScene", scene )

--don't forget to return the scene
return scene