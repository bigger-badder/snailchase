local TextCandy = require("lib.lib_text_candy")
-- LOAD & ADD A CHARSET
TextCandy.AddCharset ("EXOBIG", "exo", "exo.png", "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz1234567890.,;:/?!", 20)
TextCandy.AddCharset ("EXOMID", "exo", "exo.png", "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz1234567890.,;:/?!", 20)
TextCandy.AddCharset ("EXOSMALL", "exo", "exo.png", "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz1234567890.,;:/?!", 20)
TextCandy.AddVectorFont("Mecha", "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz1234567890.,;:/?!", 50)
TextCandy.AddVectorFont("Mecha Bold", "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz1234567890.,;:/?!", 50)
TextCandy.ScaleCharset('EXOBIG', 0.7)
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

local myData = require('myData')

function startGame()
	storyboard.gotoScene('game', 'slideLeft', 200)
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

	local playBtn = display.newImage( "images/newGameBtn.png" )
	playBtn.width = 146;
	playBtn.height = 38;
	playBtn.x = display.screenOriginX + (display.contentWidth / 2)
	playBtn.y = display.screenOriginY + 270
	group:insert(playBtn)
	playBtn:addEventListener("touch", startGame)

	local soundBtn = display.newImage( "images/soundsOnBtn.png" )
	soundBtn.width = 236;
	soundBtn.height = 38;
	soundBtn.x = display.screenOriginX + (display.contentWidth / 2)
	soundBtn.y = display.screenOriginY + 320
	group:insert(soundBtn)
	soundBtn:addEventListener("touch", startGame)

	local musicBtn = display.newImage( "images/musicOnBtn.png" )
	musicBtn.width = 236;
	musicBtn.height = 38;
	musicBtn.x = display.screenOriginX + (display.contentWidth / 2)
	musicBtn.y = display.screenOriginY + 370
	group:insert(musicBtn)
	musicBtn:addEventListener("touch", startGame)

	gameOverLabel = TextCandy.CreateText({
		fontName     = "EXOMID", 						
		x            = display.contentWidth / 2,						
		y            = 0,
		text         = "Score",	
		originX      = "CENTER",							
		originY      = "TOP",							
		textFlow     = "CENTER",
		charSpacing  = -5,
		lineSpacing  = 0,
		wrapWidth    = 400, 			
		charBaseLine = "BOTTOM",
		showOrigin 	 = false						
	})
	gameOverLabel.x = display.contentWidth * 0.5
	gameOverLabel.y = display.contentHeight * 0.4
	gameOverLabel.alpha = 0


	scoreLabel = TextCandy.CreateText({
		fontName     = "EXOMID", 						
		x            = display.contentWidth / 2,						
		y            = 0,
		text         = '',	
		originX      = "CENTER",							
		originY      = "TOP",							
		textFlow     = "CENTER",
		charSpacing  = -5,
		lineSpacing  = 0,
		wrapWidth    = 400, 			
		charBaseLine = "BOTTOM",
		showOrigin 	 = false						
	})
	scoreLabel.x = display.contentWidth * 0.5
	scoreLabel.y = display.contentHeight * 0.5
	scoreLabel.alpha = 0

	bestScoreLabel = display.newText(group, 'HIGH SCORE : '..myData.currentHighScore, 20, 20, "Mecha", 30 )
	bestScoreLabel:setFillColor( 255 / 255, 255 / 255, 255 / 255 )
	bestScoreLabel.x = display.contentWidth * 0.5
	bestScoreLabel.y = display.contentHeight * 0.92

	group:insert( playBtn )
	group:insert( gameOverLabel )
	group:insert( scoreLabel )
	group:insert( bestScoreLabel )
	group:insert( scoreLabel )
	group:insert( gameOverLabel )
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

		-- save highscore
		local tablefill = [[INSERT INTO highscore VALUES (NULL, ']]..myData.score..[['); ]]
		myData.db:exec( tablefill )

		if myData.score > myData.currentHighScore then
			myData.currentHighScore = myData.score
		end
	end

	bestScoreLabel.text = 'HIGH SCORE : '..myData.currentHighScore
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