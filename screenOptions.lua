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
-- screenOptions.lua
------------------------------------------------------------------------------------------------------------------------------------

---------------------------------------------------------------
-- Require all of the external modules for this level
---------------------------------------------------------------
local composer 			= require( "composer" )
local scene 			= composer.newScene()
local ui 				= require("ui")
local widget 			= require("widget")
local myGlobalData 		= require("globalData")
local loadsave 			= require("loadsave")
require "sprite"

---------------------------------------------------------------
-- Define our SCENE variables and sprite object variables
---------------------------------------------------------------
local screenW, screenH, halfW = display.contentWidth, display.contentHeight, display.contentWidth*0.5
local shadowBox
local previousMusicVolume
local previousSFXVolume

previousMusicVolume 	= myGlobalData.volumeMusic
previousSFXVolume 		= myGlobalData.volumeSFX



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
	--colouredSquare:setFillColor(101,57,166)--purple
	colouredSquare.anchorX = 0.0		-- Graphics 2.0 Anchoring method
	colouredSquare.anchorY = 0.0		-- Graphics 2.0 Anchoring method
	colouredSquare:setFillColor(0.15,0.26,0.62)--blue
	screenGroup:insert( colouredSquare )
	colouredSquare.alpha = 1.0

	local bgImageVisual = display.newImageRect( myGlobalData.imagePath.."Background_Overlay.png", 384,569 )
	bgImageVisual.anchorX = 0.0		-- Graphics 2.0 Anchoring method
	bgImageVisual.anchorY = 0.0		-- Graphics 2.0 Anchoring method
	--bgImageVisual.x = myGlobalData._w/2
	--bgImageVisual.y = myGlobalData._h/2
	screenGroup:insert( bgImageVisual )
	bgImageVisual.alpha = 1.0
		
	-------------------------------------------------------------------------------------------------------------
	--Temp Debug grid overlay
	-------------------------------------------------------------------------------------------------------------
	if (myGlobalData.showDebugGrid == true)then
		local bgImageVisual = display.newImageRect( myGlobalData.imagePath.."iPhone_grid_PortraitINV.png", 320,480 )
		--bgImageVisual:setReferencePoint( display.TopLeftReferencePoint )
		bgImageVisual.anchorX = 0.0		-- Graphics 2.0 Anchoring method
		bgImageVisual.anchorY = 0.0		-- Graphics 2.0 Anchoring method
		bgImageVisual.x = 0--myGlobalData._w/2
		bgImageVisual.y = 0--myGlobalData._h/2
		screenGroup:insert( bgImageVisual )
		bgImageVisual.alpha = 0.35
	end
	
	-------------------------------------------------------------------------------------------------------------
	--add the game logo
	-------------------------------------------------------------------------------------------------------------
	--logo = display.newImageRect( myGlobalData.imagePath.."cutTheCookie_logo.png", 286,172 )
	logo = display.newSprite( myGlobalData.imageSheet, myGlobalData.animationSequenceData )
	logo:setSequence( "cutTheCookie_logo" )
	logo:play()
	logo.x = myGlobalData._w/2; logo.y = 100; logo.alpha = 1.0
	screenGroup:insert( logo )
	
	-------------------------------------------------------------------------------------------------------------
	-- Music OFF Button
	-------------------------------------------------------------------------------------------------------------
	local buttonBase = widget.newButton{
	sheet = myGlobalData.imageSheet, defaultFrame = 9, overFrame = 10, onRelease = buttonMusicSwitch, }
	--buttonBase:setReferencePoint(display.CenterReferencePoint)
	buttonBase.x = (myGlobalData._w/2)-55; buttonBase.y = 220
	screenGroup:insert( buttonBase )

	iconMusic = display.newSprite( myGlobalData.imageSheet, myGlobalData.animationSequenceData )
	iconMusic:setSequence( "iconMusic" )
	iconMusic.alpha=1.0
	iconMusic.x = buttonBase.x; iconMusic.y = buttonBase.y; iconMusic:play()
	screenGroup:insert(iconMusic)
	-------------------------------------------------------------------------------------------------------------

	-------------------------------------------------------------------------------------------------------------
	-- SFX OFF Button
	-------------------------------------------------------------------------------------------------------------
	local buttonBase = widget.newButton{
	sheet = myGlobalData.imageSheet, defaultFrame = 9, overFrame = 10, onRelease = buttonSFXSwitch, }
	--buttonBase:setReferencePoint(display.CenterReferencePoint)
	buttonBase.x = (myGlobalData._w/2)+55; buttonBase.y = 220
	screenGroup:insert( buttonBase )

	iconSFX = display.newSprite( myGlobalData.imageSheet, myGlobalData.animationSequenceData )
	iconSFX:setSequence( "iconSFX" )
	iconSFX.alpha=1.0
	iconSFX.x = buttonBase.x; iconSFX.y = buttonBase.y; iconSFX:play()
	screenGroup:insert(iconSFX)
	-------------------------------------------------------------------------------------------------------------

	-------------------------------------------------------------------------------------------------------------
	-- Button ABOUT
	-------------------------------------------------------------------------------------------------------------
	local buttonBase = widget.newButton{
	sheet = myGlobalData.imageSheet, defaultFrame = 5, overFrame = 6, onRelease = buttonAbout, }
	--buttonBase:setReferencePoint(display.CenterReferencePoint)
	buttonBase.x = myGlobalData._w/2; buttonBase.y = 280
	buttonBase.xScale = 1.2
	screenGroup:insert( buttonBase )

	local buttonText = display.newSprite( myGlobalData.imageSheet, myGlobalData.animationSequenceData )
	buttonText:setSequence( "textAbout" )
	buttonText.x = myGlobalData._w/2; buttonText.y = 280; buttonText:play()
	screenGroup:insert(buttonText)
	-------------------------------------------------------------------------------------------------------------

	-------------------------------------------------------------------------------------------------------------
	-- Back Button
	-------------------------------------------------------------------------------------------------------------
	local buttonBase = widget.newButton{
	sheet = myGlobalData.imageSheet, defaultFrame = 1, overFrame = 2, onRelease = buttonBack, }
	--buttonBase:setReferencePoint(display.CenterReferencePoint)
	buttonBase.x = 30; buttonBase.y = myGlobalData._h-30
	screenGroup:insert( buttonBase )

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

		composer.removeScene( "screenGamePause" )
		composer.removeScene( "screenResetLevel" )
		composer.removeScene( "screenStart" )
		composer.removeScene( "screenWorldSelect" )
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


---------------------------------------------------------------
-- Music button switch
---------------------------------------------------------------
function buttonMusicSwitch()
	audio.play(sfx_Select)
	
	if(myGlobalData.musicON==true) then
		myGlobalData.musicON = false
		myGlobalData.volumeMusic = 0.0
		iconMusic.alpha = 0.5
	else
		myGlobalData.musicON = true
		myGlobalData.volumeMusic = previousMusicVolume
		iconMusic.alpha = 1.0
	end

	--set the MUSIC channels volumes
	for i=1,3 do
		audio.setVolume( myGlobalData.volumeMusic, { channel=i } )
	end

	--print("Music Volume State: "..myGlobalData.volumeMusic)
	return true
end

---------------------------------------------------------------
-- SFX button switch
---------------------------------------------------------------
function buttonSFXSwitch()
	audio.play(sfx_Select)

	if(myGlobalData.soundON==true) then
		myGlobalData.soundON = false
		myGlobalData.volumeSFX = 0.0
		iconSFX.alpha = 0.5
	else
		myGlobalData.soundON = true
		myGlobalData.volumeSFX = previousSFXVolume
		iconSFX.alpha = 1.0
	end
	
	--set the SFX channels volumes
	for i = 4, 32 do
		audio.setVolume( myGlobalData.volumeSFX, { channel=i } )
	end
	
	---------------------------------------------------------------------------------------------------------
	--Play the star collected sfx
	---------------------------------------------------------------------------------------------------------
	audio.stop(20)
	audio.play(sfx_FingerInTheWay, {channel=20})
	
	--print("SFX Volume State: "..myGlobalData.volumeSFX)
	return true
end




---------------------------------------------------------------
-- Show the ABOUT APP info
---------------------------------------------------------------
function buttonAbout()
	audio.play(sfx_Select)

	local options = {
	effect = "slideDown", time = 200, isModal=true
	}

	composer.showOverlay("screenAbout", options )	--This is our Pause Screen

	return true
end
----------------------------------------------------------------------------------------

---------------------------------------------------------------
-- back button function
---------------------------------------------------------------
function buttonBack()
	audio.play(sfx_Select)
	composer.gotoScene( "screenStart", "crossFade", 200  )
	return true
end




---------------------------------------------------------------------------------
-- Listener setup
scene:addEventListener( "create", scene )
scene:addEventListener( "show", scene )
scene:addEventListener( "hide", scene )
scene:addEventListener( "destroy", scene )

---------------------------------------------------------------------------------

return scene