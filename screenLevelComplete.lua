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
-- screenLevelComplete.lua
------------------------------------------------------------------------------------------------------------------------------------

---------------------------------------------------------------------------------
-- import any external modules
---------------------------------------------------------------------------------
local composer          = require( "composer" )
local scene             = composer.newScene()
local myGlobalData      = require( "globalData" )
local ui                = require("ui")
local widget            = require "widget"
local dataReset         = require("actor_ResetVariables")

local star1 = 0
local star2 = 0
local star3 = 0

---------------------------------------------------------------
-- Get the LEVEL and WORLD stars/unlocked data
---------------------------------------------------------------
local statsSetup = {}	-- This is our WORLD and LEVEL data table. We'll store how many stars were collected etc in here..
statsSetup       = saveDataTable.levelStats


---------------------------------------------------------------
-- function to replay the last level
---------------------------------------------------------------
function buttonReplay()
		-- Reset the current level variables
		myGlobalData.levelFailed 	= true
		myGlobalData.gameScore 		= 0
		myGlobalData.levelReset 	= true		
		myGlobalData.starsCollected = 0

		dataReset.VariableReset()
		myGlobalData.endGame = false
				
		local buildPathToLevel = myGlobalData.worldPath.."World"..myGlobalData.worldSelected.."_Levels.level"..myGlobalData.myLevel
		
		local function restartLevel()
			composer.gotoScene( buildPathToLevel )
		end
	
		--Short delay before we go back to the scene
		local delayAction = timer.performWithDelay(20, restartLevel )

	return true
end


---------------------------------------------------------------
-- function to play the NEXT level
---------------------------------------------------------------
function buttonNext()
		-- Reset the current level variables
		--
		myGlobalData.levelFailed 	= true
		myGlobalData.gameScore 		= 0
		myGlobalData.levelReset 	= true		
		myGlobalData.starsCollected = 0
		--
		dataReset.VariableReset()
		myGlobalData.endGame = false
		
		--Increment the users level ref
		myGlobalData.myLevel = myGlobalData.myLevel + 1
		myGlobalData.level = myGlobalData.level + 1
		
		-- local buildPathToLevel = myGlobalData.worldPath.."World"..myGlobalData.worldSelected.."_Levels.level"..myGlobalData.myLevel

		-- print(buildPathToLevel)

		local buildPathToLevel = myGlobalData.worldPath.."World"..myGlobalData.worldSelected.."_Levels.level"..myGlobalData.myLevel
		print(buildPathToLevel)
		composer.gotoScene( buildPathToLevel )	--This is our main menu
	
	return true
end

---------------------------------------------------------------
-- function to go back to menu screen
---------------------------------------------------------------
function buttonBackToMenu()
	
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


---------------------------------------------------------------
-- function to restart last level
---------------------------------------------------------------
function restartLevel()
	local buildPathToLevel = myGlobalData.worldPath.."World"..myGlobalData.worldSelected.."_Levels.level"..myGlobalData.myLevel
	composer.gotoScene( buildPathToLevel )
	return true
end


function scene:create( event )
   -- Initialize the scene here.
   -- Example: add display objects to "sceneGroup", add touch listeners, etc.
   	local screenGroup = self.view
	
	---------------------------------------------------------------
	-- Set the game mode to PAUSE
	---------------------------------------------------------------
	myGlobalData.levelPaused = true

	-------------------------------------------------------------------------------------------------------------
	--Draw the background image. OR a coloured square with a BW image over the top
	-------------------------------------------------------------------------------------------------------------
	local colouredSquare = display.newRect(0,0,myGlobalData._w,myGlobalData._h)
	colouredSquare:setFillColor(0.05,0.65,0.25)--green
	--colouredSquare:setFillColor(0.39,0.22,0.65)--purple
	--colouredSquare:setFillColor(0.15,0.26,0.62)--blue
	--colouredSquare:setFillColor(0.83,0.7,0.21)--Drk Yellow

	colouredSquare.anchorX = 0.0		-- Graphics 2.0 Anchoring method
	colouredSquare.anchorY = 0.0		-- Graphics 2.0 Anchoring method
	screenGroup:insert( colouredSquare )
	
	local bgImageVisual = display.newImageRect( myGlobalData.imagePath.."Background_Overlay.png", 384,569 )
	bgImageVisual.anchorX = 0.5		-- Graphics 2.0 Anchoring method
	bgImageVisual.anchorY = 0.5		-- Graphics 2.0 Anchoring method
	bgImageVisual.x = myGlobalData._w/2
	bgImageVisual.y = myGlobalData._h/2
	screenGroup:insert( bgImageVisual )
	bgImageVisual.alpha = 1.0

	-------------------------------------------------------------------------------------------------------------
	-- Button REPLAY
	-------------------------------------------------------------------------------------------------------------
	local buttonBase = widget.newButton{
	sheet = myGlobalData.imageSheet, defaultFrame = 7, overFrame = 8, onRelease = buttonReplay, }
	--buttonBase:setReferencePoint(display.CenterReferencePoint)
	buttonBase.x = 100; buttonBase.y = 240
	screenGroup:insert( buttonBase )

	local buttonText = display.newSprite( myGlobalData.imageSheet, myGlobalData.animationSequenceData )
	buttonText:setSequence( "textReplay" )
	buttonText.x = buttonBase.x; buttonText.y = buttonBase.y; buttonText:play()
	screenGroup:insert(buttonText)
	-------------------------------------------------------------------------------------------------------------

	-------------------------------------------------------------------------------------------------------------
	-- Button NEXT Level
	-------------------------------------------------------------------------------------------------------------
	local buttonBase = widget.newButton{
	sheet = myGlobalData.imageSheet, defaultFrame = 7, overFrame = 8, onRelease = buttonNext, }
	--buttonBase:setReferencePoint(display.CenterReferencePoint)
	buttonBase.x = 240; buttonBase.y = 240
	screenGroup:insert( buttonBase )

	local buttonText = display.newSprite( myGlobalData.imageSheet, myGlobalData.animationSequenceData )
	buttonText:setSequence( "textNext" )
	buttonText.x = buttonBase.x; buttonText.y = buttonBase.y; buttonText:play()
	screenGroup:insert(buttonText)
	-------------------------------------------------------------------------------------------------------------

	-------------------------------------------------------------------------------------------------------------
	-- Back to Main Menu Button
	-------------------------------------------------------------------------------------------------------------
	local buttonBase = widget.newButton{
	sheet = myGlobalData.imageSheet, defaultFrame = 5, overFrame = 6, onRelease = buttonBackToMenu, }
	--buttonBase:setReferencePoint(display.CenterReferencePoint)
	buttonBase.x = 160; buttonBase.y = 300
	screenGroup:insert( buttonBase )

	local buttonText = display.newSprite( myGlobalData.imageSheet, myGlobalData.animationSequenceData )
	buttonText:setSequence( "textMainMenu" )
	buttonText.x = buttonBase.x; buttonText.y = buttonBase.y; buttonText:play()
	screenGroup:insert(buttonText)
	-------------------------------------------------------------------------------------------------------------

	-------------------------------------------------------------------------------------------------------------
	-- Create the 3 LARGE STAR RESULTS
	-------------------------------------------------------------------------------------------------------------
	--local getStarCount = statsSetup[myGlobalData.worldSelected][myGlobalData.myLevel][1]
	local getStarCount = myGlobalData.starsCollected
	local bigStar = display.newSprite( myGlobalData.imageSheet, myGlobalData.animationSequenceData )
	
	if (getStarCount>0) then
		bigStar:setSequence( "starBigOn" )
	else
		bigStar:setSequence( "starBigOff" )
	end
	bigStar.x = 100; bigStar.y = 175; bigStar:play()
	screenGroup:insert(bigStar)
	-------------------------------------------------------------------------------------------------------------
	local bigStar = display.newSprite( myGlobalData.imageSheet, myGlobalData.animationSequenceData )
	if (getStarCount>1) then
		bigStar:setSequence( "starBigOn" )
	else
		bigStar:setSequence( "starBigOff" )
	end
	bigStar.x = 160; bigStar.y = 175; bigStar:play()
	screenGroup:insert(bigStar)
	-------------------------------------------------------------------------------------------------------------
	local bigStar = display.newSprite( myGlobalData.imageSheet, myGlobalData.animationSequenceData )
	if (getStarCount==3) then
		bigStar:setSequence( "starBigOn" )
	else
		bigStar:setSequence( "starBigOff" )
	end
	bigStar.x = 220; bigStar.y = 175; bigStar:play()
	screenGroup:insert(bigStar)
	-------------------------------------------------------------------------------------------------------------

	---------------------------------------------------------------------------------------------------------
	--Play audio sound fx! based on the score...
	---------------------------------------------------------------------------------------------------------
	if (getStarCount==0) then
		audio.play(sfx_NotBad)
	elseif (getStarCount==1) then
		audio.play(sfx_Average)
	elseif (getStarCount==2) then
		audio.play(sfx_Good)
	elseif (getStarCount==3) then
		audio.play(sfx_Perfect)
	end

	-------------------------------------------------------------------------------------------------------------
	-- Create the INFO TEXT Results
	-------------------------------------------------------------------------------------------------------------
	local infoText = display.newSprite( myGlobalData.imageSheet, myGlobalData.animationSequenceData )
	infoText:setSequence( "textScoreInfo"..getStarCount )
	infoText.x = 160; infoText.y = 110; infoText:play()
	screenGroup:insert(infoText)

end


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

	--CLEAR ALL LEVELS, FROM ALL WORLDDS !!!!
	for j = 1,myGlobalData.maxWorlds do
		for i = 1,myGlobalData.maxLevels do
			local buildPathToLevel = myGlobalData.worldPath.."World"..j.."_Levels.level"..i
			local buildLevelName = "level"..myGlobalData.myLevel
			composer.removeScene( buildPathToLevel )
			composer.removeScene( buildLevelName )
		end
	end

	composer.removeScene( "screenGamePause" )
	composer.removeScene( "screenWorldSelect" )
	composer.removeScene( "screenResetLevel" )
	composer.removeScene( "screenStart" )
	composer.removeScene( "screenOptions" )
	composer.removeScene( "screenWorldSelect" )
	composer.removeScene( "screenLevelSelect" )
	
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
end




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