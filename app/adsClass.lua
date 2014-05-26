print("running ads");

local function iAdsListener( event )
   if ( event.isError ) then
      print("error on iAd")
   end
   return true
end

local function adMobListener( event )
   if ( event.isError ) then
      print("error on ad mob")
   end
   return true
end


showAd = function( adType, object )
	--statusText.text = "Working..."
	ads.show( adType, object)
end

if ( system.getInfo("platformName") == "Android" ) then
   --ads.init( "admob", "ca-app-pub-6811948289977255/8929464121", adMobListener )
else
   ads.init( "admob", "ca-app-pub-6811948289977255/8929464121", adMobListener )
   --ads.init( "iads", "com.snail.chase", iAdsListener )
end

ads:setCurrentProvider( "admob" )