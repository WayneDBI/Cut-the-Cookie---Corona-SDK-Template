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

local ui 				= require("ui")
local widget 			= require "widget"
local storyboard		= require( "storyboard" )
local myGlobalData 		= require( "globalData" )
local dataReset			= require("actor_ResetVariables")

---------------------------------------------------------------------------------
-- BEGINNING OF IMPLEMENTATION
---------------------------------------------------------------------------------
local scene 			= storyboard.newScene()


-- Called when the scene's view does not exist:
function scene:createScene( event )
	local screenGroup = self.view
	
	-------------------------------------------------------------------------------------------------------------
	-- Darken background
	-------------------------------------------------------------------------------------------------------------
	local myRectangle = display.newRect(0, 0, myGlobalData._w, myGlobalData._h)
	myRectangle:setFillColor(0,0,0)
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
	local infoText = display.newText("GAME COMPLETED! Add your details here...",0,0,200,200, "MarkerFelt-Wide", 14)
	--infoText:setReferencePoint(display.CenterReferencePoint)
	infoText:setFillColor(1,1,1)
	infoText.x = myGlobalData._w/2
	infoText.y = 400
	infoText.alpha = 1.0
	screenGroup:insert(infoText)

	-------------------------------------------------------------------------------------------------------------
	-- Button CONTINUE
	-------------------------------------------------------------------------------------------------------------
	local buttonBase = widget.newButton{
	sheet = myGlobalData.imageSheet, defaultFrame = 5, overFrame = 6, onRelease = buttonBackToMenu, }
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


---------------------------------------------------------------
-- function to go back to menu screen
---------------------------------------------------------------
function buttonBackToMenu()
	
		myGlobalData.endGame = true
		
		local function performMyAction()
		print("back to start")
			storyboard.gotoScene( "screenStart", "crossFade", 100  )
		end
	
		--Short delay before we go back to the scene
		local delayAction = timer.performWithDelay(20, performMyAction )
		--delayAction.resetData = true

	return true
end


-- Called immediately after scene has moved onscreen:
-- Called immediately after scene has moved onscreen:
function scene:enterScene( event )

	myGlobalData.endGame = true
	
	--CLEAR ALL LEVELS, FROM ALL WORLDDS !!!!
	for j = 1,myGlobalData.maxWorlds do
		for i = 1,myGlobalData.maxLevels do
			local buildPathToLevel = myGlobalData.worldPath.."World"..j.."_Levels.level"..i
			local buildLevelName = "level"..myGlobalData.myLevel
			--print("Removing Scene: "..buildPathToLevel)
			--print("Removing Scene(Name): "..buildLevelName)
			storyboard.purgeScene( buildPathToLevel )
			storyboard.removeScene( buildPathToLevel )

			storyboard.purgeScene( buildLevelName )
			storyboard.removeScene( buildLevelName )
		end
	end



	storyboard.purgeScene( "screenGamePause" )
	storyboard.removeScene( "screenGamePause" )
	storyboard.purgeScene( "screenResetLevel" )
	storyboard.removeScene( "screenResetLevel" )
	storyboard.purgeScene( "screenStart" )
	storyboard.removeScene( "screenStart" )
	storyboard.purgeScene( "screenOptions" )
	storyboard.removeScene( "screenOptions" )

	storyboard.purgeScene( "screenWorldSelect" )
	storyboard.removeScene( "screenWorldSelect" )
	storyboard.purgeScene( "screenLevelSelect" )
	storyboard.removeScene( "screenLevelSelect" )
	
	--storyboard.purgeScene( "screenLevelComplete" )
	--storyboard.removeScene( "screenLevelComplete" )

	
	--Remove any of the GAME actor modules from memory too.
	package.loaded["actor_AreaBoundry"] = nil	
	package.loaded["actor_Bubble"] = nil	
	package.loaded["actor_Hero"] = nil	
	package.loaded["actor_LevelBackground"] = nil	
	package.loaded["actor_Rope"] = nil	
	package.loaded["actor_RopeAuto"] = nil	
	package.loaded["actor_SlashEffect"] = nil	
	package.loaded["actor_Spikes"] = nil	
	package.loaded["actor_Star"] = nil	
	package.loaded["actor_Cookie"] = nil	

end

-- Called when scene is about to move offscreen:
function scene:exitScene( event )
	

end


-- Called prior to the removal of scene's "view" (display group)
function scene:destroyScene( event )
	
end

---------------------------------------------------------------------------------
-- END OF YOUR IMPLEMENTATION
---------------------------------------------------------------------------------

-- "createScene" event is dispatched if scene's view does not exist
scene:addEventListener( "createScene", scene )

-- "enterScene" event is dispatched whenever scene transition has finished
scene:addEventListener( "enterScene", scene )

-- "exitScene" event is dispatched before next scene's transition begins
scene:addEventListener( "exitScene", scene )

-- "destroyScene" event is dispatched before view is unloaded, which can be
-- automatically unloaded in low memory situations, or explicitly via a call to
-- storyboard.purgeScene() or storyboard.removeScene().
scene:addEventListener( "destroyScene", scene )

---------------------------------------------------------------------------------

return scene





