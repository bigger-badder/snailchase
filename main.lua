-- App settings
display.setStatusBar( display.HiddenStatusBar )

local loadsave = require('loadsave')

-- fix for mte having small gaps between tiles
display.setDefault("minTextureFilter", "nearest")
display.setDefault("magTextureFilter", "nearest")

local myData = require('myData')

-- Load Corona 'ads' library
ads = require "ads"

local adsClass = require('adsClass')
local sounds = require('sounds')

--Include sqlite
local sqlite3 = require "sqlite3"

--Open data.db.  If the file doesn't exist it will be created
local path = system.pathForFile("settings.db", system.DocumentsDirectory)
myData.db = sqlite3.open( path ) 

--Handle the applicationExit event to close the db
local function onSystemEvent( event )
    if( event.type == "applicationExit" ) then              
        myData.db:close()
    end
end

function loadSettingsFile()
	settings = loadsave.loadTable("settings.json")

	if settings == nil then
		settings = {}
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
		return
	end

	myData.settings.soundOn = not myData.settings.soundOn
	print(myData.settings.soundOn)
	loadsave.saveTable(myData.settings, 'settings.json')
end

function myData.setMusic( event )

	if event.phase ~= "began" then
		return
	end

	myData.settings.musicOn = not myData.settings.musicOn
	print(myData.settings.musicOn)
	loadsave.saveTable(myData.settings, 'settings.json')
end

--Setup the table if it doesn't exist
local highscoreTablesetup = [[CREATE TABLE IF NOT EXISTS highscore (id INTEGER PRIMARY KEY, score INTEGER);]]

myData.db:exec( highscoreTablesetup )

myData.currentHighScore = 0
for row in myData.db:nrows("SELECT * FROM highscore") do
    if row.score > myData.currentHighScore then
    	myData.currentHighScore = row.score
    end
end

-- include the Corona "storyboard" module
local storyboard = require "storyboard"

-- load menu screen
storyboard.gotoScene( "menu" )

--setup the system listener to catch applicationExit
Runtime:addEventListener( "system", onSystemEvent )
