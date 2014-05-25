local myData    = require('myData')

-- Sound Effects

local fightSound = audio.loadSound( "sound-fight.wav" );
local fightChannel;
local screamSound = audio.loadSound( "sound-scream.wav" );
local screamChannel;

playSound = function(soundName)
	
	if myData.settings.soundOn ~= true then
		return
	end

	if soundName == "fight" then 
		fightChannel = audio.play( fightSound );
		audio.setVolume( 0.25, fightChannel ) 
    elseif soundName == "scream" then 
    	screamChannel = audio.play( screamSound );
    	audio.setVolume( 0.75, screamChannel ) 
	elseif soundName == "wing" then 
		wingChannel = audio.play( wingSound );
	end

end;


-- Streams

backgroundMusic = audio.loadStream( "music.mp3" );
backgroundMusicChannel = nil;

playMusic = function()

	if myData.settings.musicOn ~= true then
		return
	end

	print("play music")
	audio.rewind( backgroundMusic )
	backgroundMusicChannel = audio.play( backgroundMusic, { channel=1, loops=-1, fadein=5000 } )

end;

stopMusic = function()
	print("stop music")
	audio.stop(backgroundMusicChannel);
end;



wingsSounds = audio.loadStream( "sound-wing2.wav" );
wingsSoundsChannel = nil;

playWings = function()
	print("play wings")
	--audio.rewind( wingsSounds )
	--wingsSoundsChannel = audio.play( wingsSounds, { channel=1, loops=-1 } )

end;

stopWings = function()
	--print("stop wings")
	--audio.stop(wingsSoundsChannel);
end;

