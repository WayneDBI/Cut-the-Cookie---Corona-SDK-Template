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
-- screenResetLevel.lua
------------------------------------------------------------------------------------------------------------------------------------

---------------------------------------------------------------
-- Require all of the external modules for this level
---------------------------------------------------------------
local composer 				= require( "composer" )
local scene 				= composer.newScene()
local myGlobalData 		= require( "globalData" )
local dataReset			= require( "actor_ResetVariables" )


---------------------------------------------------------------
-- level select button function
---------------------------------------------------------------
function restartLevel()
	
	-- Reset the current level variables
	dataReset.VariableReset()
	
	--isReset="false"
	
	local buildPathToLevel = myGlobalData.worldPath.."World"..myGlobalData.worldSelected.."_Levels.level"..myGlobalData.myLevel
	composer.gotoScene( buildPathToLevel )	--This is our main menu

	return true
end




-- "scene:create()"
function scene:create( event )

   -- Initialize the scene here.
   -- Example: add display objects to "sceneGroup", add touch listeners, etc.
   	local screenGroup = self.view
	
	---------------------------------------------------------------
	-- simply create a WHITE square.
	---------------------------------------------------------------
	local myRectangle = display.newRect(0, 0, myGlobalData._w, myGlobalData._h)
	myRectangle.anchorX = 0.0		-- Graphics 2.0 Anchoring method
	myRectangle.anchorY = 0.0		-- Graphics 2.0 Anchoring method
	screenGroup:insert(myRectangle)
	
	audio.play(sfx_Select)

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

      	myGlobalData.levelPaused = false
		myGlobalData.levelFailed = false
		
		local buildPathToLevel = myGlobalData.worldPath.."World"..myGlobalData.worldSelected.."_Levels.level"..myGlobalData.myLevel
		local buildLevelName = "level"..myGlobalData.myLevel

		print("***** Removing Scene: "..buildPathToLevel)
		print("***** Removing Scene(Name): "..buildLevelName)

		composer.removeScene( buildPathToLevel )
		composer.removeScene( buildLevelName )

		--Short delay before we go back to the scene
		timer.performWithDelay(100, restartLevel )

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