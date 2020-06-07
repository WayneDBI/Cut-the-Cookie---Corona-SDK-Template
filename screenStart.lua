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
-- screenStart.lua
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
local dataReset			= require("actor_ResetVariables")
local spine 			= require "spine.spine"
local changeTheScene	= false
require "sprite"

---------------------------------------------------------------
-- Define our SCENE variables and sprite object variables
---------------------------------------------------------------
local startCharY		= -100
local endCharY			= myGlobalData._h-60
local startLogoX		= -170
local endLogoX			= myGlobalData._w/2
local screenW			= display.contentWidth
local screenH			= display.contentHeight
local halfW 			= display.contentWidth*0.5
local buttonGroup 		= display.newGroup()

---------------------------------------------------------------
-- Setup our SPINE animation characters and states
---------------------------------------------------------------
local lastTime = 0
local animationTime = 0
local json = spine.SkeletonJson.new()
json.scale = 0.8
skeletonData = json:readSkeletonDataFile("_Assets/SpineAnimationData/skeleton.json")
sitAnimation = skeletonData:findAnimation("SitWave")



-- "scene:create()"
function scene:create( event )

   local sceneGroup = self.view

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
	--Draw the background items
	-------------------------------------------------------------------------------------------------------------
	--local bigCookie = display.newImageRect( myGlobalData.imagePath.."cookieOnString.png", 84,477 )
	local bigCookie = display.newSprite( myGlobalData.imageSheet, myGlobalData.animationSequenceData )
	bigCookie:setSequence( "cookieOnString" )
	bigCookie:play()
	bigCookie.x = myGlobalData._w-40; bigCookie.y = 240; bigCookie.alpha = 1.0
	screenGroup:insert( bigCookie )

	--logo = display.newImageRect( myGlobalData.imagePath.."cutTheCookie_logo.png", 286,172 )
	logo = display.newSprite( myGlobalData.imageSheet, myGlobalData.animationSequenceData )
	logo:setSequence( "cutTheCookie_logo" )
	logo:play()
	logo.x = startLogoX; logo.y = 100; logo.alpha = 1.0
	screenGroup:insert( logo )

	--local coronaInfo = display.newImageRect( myGlobalData.imagePath.."coronaInfo.png", 186,24 )
	local coronaInfo = display.newSprite( myGlobalData.imageSheet, myGlobalData.animationSequenceData )
	coronaInfo:setSequence( "coronaInfo" )
	coronaInfo:play()
	coronaInfo.x = myGlobalData._w/2; coronaInfo.y = 190; coronaInfo.alpha = 1.0
	screenGroup:insert( coronaInfo )
	
	--local dbaBorder = display.newImageRect( myGlobalData.imagePath.."dottedBox.png", 289,52 )
	local dbaBorder = display.newSprite( myGlobalData.imageSheet, myGlobalData.animationSequenceData )
	dbaBorder:setSequence( "dottedBox" )
	dbaBorder:play()
	--dbaBorder:setReferencePoint( display.TopLeftReferencePoint )
	dbaBorder.anchorX = 0.0		-- Graphics 2.0 Anchoring method
	dbaBorder.anchorY = 0.0		-- Graphics 2.0 Anchoring method
	dbaBorder.x = 0; dbaBorder.y = 200; dbaBorder.alpha = 1.0
	screenGroup:insert( dbaBorder )
	
	--local dbaLogo = display.newImageRect( myGlobalData.imagePath.."dbaLogo.png", 77,40 )
	local dbaLogo = display.newSprite( myGlobalData.imageSheet, myGlobalData.animationSequenceData )
	dbaLogo:setSequence( "dbaLogo" )
	dbaLogo:play()
	dbaLogo.x = (myGlobalData._w/2)+80; dbaLogo.y = 221; dbaLogo.alpha = 1.0
	screenGroup:insert( dbaLogo )

	--local bigCushion = display.newImageRect( myGlobalData.imagePath.."cushionLarge.png", 194,115 )
	local bigCushion = display.newSprite( myGlobalData.imageSheet, myGlobalData.animationSequenceData )
	bigCushion:setSequence( "cushionLarge" )
	bigCushion:play()
	bigCushion.x = 110; bigCushion.y = myGlobalData._h-55; bigCushion.alpha = 1.0
	screenGroup:insert( bigCushion )


	---------------------------------------------------------------------
	-- Draw the animated chef
	-- Note our animation is from a SPINE ANIMATION. Simply replace all
	-- reference to the spine animation with standard animations to use your
	-- own characters etc.
	---------------------------------------------------------------------
	skeleton = spine.Skeleton.new(skeletonData)
	function skeleton:createImage (attachment)
		-- Customize where images are loaded.
		return display.newImage("_Assets/SpineAnimationData/" .. attachment.name .. ".png")
	end

	skeleton.group.x = 110
	skeleton.group.y = startCharY
	skeleton.flipX = false
	skeleton.flipY = false
	skeleton.debug = false -- Omit or set to false to not draw debug lines on top of the images.
	skeleton:setToSetupPose()

	-- AnimationStateData defines crossfade durations between animations.
	local stateData = spine.AnimationStateData.new(skeletonData)
	stateData:setMix("Excited", "Sad", 0.4)
	stateData:setMix("Excited", "EatCookie", 0.4)
	stateData:setMix("Excited", "Sad", 0.4)

	-- AnimationState has a queue of animations and can apply them with crossfading.
	state = spine.AnimationState.new(stateData)
	state:setAnimation("Excited", true)


	screenGroup:insert( skeleton.group )
	---------------------------------------------------------------------


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
	-- Button PLAY
	-------------------------------------------------------------------------------------------------------------
	local buttonBase = widget.newButton{
	sheet = myGlobalData.imageSheet, defaultFrame = 5, overFrame = 6, onRelease = buttonPlay, }
	--buttonBase:setReferencePoint(display.CenterReferencePoint)
	buttonBase.x = myGlobalData._w/2; buttonBase.y = 340
	buttonGroup:insert( buttonBase )

	local buttonText = display.newSprite( myGlobalData.imageSheet, myGlobalData.animationSequenceData )
	buttonText:setSequence( "textPlay" )
	buttonText.x = myGlobalData._w/2; buttonText.y = 340; buttonText:play()
	buttonGroup:insert(buttonText)

	-------------------------------------------------------------------------------------------------------------
	-- Button OPTIONS
	-------------------------------------------------------------------------------------------------------------
	local buttonBase = widget.newButton{
	sheet = myGlobalData.imageSheet, defaultFrame = 5, overFrame = 6, onRelease = buttonOptions, }
	--buttonBase:setReferencePoint(display.CenterReferencePoint)
	buttonBase.x = myGlobalData._w/2; buttonBase.y = 400
	buttonGroup:insert( buttonBase )

	local buttonText = display.newSprite( myGlobalData.imageSheet, myGlobalData.animationSequenceData )
	buttonText:setSequence( "textOptions" )
	buttonText.x = myGlobalData._w/2; buttonText.y = 400; buttonText:play()
	buttonGroup:insert(buttonText)


	-------------------------------------------------------------------------------------------------------------
	-- Add the buttons to the main screen group
	-------------------------------------------------------------------------------------------------------------
	screenGroup:insert( buttonGroup )
	
	-------------------------------------------------------------------------------------------------------------
	-- move the button group over a fraction.
	-------------------------------------------------------------------------------------------------------------
	buttonGroup.x = buttonGroup.x+60
	buttonGroup.y = buttonGroup.y-60
	

	-------------------------------------------------------------------------------------------------------------
	-- Make our Hero Fall!
	-------------------------------------------------------------------------------------------------------------
	local function nudgeBackUp()
		transition.to(skeleton.group, { time=100, y=skeleton.group.y-30 } )
	end
	local fallChar=transition.to(skeleton.group, { time=600, y=endCharY+30, transition=easing.inQuad, onComplete=nudgeBackUp } )
	-------------------------------------------------------------------------------------------------------------


	-------------------------------------------------------------------------------------------------------------
	-- Move our logo on screen
	-------------------------------------------------------------------------------------------------------------
	local function nudgeBackOver2()
		transition.to(logo, { time=70, x=endLogoX } )
	end
	local function nudgeBackOver()
		transition.to(logo, { time=90, x=logo.x-70,onComplete=nudgeBackOver2 } )
	end
	local moveLogo=transition.to(logo, { time=700, x=endLogoX+30, transition=easing.inQuad, onComplete=nudgeBackOver } )
	-------------------------------------------------------------------------------------------------------------

	-----------------------------------------------------------------
	--Reserve Channels 1, 2, 3 for Specific audio
	-----------------------------------------------------------------
	audio.reserveChannels( 4 )

	-----------------------------------------------------------------
	-- Stop the GAME music playing on channel 2
	-----------------------------------------------------------------
 	audio.stop(2)


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
			composer.removeHidden()
		end
		
		for i = 1,myGlobalData.maxWorlds do
			for j = 1,myGlobalData.maxLevels do
				local buildPathToLevel = myGlobalData.worldPath.."World"..i.."_Levels.level"..j
				local buildLevelName = "level"..j
				composer.removeScene( buildPathToLevel )
				composer.removeScene( buildLevelName )
				composer.removeHidden()
			end
		end
			
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
		composer.removeScene( "screenOptions" )
		composer.removeScene( "screenWorldSelect" )
		composer.removeScene( "screenLevelSelect" )
		composer.removeScene( "screenLevelComplete" )
		composer.removeScene( "screenGameComplete" )

		composer.removeHidden()

		-----------------------------------------------------------------
		-- Start the MENU Music - Looping
		-----------------------------------------------------------------		
		audio.play(musicStart, {channel=1, loops = -1})

		---------------------------------------------------------------
		-- Add a enterFrame event to update the SPINE ANIMATION
		---------------------------------------------------------------
		Runtime:addEventListener( "enterFrame", updateTick )

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
-- Update Animations every tick/cycle
---------------------------------------------------------------
function updateTick(event)

	-- Compute time in seconds since last frame.
	local currentTime = event.time / 1000
	local delta = currentTime - lastTime
	lastTime = currentTime

	if(changeTheScene==false) then
		-- Update the state with the delta time, apply it, and update the world transforms.
		state:update(delta)
		state:apply(skeleton, animationTime, true)

		--state:update(delta)
		--state:apply(skeleton)
		skeleton:updateWorldTransform()
	end
end

---------------------------------------------------------------
-- PLAY button function
---------------------------------------------------------------
function buttonPlay()
	audio.play(sfx_Select)
	
	--print("Play button pressed")
	changeTheScene = true
	dataReset.VariableReset()

	--local buildPathToLevel = myGlobalData.worldPath.."World"..myGlobalData.worldSelected.."_Levels.level"..myGlobalData.myLevel
	--composer.gotoScene( buildPathToLevel )	--This is our main menu

	composer.gotoScene( "screenWorldSelect", "crossFade", 200  )
	return true
end

---------------------------------------------------------------
-- OPTIONS button function
---------------------------------------------------------------
function buttonOptions()
	local audioPlay = audio.play(sfx_Select)
	
	--print("Options button pressed")
	changeTheScene = true
	composer.gotoScene( "screenOptions", "crossFade", 200  )
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