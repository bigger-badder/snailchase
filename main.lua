-- App settings
display.setStatusBar( display.HiddenStatusBar )

local myData = require('myData')

-- Load Corona 'ads' library
ads = require "ads"

local adsClass = require('adsClass')
local sounds = require('sounds')

--Include sqlite
local sqlite3 = require "sqlite3"

--Open data.db.  If the file doesn't exist it will be created
local path = system.pathForFile("highscore.db", system.DocumentsDirectory)
myData.db = sqlite3.open( path ) 

--Handle the applicationExit event to close the db
local function onSystemEvent( event )
    if( event.type == "applicationExit" ) then              
        myData.db:close()
    end
end

--Setup the table if it doesn't exist
local tablesetup = [[CREATE TABLE IF NOT EXISTS highscore (id INTEGER PRIMARY KEY, score INTEGER);]]
print(tablesetup)
myData.db:exec( tablesetup )

myData.currentHighScore = 0
for row in myData.db:nrows("SELECT * FROM highscore") do
    if row.score > myData.currentHighScore then
    	myData.currentHighScore = row.score
    end
end

print(myData.currentHighScore)

-- include the Corona "storyboard" module
local storyboard = require "storyboard"

-- load menu screen
storyboard.gotoScene( "menu" )

--setup the system listener to catch applicationExit
Runtime:addEventListener( "system", onSystemEvent )
