print("running ads");

local function iAdsListener( event )
   if ( event.isError ) then
      console.log("error on iAd")
   end
   return true
end

local function adMobListener( event )
   if ( event.isError ) then
      console.log("error on ad mob")
   end
   return true
end


showAd = function( adType )
	local adX, adY = display.screenOriginX, 0
	--statusText.text = "Working..."
	ads.show( adType, { x=adX, y=adY, testMode=true } )
end

if ( system.getInfo("platformName") == "Android" ) then
   ads.init( "admob", "ca-app-pub-6811948289977255/6890778124", adMobListener )
else
   ads.init( "iads", "com.snail.chase", iAdsListener )
end


ads:setCurrentProvider( "iads" )

