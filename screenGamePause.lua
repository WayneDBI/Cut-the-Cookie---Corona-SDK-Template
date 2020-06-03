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
-- screenGamePause.lua
------------------------------------------------------------------------------------------------------------------------------------

---------------------------------------------------------------------------------
-- import any external modules
---------------------------------------------------------------------------------
local composer 				= require( "composer" )
local scene 				= composer.newScene()
local myGlobalData 		= require( "globalData" )
local ui 				= require("ui")
local widget 			= require "widget"
local dataReset			= require("actor_ResetVariables")

---------------------------------------------------------------------------------
-- function: resume play button
---------------------------------------------------------------------------------
function buttonContinue()
	audio.play(sfx_Select)
	-- Hide this overlay, and continue playing
	myGlobalData.levelPaused = false
	composer.hideOverlay("slideDown", 300)
	return true
end


---------------------------------------------------------------------------------
-- function: Select a new level button
---------------------------------------------------------------------------------
function buttonLevelSelect()
	audio.play(sfx_Select)

	myGlobalData.endGame = true
	
	local function performMyAction()
	print("back to Level Select")
		composer.gotoScene( "screenLevelSelect", "crossFade", 100  )
	end

	--Short delay before we go back to the scene
	local delayAction = timer.performWithDelay(20, performMyAction )

	return true
end

---------------------------------------------------------------------------------
-- function: back to the main menu
---------------------------------------------------------------------------------
function buttonBackToMenu()
	audio.play(sfx_Select)

	myGlobalData.endGame = true
	
	local function performMyAction()
	print("back to start")
		composer.gotoScene( "screenStart", "crossFade", 100  )
	end

	--Short delay before we go back to the scene
	local delayAction = timer.performWithDelay(20, performMyAction )
	--delayAction.resetData = true

	return true
end


---------------------------------------------------------------------------------
-- function: restart the last level
---------------------------------------------------------------------------------
function restartLevel()
	local buildPathToLevel = myGlobalData.worldPath.."World"..myGlobalData.worldSelected.."_Levels.level"..myGlobalData.myLevel
	composer.gotoScene( buildPathToLevel )
	return true
end


-- "scene:create()"
function scene:create( event )

   -- Initialize the scene here.
   -- Example: add display objects to "sceneGroup", add touch listeners, etc.
   	local screenGroup = self.view
	
	---------------------------------------------------------------------------------
	-- Set the game mode to PAUSE
	---------------------------------------------------------------------------------
	myGlobalData.levelPaused = true

	-------------------------------------------------------------------------------------------------------------
	-- Darken background
	-------------------------------------------------------------------------------------------------------------
	local myRectangle = display.newRect(0, 0, myGlobalData._w, myGlobalData._h)
	myRectangle:setFillColor(0,0,0)
	myRectangle.alpha=0.7
	myRectangle.anchorX = 0.0		-- Graphics 2.0 Anchoring method
	myRectangle.anchorY = 0.0		-- Graphics 2.0 Anchoring method
	screenGroup:insert(myRectangle)
	-------------------------------------------------------------------------------------------------------------

	-------------------------------------------------------------------------------------------------------------
	-- Button CONTINUE
	-------------------------------------------------------------------------------------------------------------
	local buttonBase = widget.newButton{
	sheet = myGlobalData.imageSheet, defaultFrame = 5, overFrame = 6, onRelease = buttonContinue, }
	--buttonBase:setReferencePoint(display.CenterReferencePoint)
	buttonBase.x = myGlobalData._w/2; buttonBase.y = 200
	screenGroup:insert( buttonBase )

	local buttonText = display.newSprite( myGlobalData.imageSheet, myGlobalData.animationSequenceData )
	buttonText:setSequence( "textContinue" )
	buttonText.x = myGlobalData._w/2; buttonText.y = 200; buttonText:play()
	screenGroup:insert(buttonText)
	-------------------------------------------------------------------------------------------------------------

	-------------------------------------------------------------------------------------------------------------
	-- Button Level Select
	-------------------------------------------------------------------------------------------------------------
	local buttonBase = widget.newButton{
	sheet = myGlobalData.imageSheet, defaultFrame = 5, overFrame = 6, onRelease = buttonLevelSelect, }
	--buttonBase:setReferencePoint(display.CenterReferencePoint)
	buttonBase.x = myGlobalData._w/2; buttonBase.y = 260
	screenGroup:insert( buttonBase )

	local buttonText = display.newSprite( myGlobalData.imageSheet, myGlobalData.animationSequenceData )
	buttonText:setSequence( "textLevelSelect" )
	buttonText.x = myGlobalData._w/2; buttonText.y = 260; buttonText:play()
	screenGroup:insert(buttonText)
	-------------------------------------------------------------------------------------------------------------

	-------------------------------------------------------------------------------------------------------------
	-- Back to Main Menu Button
	-------------------------------------------------------------------------------------------------------------
	local buttonBase = widget.newButton{
	sheet = myGlobalData.imageSheet, defaultFrame = 5, overFrame = 6, onRelease = buttonBackToMenu, }
	--buttonBase:setReferencePoint(display.CenterReferencePoint)
	buttonBase.x = myGlobalData._w/2; buttonBase.y = 320
	screenGroup:insert( buttonBase )

	local buttonText = display.newSprite( myGlobalData.imageSheet, myGlobalData.animationSequenceData )
	buttonText:setSequence( "textMainMenu" )
	buttonText.x = myGlobalData._w/2; buttonText.y = 320; buttonText:play()
	screenGroup:insert(buttonText)
	-------------------------------------------------------------------------------------------------------------
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
-- END OF YOUR IMPLEMENTATION
---------------------------------------------------------------------------------

-- Listener setup
scene:addEventListener( "create", scene )
scene:addEventListener( "show", scene )
scene:addEventListener( "hide", scene )
scene:addEventListener( "destroy", scene )


---------------------------------------------------------------------------------

return scene





