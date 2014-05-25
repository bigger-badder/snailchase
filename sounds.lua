

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
    	screamChannel = audio.play( fightSound );
	elseif soundName == "wing" then 
		fightChannel = audio.play( fightSound );
	end

end;


-- Streams

local backgroundMusic = audio.loadStream( "music.mp3" );
local backgroundMusicChannel;

playMusic = function()
	backgroundMusicChannel = audio.play( backgroundMusic, { channel=1, loops=-1, fadein=5000 } )
end;

stopMusic = function()
	audio.pause(backgroundMusicChannel);
end;



-- Play the background music on channel 1, loop infinitely, and fade in over 5 seconds 
local backgroundMusicChannel = audio.play( backgroundMusic, { channel=1, loops=-1, fadein=5000 } )

-- Play the speech on any available channel, for 30 seconds at most, and invoke listener function when audio finishes
local narrationChannel = audio.play( narrationSpeech, { duration=30000, onComplete=narrationFinished } )

-- Play the laser on any available channel
local laserChannel = audio.play( laserSound )