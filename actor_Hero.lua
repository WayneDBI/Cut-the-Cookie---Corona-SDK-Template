module(..., package.seeall)

---------------------------------------------------------------------------------------------------------
-- Collect any global Variables for use in this module
---------------------------------------------------------------------------------------------------------
local myGlobalData 		= require( "globalData" )

---------------------------------------------------------------------------------------------------------
-- Import the SPINE animation modules
---------------------------------------------------------------------------------------------------------
local spine = require "spine.spine"

---------------------------------------------------------------------------------------------------------
-- Setup a variable to trigger the animations to STOP/CHANGE
---------------------------------------------------------------------------------------------------------
local changeTheScene	 = false

---------------------------------------------------------------------------------------------------------
-- Function to create the Hero
-- The Hero function accepts 2 x parameters: [x & y].
-- These variables are used to POSITION the hero on the screen
-- Note: In this module we have commented out the STANDARD method of animating your character, if you
-- do not want to use SPINE animations. If this is the case, you will need to add your own animations
-- and control the states accordingly.
---------------------------------------------------------------------------------------------------------
function newHero(params)
	
	---------------------------------------------------------------
	-- Setup our SPINE animation characters, variables and states
	---------------------------------------------------------------
	local lastTime 			= 0
	local animationTime		= 0
	local json				= spine.SkeletonJson.new()
	json.scale				= 0.42
	skeletonData			= json:readSkeletonDataFile("_Assets/SpineAnimationData/skeleton.json")
	sitAnimation			= skeletonData:findAnimation("SitWave")
	
	--print(myGlobalData.worldSelected)

	---------------------------------------------------------------------------------------------------------
	-- Local variables for this module
	---------------------------------------------------------------------------------------------------------
	-- Set up a few local variables for our hero/goal/target    
	local playSound			= false
    local sweetCollected 	= false
	local heroGroup			= display.newGroup()
	
	---------------------------------------------------------------------------------------------------------
	--Draw the PLATFORM our hero will sit on
	---------------------------------------------------------------------------------------------------------
	local heroPlatform = display.newSprite( myGlobalData.imageSheet, myGlobalData.animationSequenceData )
	heroPlatform:setSequence( "worldBase"..myGlobalData.worldSelected ) -- Each world has a different platform - controlled by this variable
	heroPlatform:play()
    heroPlatform.xScale=1.0
    heroPlatform.yScale=1.0
	heroPlatform.x = params.positionX
	heroPlatform.y = params.positionY
	heroGroup:insert( heroPlatform )

	---------------------------------------------------------------------------------------------------------
	-- Draw the actual HERO/goal point
	---------------------------------------------------------------------------------------------------------
	-- SPINE ANIMATION METHOD
	---------------------------------------------------------------------------------------------------------
	local Hero = display.newCircle( params.positionX,params.positionY, 60 )
    Hero.xScale=1.0
    Hero.yScale=1.0
    Hero.alpha = 0.0
    Hero.objectType="HeroZone"
    Hero.x = params.positionX
    Hero.y = params.positionY - 60
	physics.addBody( Hero,"static", { density=0.1, friction=0.1, bounce=0, radius=60, isSensor=true }) --This is ONLY used for animation purposes
	heroGroup:insert( Hero )

	---------------------------------------------------------------------------------------------------------
	-- STANDARD CORONA LUA ANIMATION METHOD: using an animationSequenceData method
	---------------------------------------------------------------------------------------------------------
	--[[
	local Hero = display.newSprite( myGlobalData.imageSheetHero, myGlobalData.animationSequenceDataHero )
    Hero.xScale=1.0
    Hero.yScale=1.0
	Hero:setSequence( "heroNormal" )
	Hero:play()
    Hero.objectType="HeroZone"
    Hero.x = params.positionX
    Hero.y = params.positionY -12
	physics.addBody( Hero,"static", { density=0.1, friction=0.1, bounce=0, radius=60, isSensor=true }) --This is ONLY used for animation purposes
	heroGroup:insert( Hero )
	--]]
	
	
	---------------------------------------------------------------------------------------------------------
	-- Draw the animated chef
	---------------------------------------------------------------------------------------------------------
	skeleton = spine.Skeleton.new(skeletonData)
	function skeleton:createImage (attachment)
		-- Customize where images are loaded.
		return display.newImage("_Assets/SpineAnimationData/" .. attachment.name .. ".png")
	end

	skeleton.group.x	= params.positionX
	skeleton.group.y 	= params.positionY -12
	skeleton.flipX		= false
	skeleton.flipY		= false
	skeleton.debug		= false -- Omit or set to false to not draw debug lines on top of the images.
	skeleton:setToSetupPose()

	-- AnimationStateData defines crossfade durations between animations.
	local stateData = spine.AnimationStateData.new(skeletonData)

	-- AnimationState has a queue of animations and can apply them with crossfading.
	state = spine.AnimationState.new(stateData)
	
	---------------------------------------------------------------------------------------------------------
	-- Start the Chef animation off with him Sitting and waving
	-- Note: the second parameter (true, false) is the LOOPING option
	---------------------------------------------------------------------------------------------------------
	state:setAnimation("SitWave", true)

	---------------------------------------------------------------------------------------------------------
	-- Their are 4 animated sequences to choose from:
	---------------------------------------------------------------------------------------------------------
	--state:addAnimation("SitWave", true)
	--state:addAnimation("Excited", true)
	--state:addAnimation("Sad", false)
	--state:addAnimation("EatCookie", true)
	
	---------------------------------------------------------------------------------------------------------
	-- Add the hero to the heroGroup
	---------------------------------------------------------------------------------------------------------
	heroGroup:insert( skeleton.group )
	
	
	---------------------------------------------------------------------------------------------------------
	--Draw an invisible area to check for a Biscuit + MOUTH hit
	---------------------------------------------------------------------------------------------------------
	local HeroTarget = display.newCircle(Hero.x,Hero.y+4,25) -- This is the AREA used to detect if the SWEET is in the heros MOUTH.
	HeroTarget:setFillColor(255,0,0)
	HeroTarget.alpha=0.0
    HeroTarget.objectType="HeroMouth"
	physics.addBody( HeroTarget,"static", { density=0.1, friction=0.1, bounce=0, radius=(HeroTarget.width/2), isSensor=true }) --This is ONLY used for animation purposes
	heroGroup:insert( HeroTarget )



	---------------------------------------------------------------------------------------------------------
	--Start / stop any animations
	---------------------------------------------------------------------------------------------------------
	function pausePlaySprite()
		if(myGlobalData.levelPaused == true) then
			---------------------------------------------------------------------------------------------------------
			--Pause routine for standard animations
			---------------------------------------------------------------------------------------------------------
			--Hero:pause()
		
			--We update this variable to tell the SPINE engine to STOP ANIMATING
			changeTheScene	 = true
		else
			---------------------------------------------------------------------------------------------------------
			--Start routine for standard animations
			---------------------------------------------------------------------------------------------------------
			--Hero:play()
		
			--We update this variable to tell the SPINE engine to STOP ANIMATING
			changeTheScene	 = false
		end
	end


	---------------------------------------------------------------------------------------------------------
	--Set the animation back to an idle state function
	---------------------------------------------------------------------------------------------------------
	local function backToNormalAnimation(event)
		if ( event.phase == "ended" ) then
			print("Back to Norm")
			---------------------------------------------------------------------------------------------------------
			--Update the SPINE Animation
			---------------------------------------------------------------------------------------------------------
			state:setAnimation("SitWave", true)
			
			---------------------------------------------------------------------------------------------------------
			--Update routine for standard animations
			---------------------------------------------------------------------------------------------------------
			--[[
			--Update the basic Animation technique
			Hero:setSequence( "heroNormal" )
			Hero:play()
			Hero:removeEventListener( "sprite", backToNormalAnimation )
			--]]
			
		end
	end


	---------------------------------------------------------------------------------------------------------
	--change global variable if level completed is triggered
	---------------------------------------------------------------------------------------------------------
	function levelCompleted(event)
		myGlobalData.levelCompleted	= true
	end


	---------------------------------------------------------------------------------------------------------
	--Update the animation status, states and sequence within a private enterFrame event.
	---------------------------------------------------------------------------------------------------------
	function Hero:enterFrame(event)

		if( myGlobalData.levelReset==false and myGlobalData.endGame==false ) then
		
			---------------------------------------------------------------------------------------------------------
			-- Update the SPINE Animations
			-- Compute time in seconds since last frame.
			---------------------------------------------------------------------------------------------------------
			local currentTime 		= event.time / 1000
			local delta 			= currentTime - lastTime
			lastTime 				= currentTime

			---------------------------------------------------------------------------------------------------------
			-- check to see if the change event has been triggered.
			---------------------------------------------------------------------------------------------------------
			if( changeTheScene == false ) then
				---------------------------------------------------------------------------------------------------------
				-- Update the state with the delta time, apply it, and update the world transforms.
				---------------------------------------------------------------------------------------------------------
				state:update(delta)
				state:apply(skeleton, animationTime, true)

				--state:update(delta)
				--state:apply(skeleton)
				skeleton:updateWorldTransform()
			end

			------------------------------------------------------------------------------------------------
			-- Has the user collected a star? change animation if yes....
			------------------------------------------------------------------------------------------------
			if(myGlobalData.starCollected == true) then
				myGlobalData.starCollected = false --reset the variable, so our animation in the hero can restart..
				print("YES: A star was collected!")
				--Update the SPINE Animation
				state:setAnimation("Excited", true)
				
				--[[
				--Update the basic Animation technique
				Hero:setSequence( "heroHappy" )
				Hero:play()
				--]]
				Hero:addEventListener( "sprite", backToNormalAnimation ) -- Add a sprite Listener event.		
			end
			------------------------------------------------------------------------------------------------

			------------------------------------------------------------------------------------------------
			-- Has the user Hit the spikes or gone out of the scene?
			------------------------------------------------------------------------------------------------
			if(myGlobalData.heroIsSad == true ) then
				myGlobalData.heroIsSad = false -- set the variable back
				print("SAD: The biscuit was destroyed!")
				--Update the SPINE Animation
				state:setAnimation("Sad", false)
				
				--[[
				--Update the basic Animation technique
				Hero:setSequence( "heroSad" )
				Hero:play()
				--]]
			end
			------------------------------------------------------------------------------------------------
			
			------------------------------------------------------------------------------------------------
			-- Has the user reached the Goal (mouth?)
			------------------------------------------------------------------------------------------------
			if(myGlobalData.sweetInGoal == true ) then
				myGlobalData.sweetInGoal = false -- set the variable back
				print("WIN: The chef got the Biscuit!")
				--Update the SPINE Animation
				state:setAnimation("EatCookie", true)
				
				--[[
				--Update the basic Animation technique
				Hero:setSequence( "heroEat" )
				Hero:play()
				--]]
				local completedLevel = timer.performWithDelay(1000, levelCompleted )
			end
			------------------------------------------------------------------------------------------------


		else
			--A reset level was called - so cancel the HERO update/enterFrame events
			Runtime:removeEventListener("enterFrame", Hero)

		end
		
		if (myGlobalData.endGame==true) then
			changeTheScene=true
			Runtime:removeEventListener("enterFrame", Hero)
		end

	end


	------------------------------------------------------------------------------------------------
	-- Collision event on the hero
	------------------------------------------------------------------------------------------------
    local function onCollisionHero( self, event )
        if ( event.phase == "began" ) then
			if ( myGlobalData.levelFailed == false and myGlobalData.sweetSmashed==false and myGlobalData.levelReset==false) then
				if (sweetCollected==false) then
			
					------------------------------------------------------------------------------------------------
					--Check if the sweet is in the HERO zone..
					------------------------------------------------------------------------------------------------
					if (event.other.objectType == "Sweet") then
						--Update the basic Animation technique
						state:setAnimation("Excited", true)
						Hero:addEventListener( "sprite", backToNormalAnimation ) -- Add a sprite Listener event.		
						--[[
						--Update the basic Animation technique
						Hero:setSequence( "heroOpenMouth" )
						Hero:play()
						Hero:addEventListener( "sprite", backToNormalAnimation ) -- Add a sprite Listener event.		
						--]]
					end
					------------------------------------------------------------------------------------------------

				end
				
				if ( event.phase == "ended" ) then
					--Hero:setSequence( "heroNormal" )
					--Hero:play()
					--timer.performWithDelay(10000, resetSound, 1)
					--event.other.collisionHerot=false
				end
				
			------------------------------------------------------------------------------------------------
			end
		end
	end

	------------------------------------------------------------------------------------------------
	-- Add physics attributes to the hero parts
	------------------------------------------------------------------------------------------------
    physics.addBody( Hero,"static", { density=1, friction=0.2, bounce=0, isSensor=true })
	Hero.isFixedRotation = true

    Hero.collision = onCollisionHero
    Hero:addEventListener( "collision", Hero )	
	Runtime:addEventListener("enterFrame", Hero)

    return heroGroup

    
end
