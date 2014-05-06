-- App settings
display.setStatusBar( display.HiddenStatusBar )

local myData = require('myData')

-- Load Corona 'ads' library
ads = require "ads"

local adsClass = require('adsClass')

-- include the Corona "storyboard" module
local storyboard = require "storyboard"

-- load menu screen
storyboard.gotoScene( "menu" )