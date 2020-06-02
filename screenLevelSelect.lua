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
-- screenLevelSelect.lua
------------------------------------------------------------------------------------------------------------------------------------

---------------------------------------------------------------
-- Require all of the external modules for this level
---------------------------------------------------------------
local ui 				= require("ui")
local widget 			= require("widget")
local myGlobalData 		= require("globalData")
local loadsave 			= require("loadsave")
require "sprite"
local composer 				= require( "composer" )
local scene 				= composer.newScene()

---------------------------------------------------------------
-- Define our SCENE variables and sprite object variables
---------------------------------------------------------------
local screenW, screenH, halfW = display.contentWidth, display.contentHeight, display.contentWidth*0.5
local previousMusicVolume, previousSFXVolume

---------------------------------------------------------------
-- Get the LEVEL and WORLD stars/unlocked data
---------------------------------------------------------------
local statsSetup 		= {}	-- This is our WORLD and LEVEL data table. We'll store how many stars were collected etc in here..
statsSetup 				= saveDataTable.levelStats

local menuArray 		= {}
local menuStarsArray 	= {}
local menuTextArray 	= {}

previousMusicVolume = myGlobalData.volumeMusic
previousSFXVolume = myGlobalData.volumeSFX

---------------------------------------------------------------
-- setup various button functions
---------------------------------------------------------------
function buttonBack()
	audio.play(sfx_Select)
	composer.gotoScene( "screenWorldSelect", "crossFade", 200  )
	return true
end



---------------------------------------------------------------
-- function triggered for each of the level panels.
---------------------------------------------------------------
function selectALevel( event )
	---------------------------------------------------------------------------------------------------------
	--Play the cookie smashed sfx
	---------------------------------------------------------------------------------------------------------
	audio.play(sfx_LetsGo)

	local levelNumber 	= event.target.id
	local getStarCount = statsSetup[myGlobalData.worldSelected][levelNumber][1]
	
	if (getStarCount<4) then
	
		myGlobalData.myLevel = levelNumber
		myGlobalData.endGame = false
		
		print("Level: ["..levelNumber.."] is UN-LOCKED: Stars Collected: ["..getStarCount.."] Going to level: ["..levelNumber.."]")
		
		local buildPathToLevel = myGlobalData.worldPath.."World"..myGlobalData.worldSelected.."_Levels.level"..levelNumber
		print(buildPathToLevel)
		composer.gotoScene( buildPathToLevel )	--This is our main menu
		
		print(myGlobalData.endGame)

	else
		print("Level: ["..levelNumber.."] is LOCKED: No access")
	end
	
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
	
	myGlobalData.endGame = true
	-------------------------------------------------------------------------------------------------------------
	--Set up the SIZE for the level (Defaults to max width/Height) of the users device....
	-------------------------------------------------------------------------------------------------------------
	myGlobalData.levelSizeW = myGlobalData._w
	myGlobalData.levelSizeH = myGlobalData._h

	-------------------------------------------------------------------------------------------------------------
	--Draw the background image
	-------------------------------------------------------------------------------------------------------------
	local colouredSquare = display.newRect(0,0,myGlobalData._w,myGlobalData._h)
	colouredSquare:setFillColor(0.39,0.22,0.65)--purple
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
	--Draw the logo to fill the iPhone 5 screen only
	-------------------------------------------------------------------------------------------------------------
	if ( myGlobalData.iPhone5 == true ) then
		local logo = display.newSprite( myGlobalData.imageSheet, myGlobalData.animationSequenceData )
		logo:setSequence( "cutTheCookie_logo" )
		logo:play()
		logo.x = myGlobalData._w/2; logo.y = 480; logo.alpha = 1.0; logo.xScale = 0.8; logo.yScale = 0.8
		screenGroup:insert( logo )
	end


	-------------------------------------------------------------------------------------------------------------
	--Temp Debug grid overlay
	-------------------------------------------------------------------------------------------------------------
	if (myGlobalData.showDebugGrid == true)then
		local bgImageVisual = display.newImageRect( myGlobalData.imagePath.."iPhone_grid_PortraitINV.png", 320,480 )
		--bgImageVisual:setReferencePoint( display.TopLeftReferencePoint )
		bgImageVisual.anchorX = 0.5		-- Graphics 2.0 Anchoring method
		bgImageVisual.anchorY = 0.5		-- Graphics 2.0 Anchoring method
		bgImageVisual.x = 0--myGlobalData._w/2
		bgImageVisual.y = 0--myGlobalData._h/2
		screenGroup:insert( bgImageVisual )
		bgImageVisual.alpha = 0.35
	end
	
	
	---------------------------------------------------------------
	-- Set up the LEVEL Buttons.
	---------------------------------------------------------------
	local myLevelButtonsGroup = display.newGroup()
		
	local nextLine = 1
	local itemsPerRow = 5
	local lineCount = math.abs(myGlobalData.maxLevels/5)
	local stepX = 60
	local stepY = 75
	local iPadoffset=0
	
	if (myGlobalData.iPad == true) then
		iPadoffset=24
	else
		iPadoffset=0
	end
	
	local startX = 37 + iPadoffset
	local startY = 70
	local oldX = 0
	local oldY = 0
	local getIndex = 1
	local starsCollectedOnLevel = 0
	local maxStarsAvailableOnWorld = myGlobalData.maxLevels * 3 -- 3 Stars per Level, 25 levels per world.
	
	oldX = startX
	oldY = startY
	
	---------------------------------------------------------------
	-- loop over how many buttons (panels) to create
	---------------------------------------------------------------
	for y = 1, lineCount do
		for x=1, itemsPerRow do
			
			local getStarCount = statsSetup[myGlobalData.worldSelected][getIndex][1]
			--Draw the BOX
			local img = display.newSprite( myGlobalData.imageSheet, myGlobalData.animationSequenceData )
			if (getStarCount < 4) then
				img:setSequence( "levelUnLocked" )
				starsCollectedOnLevel = starsCollectedOnLevel + getStarCount
			else
				img:setSequence( "levelLocked" )
			end
			
			---------------------------------------------------------------
			-- add meta events to each unique button/level selector
			---------------------------------------------------------------
			img:play()
			img.x = oldX
			img.y = oldY
			img.id = getIndex
			img:addEventListener( "tap", selectALevel)
			menuArray[getIndex] = img
			myLevelButtonsGroup:insert(img)
			
			---------------------------------------------------------------
			-- add the correct STAR counter next to each level panel
			---------------------------------------------------------------
			if (getStarCount < 4) then
				--Draw the Stars for EACH level
				local imgStars = display.newSprite( myGlobalData.imageSheet, myGlobalData.animationSequenceData )
				imgStars:setSequence( "levelStars"..getStarCount )
				imgStars:play()
				imgStars.x = oldX+8
				imgStars.y = oldY+20
				imgStars.id = getIndex
				menuStarsArray[getIndex] = imgStars
				myLevelButtonsGroup:insert(imgStars)
			
				--Draw the LEVEL Number on each of the LIVE level panels
				local levelNumberText = display.newText(getIndex,0,0, "MarkerFelt-Wide", 15)
				--levelNumberText:setReferencePoint(display.CenterReferencePoint)
				levelNumberText:setTextColor(255,255,255)
				levelNumberText.x = oldX
				levelNumberText.y = oldY-3
				levelNumberText.id = getIndex
				menuTextArray[getIndex] = levelNumberText
				myLevelButtonsGroup:insert(levelNumberText)
			end

			
			oldX = oldX + stepX
			getIndex = getIndex + 1
		end
		
		nextLine = nextLine + 1
		oldX = startX
		oldY = oldY + stepY
	end
	
	---------------------------------------------------------------
	-- Add the levels button group to the main scene group
	---------------------------------------------------------------
	screenGroup:insert( myLevelButtonsGroup )
	
	---------------------------------------------------------------
	-- Show the TOTAL COMBINED stars collected count for this world
	---------------------------------------------------------------
	local textDisplayInfo = starsCollectedOnLevel.."/"..maxStarsAvailableOnWorld.." Stars Collected"
	local totalStarsInfo = display.newText(textDisplayInfo,0,0, "MarkerFelt-Thin", 18)
	--totalStarsInfo:setReferencePoint(display.CenterReferencePoint)
	totalStarsInfo:setTextColor(255,255,255)
	totalStarsInfo.x = myGlobalData._w/2
	totalStarsInfo.y = 20
	screenGroup:insert(totalStarsInfo)

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

      	myGlobalData.levelFailed 	= true
		myGlobalData.gameScore 		= 0
		myGlobalData.levelReset 	= true		
		myGlobalData.starsCollected = 0
		
		myGlobalData.endGame = true
		myGlobalData.levelPaused = false
		
		local previousScene = composer.getSceneName( "previous" )
		print(previousScene)
		
	if (previousScene ~= nil ) then
		local previousInfo = "Previous Scene: "..previousScene
		print(previousInfo)

		composer.removeScene( previousScene )
	end
	
	for i = 1,myGlobalData.maxWorlds do
		for j = 1,myGlobalData.maxLevels do
			local buildPathToLevel = myGlobalData.worldPath.."World"..i.."_Levels.level"..j
			local buildLevelName = "level"..j
			composer.removeScene( buildPathToLevel )
			composer.removeScene( buildLevelName )
		end
	end

	composer.removeHidden()
		
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
		
	composer.removeScene( "screenResetLevel" )
	composer.removeScene( "screenStart" )
	composer.removeScene( "screenOptions" )
	composer.removeScene( "screenWorldSelect" )
	composer.removeScene( "screenLevelComplete" )
	composer.removeScene( "screenGameComplete" )
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