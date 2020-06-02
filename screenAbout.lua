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
-- screenAbout.lua
------------------------------------------------------------------------------------------------------------------------------------

---------------------------------------------------------------------------------
-- BEGINNING OF IMPLEMENTATION
---------------------------------------------------------------------------------
local composer 				= require( "composer" )
local scene 				= composer.newScene()
local ui 				= require("ui")
local widget 			= require "widget"
local myGlobalData 		= require( "globalData" )
local dataReset			= require("actor_ResetVariables")



-- "scene:create()"
function scene:create( event )

   -- Initialize the scene here.
   -- Example: add display objects to "sceneGroup", add touch listeners, etc.
   	local screenGroup = self.view
	
	-------------------------------------------------------------------------------------------------------------
	-- Darken background
	-------------------------------------------------------------------------------------------------------------
	local myRectangle = display.newRect(0, 0, myGlobalData._w, myGlobalData._h)
	myRectangle:setFillColor(0,0,0)
	myRectangle.anchorX = 0.5		-- Graphics 2.0 Anchoring method
	myRectangle.anchorY = 0.5		-- Graphics 2.0 Anchoring method
	myRectangle.x = myGlobalData._w/2
	myRectangle.y = myGlobalData._h/2
	myRectangle.alpha=0.9
	screenGroup:insert(myRectangle)

	-------------------------------------------------------------------------------------------------------------
	--add the game logo
	-------------------------------------------------------------------------------------------------------------
	--logo = display.newImageRect( myGlobalData.imagePath.."cutTheCookie_logo.png", 286,172 )
	logo = display.newSprite( myGlobalData.imageSheet, myGlobalData.animationSequenceData )
	logo:setSequence( "cutTheCookie_logo" )
	logo:play()
	logo.x = myGlobalData._w/2; logo.y = 200; logo.alpha = 1.0
	screenGroup:insert( logo )

	------------------------------------------------------------------------------------------------------------------------------------
	-- add your [About your game] info
	------------------------------------------------------------------------------------------------------------------------------------
	local infoText = display.newText("Add your game info and credits here. Cut the Cookie Template, developed by DeepBlueApps.com",0,0,200,200, "MarkerFelt-Wide", 14)
	--infoText:setReferencePoint(display.CenterReferencePoint)
	infoText:setFillColor(1,1,1)
	myRectangle.anchorX = 0.5		-- Graphics 2.0 Anchoring method
	myRectangle.anchorY = 0.5		-- Graphics 2.0 Anchoring method
	infoText.x = myGlobalData._w/2
	infoText.y = 400
	infoText.alpha = 1.0
	screenGroup:insert(infoText)

	-------------------------------------------------------------------------------------------------------------
	-- Button CONTINUE
	-------------------------------------------------------------------------------------------------------------
	local buttonBase = widget.newButton{
	sheet = myGlobalData.imageSheet, defaultFrame = 5, overFrame = 6, onRelease = buttonDone, }
	--buttonBase:setReferencePoint(display.CenterReferencePoint)
	buttonBase.x = myGlobalData._w/2; buttonBase.y = 400
	screenGroup:insert( buttonBase )

	local buttonText = display.newSprite( myGlobalData.imageSheet, myGlobalData.animationSequenceData )
	buttonText:setSequence( "textContinue" )
	buttonText.x = myGlobalData._w/2; buttonText.y = 400; buttonText:play()
	screenGroup:insert(buttonText)
	-------------------------------------------------------------------------------------------------------------

	---------------------------------------------------------------------------------------------------------
	--Play got a cup of tea!
	---------------------------------------------------------------------------------------------------------
	audio.play(sfx_CupOfTea)

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


---------------------------------------------------------------------------------
-- function: resume play button
---------------------------------------------------------------------------------
function buttonDone()
	---------------------------------------------------------------------------------------------------------
	--Play the power aid!
	---------------------------------------------------------------------------------------------------------
	audio.play(sfx_PowerAid)

	-- Hide this overlay
	composer.hideOverlay("slideDown", 300)
	return true
end


-- Listener setup
scene:addEventListener( "create", scene )
scene:addEventListener( "show", scene )
scene:addEventListener( "hide", scene )
scene:addEventListener( "destroy", scene )

---------------------------------------------------------------------------------

return scene




