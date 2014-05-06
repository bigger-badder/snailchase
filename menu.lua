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

-- Called when the scene's view does not exist:
function scene:createScene( event )
	local group = self.view

	-- background should appear behind all scenes
	local background = display.newImage( "images/cover.jpg" )
	background.width = display.contentWidth
	background.height = display.contentHeight
	background.anchorX = 0
	background.anchorY = 0
	background.x = 0
	background.y = 0
	group:insert(background)

	local label = display.newText(group, "Snail race", 20, 20, "Verdana", 20 )
	label:setTextColor( 255, 255, 255 )
	label.x = display.contentWidth * 0.5

	playBtn = widget.newButton{
		label="Tap to Play",
		labelColor = { default={255}, over={128} },
		width=80, height=40,
		onRelease = function()
			-- launch the game scene
			storyboard.gotoScene( "game", "slideLeft", 200 )
		end
	}
	playBtn.x = display.contentWidth * 0.5
	playBtn.y = display.contentHeight * 0.95

	gameOverLabel = display.newText(group, 'Score', 20, 20, "Verdana", 20 )
	gameOverLabel:setFillColor( 255, 255, 255 )
	gameOverLabel.x = display.contentWidth * 0.5
	gameOverLabel.y = display.contentHeight * 0.3
	gameOverLabel.alpha = 0

	scoreLabel = display.newText(group, 0, 20, 20, "Verdana", 20 )
	scoreLabel:setFillColor( 255, 255, 255 )
	scoreLabel.x = display.contentWidth * 0.5
	scoreLabel.y = display.contentHeight * 0.4
	scoreLabel.alpha = 0

	bestScoreLabel = display.newText(group, 'Best: '..myData.currentHighScore, 20, 20, "Verdana", 20 )
	bestScoreLabel:setFillColor( 255, 255, 255 )
	bestScoreLabel.x = display.contentWidth * 0.5
	bestScoreLabel.y = display.contentHeight * 0.8

	group:insert( playBtn )
	group:insert( bestScoreLabel )
end

function scene:destroyScene( event )
	local group = self.view

	if playBtn then
		playBtn:removeSelf()
		playBtn = nil
	end
end

function scene:enterScene(event)

	local group = self.view

	if myData.gameOver == true then

		gameOverLabel.alpha = 1
		scoreLabel.text = myData.score
		scoreLabel.alpha = 1

		-- save highscore
		local tablefill = [[INSERT INTO highscore VALUES (NULL, ']]..myData.score..[['); ]]
		myData.db:exec( tablefill )

		if myData.score > myData.currentHighScore then
			myData.currentHighScore = myData.score
		end
	end

	bestScoreLabel.text = 'Best: '..myData.currentHighScore
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