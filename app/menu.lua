local TextCandy = require("lib.lib_text_candy")
-- LOAD & ADD A CHARSET
--TextCandy.AddCharset ("EXOBIG", "exo", "exo.png", "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz1234567890.,;:/?!", 20)
--TextCandy.AddCharset ("EXOMID", "exo", "exo.png", "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz1234567890.,;:/?!", 20)
--TextCandy.AddCharset ("EXOSMALL", "exo", "exo.png", "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz1234567890.,;:/?!", 20)
--TextCandy.AddCharset ("MechaBitmap", "mecha", "mecha.png", "0123456789ABCDEFGHIJKLMNOPRSTUVWXYZ:!", 30)
TextCandy.AddVectorFont("Mecha", "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz1234567890.,;:/?!", 50)
-- TextCandy.AddVectorFont("Mecha Bold", "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz1234567890.,;:/?!", 50)
--TextCandy.ScaleCharset('MechaBitmap', 0.2)
--TextCandy.ScaleCharset('EXOMID', 0.5)
--TextCandy.ScaleCharset('EXOSMALL', 0.3)
-- add Corona's Storyboard module
local storyboard = require( "storyboard" )

-- create a new scene
local scene = storyboard.newScene()

-- include Corona's "widget" library, we need it for buttons
local widget = require "widget"

-- forward declarations for our level selection buttons
-- needed to remove the buttons from the scene in destroyScene
local playBtn
local playBtnGroup
local highScoreGroup;
local bestScoreLabel
local gameOverLabel
local scoreLabel

local musicOffBtn, musicOnBtn, musicGroup, soundOnBtn, soundGroup, soundOffBtn, highScoreBtn = nil

local myData = require('myData')

function startGame()
	storyboard.gotoScene('game')
end

function showHighScores(event)

	displayHighScores();

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

	return true

end

function toggleSoundBtn( event )

	print(event.phase)

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

	group.x = display.screenOriginX
	group.y = display.screenOriginY

	-- background should appear behind all scenes
	local background = display.newImage( "images/menuBG.png" )
	background.width = display.contentWidth
	background.height = display.contentHeight
	background.anchorX = 0
	background.anchorY = 0
	background.x = display.screenOriginX
	background.y = display.screenOriginY
	group:insert(background)

	playBtnGroup = display.newGroup()
	playBtnGroup.x = display.screenOriginX + (display.contentWidth / 2)
	playBtnGroup.y = display.screenOriginY + (display.contentHeight / 2) + 80
	group:insert(playBtnGroup)

	local rect = display.newRect(0, 0, 450, 140)
	rect:setFillColor( 0, 0.01  )
	playBtnGroup:insert(rect)

	playBtn = display.newImage( "images/newGameBtn.png" )
	playBtn.width = 354;
	playBtn.height = 86;
	playBtnGroup:insert(playBtn)
	playBtnGroup:addEventListener("tap", startGame)

	--[[
	highScoreGroup = display.newGroup()
	highScoreGroup.x = playBtnGroup.x
	highScoreGroup.y = playBtnGroup.y + 120
	group:insert(highScoreGroup)

	local rect = display.newRect(0, 0, 450, 140)
	rect:setFillColor( 0, 0.01  )
	highScoreGroup:insert(rect)

	highScoreBtn = display.newImage( "images/highScoresBtn.png" )
	highScoreBtn.width = 436;
	highScoreBtn.height = 86;
	highScoreGroup:insert(highScoreBtn)
	highScoreGroup:addEventListener("tap", showHighScores)
	--]]

	soundGroup = display.newGroup()
	soundGroup.x = display.screenOriginX + (display.contentWidth / 2)
	soundGroup.y = playBtnGroup.y + 120
	group:insert(soundGroup)

	local rect = display.newRect(0, 0, 425, 120)
	rect:setFillColor( 0 , 0.01 )
	soundGroup:insert(rect)

	soundOnBtn = display.newImage( "images/turnOnSounds.png" )
	soundOnBtn.width = 330;
	soundOnBtn.height = 86;
	soundGroup:insert( soundOnBtn )

	soundOffBtn = display.newImage( "images/turnOffSounds.png" )
	soundOffBtn.width = 373;
	soundOffBtn.height = 86;
	soundGroup:insert(soundOffBtn)
	
	soundGroup:addEventListener("tap", toggleSoundBtn)

	if myData.settings.soundOn == true then
		soundOnBtn.alpha  = 0
		soundOffBtn.alpha = 1
	else
		soundOnBtn.alpha  = 1
		soundOffBtn.alpha = 0
	end

	musicGroup = display.newGroup()
	musicGroup.x = (display.screenOriginX + (display.contentWidth / 2))
	musicGroup.y = soundGroup.y + 120
	musicGroup:addEventListener("tap", toggleMusicBtn)
	group:insert(musicGroup)

	local rect = display.newRect(0, 0, 388, 120)
	rect:setFillColor( 0, 0.01 )
	musicGroup:insert(rect)

	musicOnBtn = display.newImage( "images/turnOnMusic.png", xPos, yPos, true )
	musicOnBtn.width = 320;
	musicOnBtn.height = 86;
	musicGroup:insert(musicOnBtn)

	musicOffBtn = display.newImage( "images/turnOffMusic.png", xPos, yPos, true )
	musicOffBtn.width = 363;
	musicOffBtn.height = 86;
	musicGroup:insert(musicOffBtn)

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
		originY      = "CENTER",							
		textFlow     = "CENTER",
		charSpacing  = 0,
		lineSpacing  = 0,
		wrapWidth    = display.contentWidth, 			
		showOrigin 	 = false						
	})
	scoreLabel.x = display.screenOriginX + ( display.contentWidth * 0.5 ) 
	scoreLabel.y = ( display.screenOriginY + display.contentHeight ) - 50


	local trophyLeft = nil;
	local trophyRight = nil;

	if myData.settings.highscore > trophies.gold then

		trophyLeft = display.newImage( "images/trophyGold.png" )
		trophyLeft.width = 120;
		trophyLeft.height = 120;
		trophyLeft.x = scoreLabel.x - ((scoreLabel.width / 2) + 90)
		trophyLeft.y = scoreLabel.y

		trophyRight = display.newImage( "images/trophyGold.png" )
		trophyRight.width = 120;
		trophyRight.height = 120;
		trophyRight.x = scoreLabel.x + ((scoreLabel.width / 2) + 90)
		trophyRight.y = scoreLabel.y

	elseif myData.settings.highscore > trophies.silver then
	
		trophyLeft = display.newImage( "images/trophySilver.png" )
		trophyLeft.width = 120;
		trophyLeft.height = 120;
		trophyLeft.x = scoreLabel.x - ((scoreLabel.width / 2) + 90)
		trophyLeft.y = scoreLabel.y

		trophyRight = display.newImage( "images/trophySilver.png" )
		trophyRight.width = 120;
		trophyRight.height = 120;
		trophyRight.x = scoreLabel.x + ((scoreLabel.width / 2) + 90)
		trophyRight.y = scoreLabel.y

	elseif myData.settings.highscore > trophies.bronze then

		trophyLeft = display.newImage( "images/trophyBronze.png" )
		trophyLeft.width = 120;
		trophyLeft.height = 120;
		trophyLeft.x = scoreLabel.x - ((scoreLabel.width / 2) + 90)
		trophyLeft.y = scoreLabel.y

		trophyRight = display.newImage( "images/trophyBronze.png" )
		trophyRight.width = 120;
		trophyRight.height = 120;
		trophyRight.x = scoreLabel.x + ((scoreLabel.width / 2) + 90)
		trophyRight.y = scoreLabel.y

	end


    local highscoreBG = display.newRect( display.screenOriginX, display.screenOriginY + display.contentHeight, display.contentWidth, 110 )
	highscoreBG.anchorX = 0;
	highscoreBG.anchorY = 110;
	highscoreBG:setFillColor( 0, 0.5 )
	highscoreBG.x = display.screenOriginX;
	highscoreBG.y = display.screenOriginY + display.contentHeight;
	group:insert( highscoreBG )	

	if trophyLeft then
		group:insert( trophyLeft )	
	end
	
	if trophyRight then
		group:insert( trophyRight )	
	end

	--scoreLabel.alpha = 0

	--[[
	bestScoreLabel = display.newText(group, 'HIGH SCORE : '..myData.currentHighScore, 20, 20, "Mecha", 70 )
	bestScoreLabel:setFillColor( 255 / 255, 255 / 255, 255 / 255 )
	bestScoreLabel.x = display.contentWidth * 0.5
	bestScoreLabel.y = display.contentHeight * 0.92
	]]

	--group:insert( playBtn )
	--group:insert( gameOverLabel )
	group:insert( scoreLabel )
	--group:insert( bestScoreLabel )
	--group:insert( scoreLabel )
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

	-- if myData.gameOver == true then

	-- 	gameOverLabel.alpha = 1
	-- 	scoreLabel:setText(myData.score)
	-- 	scoreLabel.alpha = 1

	-- 	if myData.score > myData.settings.highscore then
	-- 		myData.setHighscore(myData.score)
	-- 	end
	-- end

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