------------------------------------------------------------------------------------------------------------------------------------
-- CUT THE COOKIE Corona SDK Template
------------------------------------------------------------------------------------------------------------------------------------
-- Developed by Deep Blue Apps.com [www.deepbueapps.com]
------------------------------------------------------------------------------------------------------------------------------------
-- Abstract: Get the cookie to the Chef hero. Along the way try and collect as many stars as possible.
-- Avoid any obstacles such as spikes. The Cookie is connect by a series of ropes on the
-- screen, which the user mush cut to get the cookie to the desired location.
------------------------------------------------------------------------------------------------------------------------------------
-- Release Version 1.1
-- Code developed for CORONA SDK STABLE RELEASE 2013.2076
-- 13th February 2014
------------------------------------------------------------------------------------------------------------------------------------
-- WORLD 1  : level20.lua
------------------------------------------------------------------------------------------------------------------------------------

------------------------------------------------------------------------------------------------------------------------------------
-- Require all of the external modules for this level
------------------------------------------------------------------------------------------------------------------------------------
system.activate( "multitouch" )

local ui 				= require("ui")
local widget 			= require "widget"
local myGlobalData 		= require("globalData")
local loadsave 			= require("loadsave")
local dataReset			= require("actor_ResetVariables")
local WorldAreaWalls	= require("actor_AreaBoundry")
local Hero				= require("actor_Hero")
local Cookie			= require("actor_Cookie")
local Bubble			= require("actor_Bubble")
local Star				= require("actor_Star")
local RopeAuto			= require("actor_RopeAuto")
local Rope				= require("actor_Rope")
local Spike				= require("actor_Spikes")
local levelBackdrop		= require("actor_LevelBackdrop")
--local SlashEffect		= require("actor_SlashEffect")
local composer 			= require( "composer" )
local scene 			= composer.newScene()
require "sprite"

------------------------------------------------------------------------------------------------------------------------------------
-- Define our SCENE variables and sprite object variables
------------------------------------------------------------------------------------------------------------------------------------
local bgCreate
local previousStarsCollected	= 0
local sceneHudGroup				= display.newGroup()
local levelCompleted			= false
local screenW 					= display.contentWidth
local screenH 					= display.contentHeight
local halfW 					= display.contentWidth*0.5

------------------------------------------------------------------------------------------------------------------------------------
-- Define the Slash Effect Variables
------------------------------------------------------------------------------------------------------------------------------------
local maxPoints 				= 2
local lineThickness 			= 8
local lineFadeTime 				= 300
local endPoints 				= {}
local slashSounds 				= {
			slash1 = audio.loadSound(myGlobalData.audioPath.."slash1.mp3"),
			slash2 = audio.loadSound(myGlobalData.audioPath.."slash2.mp3"),
			slash3 = audio.loadSound(myGlobalData.audioPath.."slash3.mp3") }
local slashSoundEnabled 		= true
local minTimeBetweenSlashes 	= 150
local minDistanceForSlashSound 	= 5
local numTouches 				= 0
local slashGroup 				= display.newGroup()


------------------------------------------------------------------------------------------------------------------------------------
-- Get the LEVEL and WORLD stars/unlocked data
------------------------------------------------------------------------------------------------------------------------------------
local statsSetup = {}	-- This is our WORLD and LEVEL data table. We'll store how many stars were collected etc in here..
statsSetup = saveDataTable.levelStats

--Store the previous score (collected stars) from the saved data
previousStarsCollected = statsSetup[myGlobalData.worldSelected][myGlobalData.myLevel][1]

------------------------------------------------------------------------------------------------------------------------------------
-- DEBUG INFO
------------------------------------------------------------------------------------------------------------------------------------
--print("WORLD: "..myGlobalData.worldSelected)
--print("LEVEL: "..myGlobalData.myLevel)
--print("PREVIOUS STARS COLLECTED: "..previousStarsCollected)

------------------------------------------------------------------------------------------------------------------------------------
-- Define our BASE SCENE variables and sprite object variables: All levels will need these
------------------------------------------------------------------------------------------------------------------------------------
local HeroTarget, Cookie1, Star1, Star2, Star3

------------------------------------------------------------------------------------------------------------------------------------
-- Setup the Physics World
------------------------------------------------------------------------------------------------------------------------------------
physics.start()
physics.setScale( 30 )
physics.setGravity( 0, 6 )
physics.setPositionIterations(40)
--physics.setDrawMode( "hybrid" ) --Enable to see the Physics world in action
physics.setContinuous( true )
------------------------------------------------------------------------------------------------------------------------------------

------------------------------------------------------------------------------------------------------------------------------------
-- Build the LEVEL/Scene.
------------------------------------------------------------------------------------------------------------------------------------
-- Called when the scene's view does not exist:
------------------------------------------------------------------------------------------------------------------------------------
function scene:create( event )

	local screenGroup = self.view
	myGlobalData.endGame = false
	
	------------------------------------------------------------------------------------------------------------------------------------
	--Set up the SIZE for the level (Defaults to max width/Height) of the users device: Insert the Walls
	------------------------------------------------------------------------------------------------------------------------------------
	myGlobalData.levelSizeW = myGlobalData._w;		myGlobalData.levelSizeH = myGlobalData._h
	
	------------------------------------------------------------------------------------------------------------------------------------
	-- Add the background to the level. This is an external module.
 	------------------------------------------------------------------------------------------------------------------------------------
	bgCreate 	 =  levelBackdrop.newBackdrop();	screenGroup:insert( bgCreate )
	
	------------------------------------------------------------------------------------------------------------------------------------
	-- Add the WALLS to the level. This is an external module.
 	------------------------------------------------------------------------------------------------------------------------------------
	worldWalls 	=   WorldAreaWalls.newBackdrop();	screenGroup:insert( worldWalls )
	
	-- *********************************************************************************************************************************
	-- *******   ALL LEVELS MUST HAVE a HERO, BISCUIT(Sweet/Cookie), STAR1, STAR2 AND STAR3  *******************************************
	-- *********************************************************************************************************************************
	-- Add all of the LEVEL data: ALL LEVELS NEED THE HERO, BISCUIT (Sweet), STAR1, STAR2 & STAR3
	-- *********************************************************************************************************************************
    HeroTarget	= Hero.newHero(   {  positionX=160,	positionY=420  }   )	-- Hero: Set X, Y position on the screen.
	Cookie1 	= Cookie.newCookie( 160,120,0,0 )							-- Add the Cookie: (X, Y, [Initial VelocityX, VelocityY])
    Star1 		= Star.newStar( 160,180 )									-- Add Star 1 to the scene
    Star2 		= Star.newStar( 160,260 )									-- Add Star 2 to the scene
    Star3 		= Star.newStar( 160,320 )									-- Add Star 3 to the scene
	-- *********************************************************************************************************************************
	-- *******   ADD YOUR LEVEL DATA BELOW, ROPES, BUBBLES, SPIKES ETC..  **************************************************************
	-- *********************************************************************************************************************************
	-- Add ROPES, AUTO-ROPES, SPIKES and BUBBLES as required
	-- *********************************************************************************************************************************
	local Rope1 = Rope.newRope( {extraLength=0,	nubX=160,	nubY=20,	targetX=Cookie1.x,	targetY=Cookie1.y,	body=Cookie1,	density=120} )

	------------------------------------------------------------------------------------------------------------------------------------
	--Other items you could have added.
 	------------------------------------------------------------------------------------------------------------------------------------
    --local Bubble1 	= Bubble.newBubble(200,340)
    --local ropeAuto1 	= RopeAuto.newRopeAuto( {extraLength=40,	nubX=100,	nubY=180,	body=Cookie1,	perimeter=40,	density=120} )
    --local Spike1 		= Spike.newSpike( {spikeType=1,	x=160,	y=280,	getAngle=0,		doRotate=true,	rotateSpeed=2}	) -- spikeType (1 to 4), x, y, getAngle, doRotate, rotateSpeed

	------------------------------------------------------------------------------------------------------------------------------------
	-- Insert all of the Custom Level Sprites into the SCREEN GROUP in the correct order!
	------------------------------------------------------------------------------------------------------------------------------------
	screenGroup:insert( Rope1 )

	-- *********************************************************************************************************************************


	------------------------------------------------------------------------------------------------------------------------------------
	-- Insert MAIN sprites into the Screen Group - ALL LEVELS will have these!
	------------------------------------------------------------------------------------------------------------------------------------
    screenGroup:insert( HeroTarget )
    screenGroup:insert( Cookie1 )
    screenGroup:insert( Star1 )
    screenGroup:insert( Star2 )
    screenGroup:insert( Star3 )

	------------------------------------------------------------------------------------------------------------------------------------
	-- HUD Setup, Stars, menus, buttons etc
	------------------------------------------------------------------------------------------------------------------------------------
	hudStar1 = display.newSprite( myGlobalData.imageSheet, myGlobalData.animationSequenceData )
	hudStar1:setSequence( "hudStarOff" ); hudStar1:play()
	hudStar1.x = 20; hudStar1.y = 20
	sceneHudGroup:insert(hudStar1)
	
	hudStar2 = display.newSprite( myGlobalData.imageSheet, myGlobalData.animationSequenceData )
	hudStar2:setSequence( "hudStarOff" ); hudStar2:play()
	hudStar2.x = 50; hudStar2.y = 20
	sceneHudGroup:insert(hudStar2)
	
	hudStar3 = display.newSprite( myGlobalData.imageSheet, myGlobalData.animationSequenceData )
	hudStar3:setSequence( "hudStarOff" ); hudStar3:play()
	hudStar3.x = 80; hudStar3.y = 20
	sceneHudGroup:insert(hudStar3)
	
	------------------------------------------------------------------------------------------------------------------------------------
	-- Button replay
	------------------------------------------------------------------------------------------------------------------------------------
	local buttonReplay = widget.newButton{
	--sheet = imageSheet, defaultFrame = 71, overFrame = 71,
	defaultFile = myGlobalData.imagePath.."buttonReplay.png", overFile=myGlobalData.imagePath.."buttonReplay.png",
	width = 29, height = 29,
	onRelease = replayLevel, }
	--buttonReplay:setReferencePoint(display.CenterReferencePoint)
	buttonReplay.x = (myGlobalData._w)-80; buttonReplay.y = 18
	buttonReplay.alpha=0.6
	sceneHudGroup:insert( buttonReplay )

	------------------------------------------------------------------------------------------------------------------------------------
	-- Button show menu
	------------------------------------------------------------------------------------------------------------------------------------
	local buttonShowMenu = widget.newButton{
	--sheet = imageSheet, defaultFrame = 71, overFrame = 71,
	defaultFile = myGlobalData.imagePath.."buttonGameMenuShow.png", overFile=myGlobalData.imagePath.."buttonGameMenuShow.png",
	width = 60, height = 30,
	onRelease = showMenu, }
	--buttonShowMenu:setReferencePoint(display.CenterReferencePoint)
	buttonShowMenu.x = (myGlobalData._w)-32; buttonShowMenu.y = 18
	buttonShowMenu.alpha=0.6
	sceneHudGroup:insert( buttonShowMenu )

	if ( myGlobalData.iPhone5 == true ) then
		local textBackdropPanel = display.newRect(0,0,160,44)
		textBackdropPanel:setFillColor(0,0,0)
		textBackdropPanel.x = 0
		textBackdropPanel.y = 538
		textBackdropPanel.alpha = 0.6
		sceneHudGroup:insert(textBackdropPanel)
	elseif ( myGlobalData.iPad == true ) then
		local textBackdropPanel = display.newRect(0,0,160,44)
		textBackdropPanel:setFillColor(0,0,0)
		textBackdropPanel.x = 0
		textBackdropPanel.y = 448
		textBackdropPanel.alpha = 0.6
		sceneHudGroup:insert(textBackdropPanel)
	end

	------------------------------------------------------------------------------------------------------------------------------------
	-- text level HEADER
	------------------------------------------------------------------------------------------------------------------------------------
	local levelText1 = display.newSprite( myGlobalData.imageSheet, myGlobalData.animationSequenceData )
	levelText1:setSequence( "textLevel" )
	--levelText1:setReferencePoint(display.CenterLeftReferencePoint)
	levelText1.anchorX = 0.0		-- Graphics 2.0 Anchoring method
	levelText1.anchorY = 0.5		-- Graphics 2.0 Anchoring method
	if ( myGlobalData.iPhone5 == true ) then
		levelText1.x = 12; levelText1.y = 530; levelText1:play()
	else
		levelText1.x = 12; levelText1.y = 440; levelText1:play()
	end
		levelText1.xScale=0.8; levelText1.yScale=0.8; levelText1.alpha=0.5; 
	sceneHudGroup:insert(levelText1)

	------------------------------------------------------------------------------------------------------------------------------------
	-- text level, show number: WORDL, LEVEL....
	------------------------------------------------------------------------------------------------------------------------------------
	local levelText2 = display.newText(myGlobalData.worldSelected.." - "..myGlobalData.myLevel,0,0, "MarkerFelt-Wide", 13)
	--levelText2:setReferencePoint(display.CenterReferencePoint)
	levelText2:setTextColor(255,255,255)
	levelText2.x = 40
	if ( myGlobalData.iPhone5 == true ) then
		levelText2.y = 548
	else
		levelText2.y = 458
	end
	levelText2.alpha = 0.6
	sceneHudGroup:insert(levelText2)

	------------------------------------------------------------------------------------------------------------------------------------
	-- Score and HighScore
	------------------------------------------------------------------------------------------------------------------------------------
	myScoreText = display.newText("Score: "..myGlobalData.starsCollected,0,0, "HelveticaNeue-CondensedBlack", 12)
	--myScoreText:setReferencePoint(display.CenterLeftReferencePoint):setReferencePoint(display.CenterLeftReferencePoint)
	myScoreText.anchorX = 0.0		-- Graphics 2.0 Anchoring method
	myScoreText.anchorY = 0.5		-- Graphics 2.0 Anchoring method
	myScoreText:setTextColor(255,255,255)
	myScoreText.x = 10
	myScoreText.y = 45
	myScoreText.alpha = 1
	sceneHudGroup:insert(myScoreText)
	
	------------------------------------------------------------------------------------------------------------------------------------
    -- Add the HUD Group to the main Game Group
	------------------------------------------------------------------------------------------------------------------------------------
	screenGroup:insert( sceneHudGroup )
	------------------------------------------------------------------------------------------------------------------------------------

	-------------------------------------------------------------------------------------------------------------
	--Temp Debug grid overlay.
	--Shown if the MAIN.lua showDebugGrid variable is set to true
	--Was used to help position display objects
	-------------------------------------------------------------------------------------------------------------
	if (myGlobalData.showDebugGrid == true)then
		local bgImageVisual = display.newImageRect( myGlobalData.imagePath.."iPhone_grid_Portrait.png", 320,480 )
		--local bgImageVisual = display.newImageRect( myGlobalData.imagePath.."iPhone_grid_PortraitINV.png", 320,480 )
		bgImageVisual:setReferencePoint( display.TopLeftReferencePoint )
		bgImageVisual.x = 0--myGlobalData._w/2
		bgImageVisual.y = 0--myGlobalData._h/2
		sceneHudGroup:insert( bgImageVisual )
		bgImageVisual.alpha = 0.35
	end


	-----------------------------------------------------------------
	--Reserve Channels 1, 2, 3 for Specific audio
	-----------------------------------------------------------------
	audio.reserveChannels( 3 )

	-----------------------------------------------------------------
	-- Stop the MENU screen music playing on channel 1
	-----------------------------------------------------------------
 	audio.stop(1)
 	
	-----------------------------------------------------------------
	-- Start the GAME Music on channel 2 - Looping
	-----------------------------------------------------------------
	audio.play(musicGame, {channel=2,loops = -1})


end -- Setting up the CREATE SCENE function

-- "scene:show()"
function scene:show( event )

   local sceneGroup = self.view
   local phase = event.phase

   if ( phase == "will" ) then

	--local buildPathToLevel = myGlobalData.worldPath.."World"..myGlobalData.worldSelected.."_Levels.level"..myGlobalData.myLevel
	--local buildLevelName = "level"..myGlobalData.myLevel
	  composer.removeScene( "screenLevelSelect" )
	  composer.removeScene( "screenLevelComplete" ) --remove overlay scene for replay the scene
	  composer.removeScene( "screenResetLevel" )

   
   elseif ( phase == "did" ) then
      -- Called when the scene is now on screen.
      -- Insert code here to make the scene come alive.
      -- Example: start timers, begin animation, play audio, etc.

      	--Remove ALL other levels and scenes EXCEPT the Current one!

   end
end

-- "scene:hide()"
function scene:hide( event )

   local sceneGroup = self.view
   local phase = event.phase

   if ( phase == "will" ) then
   
    Runtime:removeEventListener("enterFrame", updateScene)
    Runtime:removeEventListener("collision", onGlobalCollision)
    Runtime:removeEventListener("touch", drawSlashLine)
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
------------------------------------------------------------------------------------------------------------------------------------
-- Our global collision event is looking for the slashes on the ropes
------------------------------------------------------------------------------------------------------------------------------------
local function onGlobalCollision( event )
 
 	--Check for collisions (slashes) when objects touch
	if ( event.phase == "began") then
		
		--Check if the ROPE element being HIT is LIVE
		if ( event.object1.objectHit==false ) then
			
			--Check the 2 HITS are between a ROPE joint and the Slash Area
			if ( event.object1.objectType=="Rope" and  event.object2.objectType=="SlashArea") then
				
				--Set the Rope elements HIT variable to TRUE to stop it being fired multiple times
				event.object1.objectHit = true
				
				--Store a reference to the rope elements PARENT item
				local ropeParentRefernece = event.object1.parent
				
				--Remove the hit ROPE element (this will break the chain!)
				display.remove(event.object1)
				
				--Finally, call the function in the ROPE to remove ALL the rope links
				ropeParentRefernece:ropeClearAll()
			end
		end
	end

end


------------------------------------------------------------------------------------------------------------------------------------
-- update the scene
-- Here we'll check for various events to keep the game running correctly.
------------------------------------------------------------------------------------------------------------------------------------
local function updateScene()
	
	--If any of our Actors trigger this variable - we'll reset the current scene!
	if (myGlobalData.levelFailed==true) then
		replayLevel()
	end

	if (myGlobalData.endGame==true) then
		Runtime:removeEventListener("enterFrame", updateScene)
    	Runtime:removeEventListener("collision", onGlobalCollision)
    	Runtime:removeEventListener("touch", drawSlashLine)
	end
	
	--------------------------------------------------------------------------------------------------
	-- Check to see if we have reached the goal!
	if (myGlobalData.sweetInGoal == true and myGlobalData.levelCompleted == false) then
		myGlobalData.levelCompleted = true
    	Runtime:removeEventListener("touch", drawSlashLine)
		--save the STARS score if greater than previous attempt
		if( myGlobalData.starsCollected > previousStarsCollected) then
			print("SAVING LEVEL DATA: "..myGlobalData.myLevel)
			-- Save the NEW star count to the CORRECT table location!
			statsSetup[myGlobalData.worldSelected][myGlobalData.myLevel] = {myGlobalData.starsCollected}
		end
	
		------------------------------------------------------------------------------------------
		-- Set the NEXT LEVEL to PLAYABLE - But only if the user hasn't scored on that level yet!
		------------------------------------------------------------------------------------------
		if (myGlobalData.myLevel < myGlobalData.maxLevels) then
			myGlobalData.allLevelsWon	= false
			if ( myGlobalData.worldSelected < myGlobalData.maxWorlds ) then
				local nextLevelStars = statsSetup[myGlobalData.worldSelected][myGlobalData.myLevel+1][1]
				if (nextLevelStars == 4) then
					statsSetup[myGlobalData.worldSelected][myGlobalData.myLevel+1] = {0}
				end
			end
		end

		------------------------------------------------------------------------------------------
		-- Check to see if the user has COMPLETED all the levels in the world...
		-- If so.... Unlock the 1st Level of the NEXT WORLD - but only if we haven't COMPLETED the game.
		------------------------------------------------------------------------------------------
		if ( myGlobalData.myLevel == myGlobalData.maxLevels ) then
			if ( myGlobalData.worldSelected < myGlobalData.maxWorlds ) then
				myGlobalData.allLevelsWon	= false
				------------------------------------------------------------------------------------------
				-- Set the NEXT WORLD Level 1 to PLAYABLE
				------------------------------------------------------------------------------------------
				myGlobalData.worldSelected	= myGlobalData.worldSelected + 1 -- increment the WORLD counter
				myGlobalData.myLevel 		= 0 -- reset the LEVEL variables
				myGlobalData.level 			= 0 -- reset the LEVEL variables
				print("****************************************")
				print("UNLOCKING NEXT WORLD ["..(myGlobalData.worldSelected).."]")
				print("****************************************")
				local nextWorldLevel1StarCount = statsSetup[myGlobalData.worldSelected][1][1]
				if (nextWorldLevel1StarCount == 4) then
					statsSetup[myGlobalData.worldSelected][1] = {0}
				end
			end
		end

		------------------------------------------------------------------------------------------
		--Has the user completed EVERY LEVEL of EVERY WORLD?
		------------------------------------------------------------------------------------------
		if ( myGlobalData.myLevel == myGlobalData.maxLevels ) then
			if ( myGlobalData.worldSelected == myGlobalData.maxWorlds ) then
				------------------------------------------------------------------------------------------
				-- user has completed every LEVEL of EVERY world.. This will trigger a
				-- different screen, than the levelCompleted screens..
				------------------------------------------------------------------------------------------
				myGlobalData.allLevelsWon	= true
			end
		end

		------------------------------------------------------------------------------------------
		-- Save the revised Level data back to our JSON file on the device
		------------------------------------------------------------------------------------------
		saveDataTable.levelStats 		= statsSetup
		saveDataTable.gameCompleted 	= myGlobalData.allLevelsWon
		loadsave.saveTable(saveDataTable, "dbi_ctr_template_data.json")
		------------------------------------------------------------------------------------------

		local function endTheLevel()
			composer.gotoScene( "screenLevelComplete", "crossFade", 500  )
		end

		local function endTheWholeGame()
			composer.gotoScene( "screenGameComplete", "crossFade", 500  )
		end

		------------------------------------------------------------------------------------------
		-- Goto the correct next screen..
		------------------------------------------------------------------------------------------
		if ( myGlobalData.allLevelsWon == true ) then
			local delayAction = timer.performWithDelay(1600, endTheWholeGame )
		else
			local delayAction = timer.performWithDelay(1600, endTheLevel )
		end
		
	end --End containing If statement

end --End Function
----------------------------------------------------------------------------------------


------------------------------------------------------------------------------------------------------------------------------------
-- replay/reset the current level
------------------------------------------------------------------------------------------------------------------------------------
function replayLevel()

    Runtime:removeEventListener("enterFrame", updateScene)
    Runtime:removeEventListener("collision", onGlobalCollision)
    Runtime:removeEventListener("touch", drawSlashLine)
	
		myGlobalData.levelFailed 	= true
		myGlobalData.gameScore 		= 0
		myGlobalData.levelReset 	= true		
		myGlobalData.starsCollected = 0

		local function restartLevel()
			composer.gotoScene( "screenResetLevel", "crossFade", 100  )
		end
	
		--Short delay before we go back to the scene
		local delayAction = timer.performWithDelay(20, restartLevel )
		--delayAction.resetData = true
				
	return true
end
----------------------------------------------------------------------------------------

------------------------------------------------------------------------------------------------------------------------------------
-- show the menu
------------------------------------------------------------------------------------------------------------------------------------
function showMenu()
	audio.play(sfx_Select)

	myGlobalData.levelPaused = true
	physics.pause()
	
	Hero.pausePlaySprite()

	local options = {
	effect = "slideDown", time = 200, isModal=true
	}

	composer.showOverlay("screenGamePause", options )	--This is our Pause Screen

	return true
end
----------------------------------------------------------------------------------------


---------------------------------------------------------------------------------------------------------
-- function to disable the slash effect event listener
---------------------------------------------------------------------------------------------------------
function killSlash()
Runtime:removeEventListener("touch", drawSlashLine)
end

function removeLine(event)
end

---------------------------------------------------------------------------------------------------------
-- calculate angle between o1 and o2 (Object1 and Object2)
---------------------------------------------------------------------------------------------------------
function angleBetween ( srcObj, dstObj )
	if (srcObj.x == dstObj.x) then srcObj.x=srcObj.x+1 end
	local xDist = dstObj.x-srcObj.x ; local yDist = dstObj.y-srcObj.y
	local angleBetween = math.deg( math.atan( yDist/xDist ) )
	if ( srcObj.x < dstObj.x ) then angleBetween = angleBetween+90 else angleBetween = angleBetween-90 end
	return angleBetween - 90
end

---------------------------------------------------------------------------------------------------------
-- Draws the slash line that appears when the user swipes finger across the screen
---------------------------------------------------------------------------------------------------------
function drawSlashLine(event)
	if (myGlobalData.endGame==false) then			
		if event.phase == "began" then
			numTouches = numTouches + 1
		elseif event.phase == "cancelled" or event.phase == "ended" then
		end
		-- access if the user has swiped 'enough' to start the swipe/slash routine
		if(endPoints ~= nil and endPoints[1] ~= nil) then
			local distance = math.sqrt(math.pow(event.x - endPoints[1].x, 2) + math.pow(event.y - endPoints[1].y, 2))
			if(distance > minDistanceForSlashSound and slashSoundEnabled == true) then 
				playRandomSlashSound();  
				slashSoundEnabled = false
				timer.performWithDelay(minTimeBetweenSlashes, function(event) slashSoundEnabled = true end)
			end
		end
		-- Insert a new point into the front of the array
		table.insert(endPoints, 1, {x = event.x, y = event.y, line=nil, area=nil, myID=event.id}) 

		-- Remove any excess points
		if(#endPoints > maxPoints) then 
			table.remove(endPoints)
		end

		for i,v in ipairs(endPoints) do
			local line = display.newLine(v.x, v.y, event.x, event.y)
			line.anchorX = 0.5		-- Graphics 2.0 Anchoring method
			line.anchorY = 0.5		-- Graphics 2.0 Anchoring method
			line.strokeWidth = lineThickness
			local gotAngle = angleBetween(v,event)
			local area = display.newRect(v.x-10, v.y-8, 20, 8)
			area.anchorX = 1.0		-- Graphics 2.0 Anchoring method
			area.anchorY = 1.0		-- Graphics 2.0 Anchoring method
			area.alpha=0.0; area.rotation = gotAngle
			local myPhysics = physics.addBody(area, "static")
			area.isSensor = true; area.objectType = 'SlashArea'
			slashGroup:insert(line)
			slashGroup:insert(area)
			transition.to(line, {time = lineFadeTime, alpha = 0.5, xScale=0.7, yScale=0.7, onComplete = function(event) display.remove(line);line=nil;display.remove(area);area=nil end})		
		end

		--Cleanup when completed
		if(event.phase == "ended") then		
			while(#endPoints > 0) do
				table.remove(endPoints)
			end
		end

	else
	
	print("******************************************************")
	print("Slash DE-ACTIVATED: from within Slash Function/Module..")
	print("******************************************************")
	Runtime:removeEventListener("touch", drawSlashLine)
	while(#endPoints > 0) do
		table.remove(endPoints)
	end
	display.remove(slashGroup); slashGroup = nil
		
	end
end

---------------------------------------------------------------------------------------------------------
-- Play a slash sound
---------------------------------------------------------------------------------------------------------
function playRandomSlashSound()
	local theSound = "slash" .. math.random(1, 3)
	audio.play(slashSounds[theSound])
end



-- Called when scene is about to move offscreen:
function scene:overlayEnded( event )
    --Restart the physics engine
    physics.start();
    --Restart any animations from external modules
    Hero.pausePlaySprite()
end



-----------------------------------------------------------------------------------------
-- END OF YOUR IMPLEMENTATION
-----------------------------------------------------------------------------------------

-- Listener setup
scene:addEventListener( "create", scene )
scene:addEventListener( "show", scene )
scene:addEventListener( "hide", scene )
scene:addEventListener( "destroy", scene )

-- "destroyScene" event is dispatched before view is unloaded, which can be
-- automatically unloaded in low memory situations, or explicitly via a call to
-- composer.purgeScene() or composer.removeScene().
--scene:addEventListener( "destroyScene", scene )
scene:addEventListener( "overlayEnded", scene )

------------------------------------------------------------------------------------------------------------------------------------
-- Start our game events running
------------------------------------------------------------------------------------------------------------------------------------
Runtime:addEventListener("enterFrame", updateScene)
Runtime:addEventListener ( "collision", onGlobalCollision )
Runtime:addEventListener("touch", drawSlashLine)

return scene