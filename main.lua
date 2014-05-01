-- App settings
display.setStatusBar( display.HiddenStatusBar )

local myData = require('myData')

-- include the Corona "storyboard" module
local storyboard = require "storyboard"

-- load menu screen
storyboard.gotoScene( "menu" )