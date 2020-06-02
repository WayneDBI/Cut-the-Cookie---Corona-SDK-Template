------------------------------------------------------------------------------------------------------------------------------------
-- CUT THE COOKIE Corona SDK Template
------------------------------------------------------------------------------------------------------------------------------------
-- Developed by Deep Blue Ideas.com [www.deepbueideas.com]
------------------------------------------------------------------------------------------------------------------------------------
-- Abstract: Get the cookie to the Chef hero. Along the way try and collect as many stars as possible.
-- Avoid any obstacles such as spikes. The Cookie is connect by a series of ropes on the
-- screen, which the user mush cut to get the cookie to the desired location.
------------------------------------------------------------------------------------------------------------------------------------
-- Release Version 2
-- Code developed for CORONA SDK STABLE RELEASE 2018.3326
-- 23rd December 2018
------------------------------------------------------------------------------------------------------------------------------------
-- screenWorldSelect.lua
------------------------------------------------------------------------------------------------------------------------------------

---------------------------------------------------------------
-- Require all of the external modules for this level
---------------------------------------------------------------
local ui 				= require("ui")
local widget 			= require("widget")
local myGlobalData 		= require("globalData")
local loadsave 			= require("loadsave")
local composer 			= require( "composer" )
local scene 			= composer.newScene()
require "sprite"

---------------------------------------------------------------
-- Get the LEVEL and WORLD stars/unlocked data
---------------------------------------------------------------
local statsSetup 	= {}	-- This is our WORLD and LEVEL data table. We'll store how many stars were collected etc in here..
statsSetup = saveDataTable.levelStats

---------------------------------------------------------------
-- Define our SCENE variables and sprite object variables
---------------------------------------------------------------
local screenW			= display.contentWidth
local screenH			= display.contentHeight
local halfW 			= display.contentWidth*0.5
local boxArray 			= {}
local boxLockArray 		= {}
local boxTextArray 		= {}
local heroImage 		= nil
local math_abs 			= math.abs
local cw 				= display.contentWidth
local ch 				= display.contentHeight
local ox 				= math_abs(display.screenOriginX)
local oy 				= math_abs(display.screenOriginY)
local sliderGroup 		= display.newGroup()
local bufferGroup 		= display.newGroup()
local dotGroup 			= display.newGroup()
local previousMusicVolume
local previousSFXVolume
local heroMask

---------------------------------------------------------------
-- Swipe variables
---------------------------------------------------------------
local pageDots 			= {}  		--table to reference dots which indicate current slide position
local slideDist 		= cw+ox+ox  --total left-to-right distance of a slide
local slideIndex 		= 0
local touchPos 			= 0
local lastPos 			= 0
local touchTime 		= 0
local coreSwipeDist 	= cw/10
local coreSwipeTime 	= 300
local slideTrans 		= 0  		--the tween transition variable; when set to 0, transition is not happening.
local maxSlideIndex 	= 0  		--max number of slides, to be automatically set later.
local resist 			= 1
local inTouch 			= false

------------------------------------------------------------------------------------------------------------------------------------
--Update slide position dots
------------------------------------------------------------------------------------------------------------------------------------
local function updateDots( sIndex )
	for d=1,#pageDots do
		if ( d == sIndex+1 ) then
			pageDots[d].alpha = 1.0
		else
			pageDots[d].alpha = 0.3
		end
	end
end

------------------------------------------------------------------------------------------------------------------------------------
--Completed slide transition
------------------------------------------------------------------------------------------------------------------------------------
local function transComplete( event )
	transition.cancel( slideTrans ) ; slideTrans = 0
	local targetX = (slideIndex*-slideDist) ; if ( sliderGroup.x ~= targetX ) then sliderGroup.x = targetX end
	updateDots( slideIndex )
	--print("Slide Index: "..slideIndex)
	
	local delayAction = timer.performWithDelay( 5, squishTheBox )
	delayAction.whichBox = boxArray[slideIndex+1]
	delayAction.whichText = boxTextArray[slideIndex+1]
	delayAction.whichLock = boxLockArray[slideIndex+1]
	
	heroImage.alpha=1.0
end

------------------------------------------------------------------------------------------------------------------------------------
--Transition to next slide
------------------------------------------------------------------------------------------------------------------------------------
local function slideTween( targetX )
	local transTime = ( (math_abs(sliderGroup.x-targetX))/slideDist) * 400
	if ( slideTrans ~= 0 ) then
		transition.cancel( slideTrans )
		slideTrans = 0
	end
	slideTrans = transition.to( sliderGroup, { x=targetX, time=transTime, transition = easing.outQuad, onComplete=transComplete } )
end

------------------------------------------------------------------------------------------------------------------------------------
--Go to slide function, optional
------------------------------------------------------------------------------------------------------------------------------------
--This function can be used to either "snap" or "move" to a specific slide in your stack.
--Usage:	FOR SNAP: gotoSlide( [slide], "snap" )
--			FOR MOVE: gotoSlide( [slide], "move" )
local function gotoSlide( targetSlide, method )

	if ( slideTrans ~= 0 ) then
		transition.cancel( slideTrans )
		slideTrans = 0
	end

	local si 	= targetSlide-1
	slideIndex 	= si
	local destX = (si*-slideDist)
	
	if ( method == "snap" ) then
		sliderGroup.x = destX
		updateDots( si )
	else
		slideTween( destX )
	end
	
end


-----------------------------------------------
--Core swipe function
-----------------------------------------------
local function screenMotion( event )

		local phase = event.phase ; local eventX = event.x ; local eventY = event.y

		if ( "began" == phase ) then
			inTouch = true
			if ( slideTrans ~= 0 ) then transition.cancel( slideTrans ) ; slideTrans = 0 end
			touchPos = eventX ; lastPos = eventX ; touchTime = event.time
			
		elseif ( "moved" == phase and inTouch == true ) then
			local dist = eventX-lastPos ; local res = resist

			if ( ( slideIndex == 0 and dist > 0 ) or ( slideIndex == maxSlideIndex and dist < 0 ) ) then res = 0.3 else res = 1 end
			sliderGroup.x = sliderGroup.x+(dist*res) ; lastPos = eventX ; resist = res
			
			local overallDist = math_abs( sliderGroup.x+(slideIndex*slideDist) )
			local overallDist2 = math_abs( sliderGroup.x )
			--print(overallDist2)
			
			if (overallDist>74) then
				heroImage.alpha=0 	-- Hide Hero
			else
				heroImage.alpha=1.0 -- Show Hero
			end

		elseif ( "ended" == phase or "off" == phase or "cancelled" == phase ) then
			inTouch = false
			local motionTime = system.getTimer()-touchTime
			local dist = eventX-touchPos ; local swipeDist = math_abs( dist )
			local overallDist = math_abs( sliderGroup.x+(slideIndex*slideDist) )
			local goNextSlide = false

			if ( resist ~= 1 ) then goNextSlide = false
			elseif ( motionTime <= coreSwipeTime and swipeDist >= coreSwipeDist ) then goNextSlide = true
			elseif ( motionTime > coreSwipeTime and overallDist >= slideDist*0.5 ) then goNextSlide = true end
		
			if ( goNextSlide == true and dist < 0 and resist == 1 ) then slideIndex = slideIndex+1
			elseif ( goNextSlide == true and dist > 0 and resist == 1 ) then slideIndex = slideIndex-1 end
			slideTween( slideIndex*-slideDist )
			
		end
end

-----------------------------------------------
--set the audio volumes accordingly
-----------------------------------------------
previousMusicVolume 	= myGlobalData.volumeMusic
previousSFXVolume 		= myGlobalData.volumeSFX

-----------------------------------------------
--setup the back button function
-----------------------------------------------
function buttonBack()
	audio.play(sfx_Select)
	composer.gotoScene( "screenStart", "crossFade", 200  )
	return true
end

---------------------------------------------------------------------------
--create a squishy effect to the WORLDS as the user slides them
---------------------------------------------------------------------------
function squishTheBox(event)
	local whichBox = event.source.whichBox
	local whichText = event.source.whichText
	local whichLock = event.source.whichLock

		local function trans4Start()
			trans4a = transition.to( whichBox, { xScale=1.0, yScale=1.0, time=60 } )
			trans4b = transition.to( whichText, { xScale=1.0, yScale=1.0, time=60 } )
			trans4c = transition.to( whichLock, { xScale=1.0, yScale=1.0, time=60 } )
		end

		local function trans3Start()
			trans3a = transition.to( whichBox, { xScale=0.9, yScale=1.1, time=80, onComplete=trans4Start } )
			trans3b = transition.to( whichText, { xScale=0.9, yScale=1.1, time=80, onComplete=trans4Start } )
			trans3c = transition.to( whichLock, { xScale=0.9, yScale=1.1, time=80, onComplete=trans4Start } )
		end

		local function trans2Start()
			trans2a = transition.to( whichBox, { xScale=1.2, yScale=0.9, time=120, onComplete=trans3Start } )
			trans2b = transition.to( whichText, { xScale=1.2, yScale=0.9, time=120, onComplete=trans3Start } )
			trans2c = transition.to( whichLock, { xScale=1.2, yScale=0.9, time=120, onComplete=trans3Start } )
		end
		
		trans1a = transition.to( whichBox, { xScale=0.8,yScale=1.1, time=80, onComplete=trans2Start } )
		trans1b = transition.to( whichText, { xScale=0.8,yScale=1.1, time=80, onComplete=trans2Start } )
		trans1c = transition.to( whichLock, { xScale=0.8,yScale=1.1, time=80, onComplete=trans2Start } )

end

---------------------------------------------------------------------------
--trigger for the selected world
---------------------------------------------------------------------------
function selectAWorld( event )
	audio.play(sfx_BeenHereBefore)

	---------------------------------------------------------------------------
	--get the ID of the selected world
	---------------------------------------------------------------------------
	local btnId 	= event.target.id

	print("Tapped World: "..btnId)
	
	---------------------------------------------------------------------------
	-- Only goto the WORLD level select, if the user has unlocked the 1st level of the world selected!
	---------------------------------------------------------------------------
	local getWorldDetails = statsSetup[btnId][1][1]
	if (getWorldDetails < 4) then
		---------------------------------------------------------------------------
		-- set the chosen WORLD to the global variable
		---------------------------------------------------------------------------
		myGlobalData.worldSelected = btnId
		composer.gotoScene( "screenLevelSelect", "crossFade", 200  )
	end

	--local buildPathToLevel = myGlobalData.worldPath.."World"..myGlobalData.worldSelected.."_Levels.level"..myGlobalData.myLevel
	--composer.gotoScene( buildPathToLevel )	--This is our main menu
	--local btnSound	= event.target.tag
	------------------------------------
	--local saveX = event.target.x
	--local saveY = event.target.y
	------------------------------------
	--event.target[1].alpha = 0 -- img to be invisible
	--event.target[2].alpha = 1 -- img2 to be visible

	return true

end




-- "scene:create()"
function scene:create( event )

   -- Initialize the scene here.
   -- Example: add display objects to "sceneGroup", add touch listeners, etc.
   	local screenGroup = self.view

	-------------------------------------------------------------------------------------------------------------
	--Set up the SIZE for the level (Defaults to max width/Height) of the users device....
	-------------------------------------------------------------------------------------------------------------
	myGlobalData.levelSizeW = myGlobalData._w
	myGlobalData.levelSizeH = myGlobalData._h

	-------------------------------------------------------------------------------------------------------------
	--Draw the background image
	-------------------------------------------------------------------------------------------------------------
	local colouredSquare = display.newRect(0,0,myGlobalData._w,myGlobalData._h)
	colouredSquare.anchorX = 0.0		-- Graphics 2.0 Anchoring method
	colouredSquare.anchorY = 0.0		-- Graphics 2.0 Anchoring method
	--colouredSquare:setFillColor(0.39,0.22,0.65)--purple
	colouredSquare:setFillColor(0.15,0.26,0.62)--blue
	--colouredSquare:setFillColor(0.83,0.7,0.21)--Drk Yellow
	screenGroup:insert( colouredSquare )
	
	local bgImageVisual = display.newImageRect( myGlobalData.imagePath.."Background_Overlay.png", 384,569 )
	bgImageVisual.anchorX = 0.5		-- Graphics 2.0 Anchoring method
	bgImageVisual.anchorY = 0.5		-- Graphics 2.0 Anchoring method
	bgImageVisual.x = myGlobalData._w/2
	bgImageVisual.y = myGlobalData._h/2
	screenGroup:insert( bgImageVisual )
	bgImageVisual.alpha = 1.0

	--local logo = display.newImageRect( myGlobalData.imagePath.."cutTheCookie_logo.png", 286,172 )
	local logo = display.newSprite( myGlobalData.imageSheet, myGlobalData.animationSequenceData )
	logo:setSequence( "cutTheCookie_logo" )
	logo:play()
	logo.x = myGlobalData._w/2; logo.y = 100; logo.alpha = 1.0; logo.xScale = 1.0; logo.yScale = 1.0
	--screenGroup:insert( logo )

	------------------------------------------------------------------------------------
	--add our silly hero behind the ovens
	------------------------------------------------------------------------------------
	heroImage = display.newSprite( myGlobalData.imageSheet, myGlobalData.animationSequenceData )
	heroImage:setSequence( "heroBig" )
	heroImage:play()
	heroImage.x = myGlobalData._w/2

	if ( myGlobalData.iPhone5 == true ) then
		heroImage.y = (myGlobalData._h/2)+114
	else
		heroImage.y = (myGlobalData._h/2)+84
	end


	screenGroup:insert( heroImage )

	------------------------------------------------------------------------------------
	--Build the WOPRLD SLIDERS
	------------------------------------------------------------------------------------
	local thisSlideGroup

	------------------------------------------------------------------------------------
	--LOOP through how many WORLDS you want, as defined in the main.lua file
	------------------------------------------------------------------------------------
	for x = 1, myGlobalData.maxWorlds do
		----------------------------------------------------------------------------------------------------
		-- Slide 1
		----------------------------------------------------------------------------------------------------
		thisSlideGroup = display.newGroup() --IMPORTANT!!! Create a new display group for each slide!

		local slide_sprt = display.newGroup()
		local myImgGroup1 = display.newGroup()
		
		----------------------------------------------------------------------------------------------------
		-- add an invisible box over the screen to help with sliding touches
		-- disable the code block below, to only have the oven images receive the touches.
		----------------------------------------------------------------------------------------------------
		local bck_sprt = display.newImageRect( myGlobalData.imagePath.."slide_bck.png",myGlobalData._w,myGlobalData._h )
		--bck_sprt:setReferencePoint(display.CenterReferencePoint);
		bck_sprt.x=myGlobalData._w/2;bck_sprt.y=myGlobalData._h/2;
		slide_sprt:insert( bck_sprt )

		----------------------------------------------------------------------------------------------------
		--Draw the BOX
		----------------------------------------------------------------------------------------------------
		local img = display.newSprite( myGlobalData.imageSheet, myGlobalData.animationSequenceData )
		img:setSequence( "worldBox"..x )
		img.x = myGlobalData._w/2
		if ( myGlobalData.iPhone5 == true ) then
			img.y = (myGlobalData._h/2)+60
		else
			img.y = (myGlobalData._h/2)+30
		end
		img.id = x
		img:play()
		img:addEventListener( "tap", selectAWorld)
		boxArray[x] = img
		myImgGroup1:insert(img)
		
		----------------------------------------------------------------------------------------------------
		--Draw the World title
		----------------------------------------------------------------------------------------------------
		local imgTitle = display.newSprite( myGlobalData.imageSheet, myGlobalData.animationSequenceData )
		imgTitle:setSequence( "textWorld"..x )
		imgTitle.x = myGlobalData._w/2
		imgTitle.y = img.y+160
		imgTitle.id = x
		imgTitle:play()
		boxTextArray[x] = imgTitle
		myImgGroup1:insert(imgTitle)

		----------------------------------------------------------------------------------------------------
		--Add the WORLD lock if not yet available
		----------------------------------------------------------------------------------------------------
		local getWorldDetails = statsSetup[x][1][1]
		if (getWorldDetails == 4) then
			
			local imgLock = display.newSprite( myGlobalData.imageSheet, myGlobalData.animationSequenceData )
			imgLock:setSequence( "worldLocked" )
			imgLock.x = myGlobalData._w/2
			imgLock.y = img.y+41
			imgLock:play()
			boxLockArray[x] = imgLock
			myImgGroup1:insert(imgLock)
		end

		----------------------------------------------------------------------------------------------------
		--Add all the elements to a set group, and update alpha values etc
		----------------------------------------------------------------------------------------------------
		myImgGroup1.alpha = 1
		slide_sprt:insert( myImgGroup1 )
		thisSlideGroup:insert( slide_sprt )
		sliderGroup:insert( thisSlideGroup )
		thisSlideGroup.x = ((sliderGroup.numChildren-1)*slideDist)
		screenGroup:insert( sliderGroup )
		----------------------------------------------------------------------------------------------------
	end

	----------------------------------------------------------------------------------------------------
	-- Manage the Slider Groups children
	----------------------------------------------------------------------------------------------------
	maxSlideIndex = sliderGroup.numChildren-1
	screenGroup:insert( sliderGroup )

	----------------------------------------------------------------------------------------------------
	-- Add the indicator dots
	----------------------------------------------------------------------------------------------------
	local pageDots = pageDots
	for i = 1,maxSlideIndex+1 do
		--local dot = display.newCircle( dotGroup, i*20, 0, 5 ) ; dot:setFillColor(255,255,255)
		--local dot = display.newImageRect( dotGroup, "dot.png", 12, 12 ) ; dot.x = i*40
		local dot = display.newImageRect( dotGroup,myGlobalData.imagePath.."PageIndicatorNormal.png",10,10 ) ; dot.x = i*20
		pageDots[#pageDots+1] = dot
		--dot:setFillColor(0,0,0)
	end
	--dotGroup:setReferencePoint(display.BottomCenterReferencePoint)
	dotGroup.anchorX = 0.5		-- Graphics 2.0 Anchoring method
	dotGroup.anchorY = 1.0		-- Graphics 2.0 Anchoring method

	dotGroup.x = cw*0.35 ; dotGroup.y = ch-15+oy
	updateDots( 0 )

	----------------------------------------------------------------------------------------------------
	-- Add a touch listener to the slider
	----------------------------------------------------------------------------------------------------
	sliderGroup:addEventListener( "touch", screenMotion )  --core touch listener (only touch listener)
	screenGroup:insert( dotGroup )

	-------------------------------------------------------------------------------------------------------------
	-- Back Button
	-------------------------------------------------------------------------------------------------------------
	local buttonBase = widget.newButton{
	sheet = myGlobalData.imageSheet, defaultFrame = 1, overFrame = 2, onRelease = buttonBack, }
	--buttonBase:setReferencePoint(display.CenterReferencePoint)
	buttonBase.x = 30; buttonBase.y = myGlobalData._h-30
	screenGroup:insert( buttonBase )

	-------------------------------------------------------------------------------------------------------------
	-- Insert the GAME LOGO onto of everything
	-------------------------------------------------------------------------------------------------------------
	screenGroup:insert( logo )
	
	-----------------------------------------------------------------
	--Reserve Channels 1, 2, 3 for Specific audio
	-----------------------------------------------------------------
	audio.reserveChannels( 3 )

end

-- "scene:show()"
function scene:show( event )

   local sceneGroup = self.view
   local phase = event.phase

   if ( phase == "will" ) then
      -- Called when the scene is still off screen (but is about to come on screen).
   elseif ( phase == "did" ) then
		-- Called when the scene is now on screen.
		-- Insert code here to make the scene come alive.
		-- Example: start timers, begin animation, play audio, etc.

		myGlobalData.endGame = true

		local buildPathToLevel = myGlobalData.worldPath.."World"..myGlobalData.worldSelected.."_Levels.level"..myGlobalData.myLevel
		local buildLevelName = "level"..myGlobalData.myLevel

		print("Removing Scene: "..buildPathToLevel)
		print("Removing Scene(Name): "..buildLevelName)

		composer.removeScene( buildPathToLevel )
		composer.removeScene( buildLevelName )
		composer.removeScene( "screenGamePause" )
		composer.removeScene( "screenResetLevel" )
		composer.removeScene( "screenStart" )
		composer.removeScene( "screenOptions" )
		composer.removeScene( "screenLevelSelect" )
		composer.removeScene( "screenLevelComplete" )
		composer.removeHidden()

   end
end

-- "scene:hide()"
function scene:hide( event )

   local sceneGroup = self.view
   local phase = event.phase

   if ( phase == "will" ) then
      -- Called when the scene is on screen (but is about to go off screen).
      -- Insert code here to "pause" the scene.
      -- Example: stop timers, stop animation, stop audio, etc.
   elseif ( phase == "did" ) then
      -- Called immediately after scene goes off screen.
   end
end

-- "scene:destroy()"
function scene:destroy( event )

   local sceneGroup = self.view

   -- Called prior to the removal of scene's view ("sceneGroup").
   -- Insert code here to clean up the scene.
   -- Example: remove display objects, save state, etc.
end

---------------------------------------------------------------------------------

-- Listener setup
scene:addEventListener( "create", scene )
scene:addEventListener( "show", scene )
scene:addEventListener( "hide", scene )
scene:addEventListener( "destroy", scene )

---------------------------------------------------------------------------------

return scene