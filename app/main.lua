-- App settings
display.setStatusBar( display.HiddenStatusBar )

local loadsave = require('loadsave')

-- fix for mte having small gaps between tiles
display.setDefault("minTextureFilter", "nearest")
display.setDefault("magTextureFilter", "nearest")

local myData = require('myData')

require( "highscore" )

-- Load Corona 'ads' library
ads = require "ads"

trophies = {
	gold = 300,
	silver = 150,
	bronze = 75
}

local adsClass = require('adsClass')
local sounds = require('sounds')

function loadSettingsFile()
	settings = loadsave.loadTable("settings.json")

	if settings == nil then
		settings = {}
		settings.highscore = 0
		settings.musicOn = false
		settings.soundOn = false
		myData.settings = settings
		loadsave.saveTable(settings, 'settings.json')
	end

	myData.settings = settings
end
loadSettingsFile()

function myData.setSound( event )

	if event.phase ~= "began" then
		--return
	end

	myData.settings.soundOn = not myData.settings.soundOn
	print(myData.settings.soundOn)
	loadsave.saveTable(myData.settings, 'settings.json')
end

function myData.setMusic( event )

	if event.phase ~= "began" then
		--return
	end

	myData.settings.musicOn = not myData.settings.musicOn
	print(myData.settings.musicOn)
	loadsave.saveTable(myData.settings, 'settings.json')
end

function myData.setHighscore( score )

	myData.settings.highscore = score
	loadsave.saveTable(myData.settings, 'settings.json')
end

-- include the Corona "storyboard" module
local storyboard = require "storyboard"

-- load menu screen
storyboard.gotoScene( "menu" )
