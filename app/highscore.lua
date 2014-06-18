function displayHighScores()

	local HSgroup = nil;

	function bgTouched(evt)
		return true
	end

	function bgTapped(evt)
		HSgroup:removeSelf( );
		return true
	end

	function openSubmitScreen()

		HSgroup:removeSelf( );

		local HSSubGroup = display.newGroup()
		HSgroup.x = display.screenOriginX;
		HSgroup.y = display.screenOriginY;

		local HSSubbackground = display.newRect(0,0,display.viewableContentWidth,display.viewableContentHeight);
		HSSubbackground.anchorX = 0;
		HSSubbackground.anchorY = 0;
		HSSubbackground:setFillColor(0,0.8)
		HSSubGroup:insert(HSSubbackground)

		function bgTouched(evt)
			return true
		end

		function bgTapped(evt)
			HSSubGroup:removeSelf( );
			return true
		end

	  	HSSubbackground:addEventListener("touch", bgTouched)
	  	HSSubbackground:addEventListener("tap", bgTapped)

	  	local defaultField

		local function textListener( event )

			if ( event.phase == "editing" ) then
	            local txt = event.text            
	            if(string.len(txt)>5)then
	                txt=string.sub(txt, 1, 5)
	                event.text=txt
	            end
		    end
		    
		end

		local width = display.viewableContentWidth * 0.7
		local xPos = (display.screenOriginX) + display.viewableContentWidth / 2
		local yPos = (display.screenOriginY) + display.viewableContentHeight/ 2


		defaultField = native.newTextField( xPos, yPos, width, 100 )
		defaultField.font = native.newFont( native.systemFontBold, 30 )

		defaultField:addEventListener( "userInput", textListener )
		HSSubGroup:insert(defaultField)


	end


	-- start code

	HSgroup = display.newGroup();
	HSgroup.x = display.screenOriginX;
	HSgroup.y = display.screenOriginY;

	local HSbackground = display.newRect(0,0,display.viewableContentWidth,display.viewableContentHeight);
	HSbackground.anchorX = 0;
	HSbackground.anchorY = 0;
	HSbackground:setFillColor(0,0.8)
	HSgroup:insert(HSbackground)

  	HSbackground:addEventListener("touch", bgTouched)
  	HSbackground:addEventListener("tap", bgTapped)

	local HSTitle = display.newImage( "images/highScoresTitle.png" )
	HSTitle.x = display.viewableContentWidth / 2;
	HSTitle.y = 200;
	HSgroup:insert(HSTitle)

	local HSSubmit = display.newImage( "images/submitScoreBtn.png" )
	HSSubmit.x = display.viewableContentWidth / 2;
	HSSubmit.y = display.viewableContentHeight - 200;
	HSgroup:insert(HSSubmit)
	HSSubmit:addEventListener("tap", openSubmitScreen)



end
