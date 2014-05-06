-- add Corona's Storyboard module
local storyboard = require( "storyboard" )

-- create a new scene
local scene = storyboard.newScene()

-- include Corona's "widget" library, we need it for buttons
local widget = require "widget"

-- forward declarations for our level selection buttons
-- needed to remove the buttons from the scene in destroyScene
local playBtn

local myData = require('myData')


-- Called when the scene's view does not exist:
function scene:createScene( event )
	local group = self.view

	local label = display.newText(group, "Snail race", 20, 20, "Verdana", 20 )
	label:setTextColor( 255, 255, 255 )
	label.x = display.contentWidth * 0.5

	playBtn = widget.newButton{
		label="Play now",
		labelColor = { default={255}, over={128} },
		width=80, height=40,
		onRelease = function()
			-- launch the game scene
			storyboard.gotoScene( "game", "slideLeft", 200 )
		end
	}
	playBtn.x = display.contentWidth * 0.5
	playBtn.y = display.contentHeight * 0.5

	group:insert( playBtn )	
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

	print(myData.gameOver)
	if myData.gameOver == true then
		print('Display game over text')
		local gameOverLabel = display.newText(group, "Game Over", 20, 20, "Verdana", 20 )
		gameOverLabel:setTextColor( 255, 255, 255 )
		gameOverLabel.x = display.contentWidth * 0.5
		gameOverLabel.y = display.contentHeight * 0.3
	end
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