

-- Sound Effects

local fightSound = audio.loadSound( "sound-fight.wav" );
local fightChannel;
local screamSound = audio.loadSound( "sound-scream.wav" );
local screamChannel;
local wingSound = audio.loadSound( "sound-wing.wav" );
local wingChannel;

playSound = function(soundName)
	
	if soundName == "fight" then 
		fightChannel = audio.play( fightSound );
    elseif soundName == "scream" then 
    	screamChannel = audio.play( screamSound );
	elseif soundName == "wing" then 
		wingChannel = audio.play( wingSound );
	end

end;


-- Streams

backgroundMusic = audio.loadStream( "music.mp3" );
backgroundMusicChannel = nil;

playMusic = function()
	print("play music")
	--audio.rewind( backgroundMusic )
	--backgroundMusicChannel = audio.play( backgroundMusic, { channel=1, loops=-1, fadein=5000 } )

end;

stopMusic = function()
	print("stop music")
	--audio.stop(backgroundMusicChannel);
end;



wingsSounds = audio.loadStream( "sound-wing.wav" );
wingsSoundsChannel = nil;

playWings = function()
	print("play wings")
	audio.rewind( wingsSounds )
	wingsSoundsChannel = audio.play( wingsSounds, { channel=1, loops=-1 } )

end;

stopWings = function()
	print("stop wings")
	audio.stop(wingsSoundsChannel);
end;

