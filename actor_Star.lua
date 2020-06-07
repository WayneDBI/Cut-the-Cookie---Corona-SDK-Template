module(..., package.seeall)

---------------------------------------------------------------------------------------------------------
-- Collect any global Variables for use in this module
---------------------------------------------------------------------------------------------------------
local myGlobalData 		= require( "globalData" )

---------------------------------------------------------------------------------------------------------
-- Function to create the Stars around our game area.
-- Accepts the X,Y parameters from the called class
---------------------------------------------------------------------------------------------------------
function newStar(x, y)
	
	---------------------------------------------------------------------------------------------------------
	-- Local variables for this module
	---------------------------------------------------------------------------------------------------------
    local density		= 1.0
    local playSound		= false
    local starCollected	= false
	local StarPopped 	= false
	local starGroup 	= display.newGroup()

	---------------------------------------------------------------------------------------------------------
	-- Add a background glowy image, to sit behind each star
	---------------------------------------------------------------------------------------------------------
	local StarGlow = display.newSprite( myGlobalData.imageSheet, myGlobalData.animationSequenceData )
	StarGlow:setSequence( "starGlow" )
	StarGlow:play()
    StarGlow.xScale	= 1.2
    StarGlow.yScale	= 1.2
	StarGlow.x 		= x
	StarGlow.y 		= y
	starGroup:insert( StarGlow )

	---------------------------------------------------------------------------------------------------------
	-- Add the star to the scene; and assign any meta data, used later to detect a collision
	---------------------------------------------------------------------------------------------------------
	local Star = display.newSprite( myGlobalData.imageSheet, myGlobalData.animationSequenceData )
    Star.xScale		= 1.2
    Star.yScale		= 1.2
	Star:setSequence( "starAnimate" )
	Star:play()
    Star.objectType	= "Star"
    Star.x			= x
    Star.y			= y
	
	---------------------------------------------------------------------------------------------------------
	-- change star density as required
	---------------------------------------------------------------------------------------------------------
    function Star:density(value)
        physics.removeBody(Star)
        physics.addBody( Star,"static", { density=value, friction=0.2, bounce=0, isSensor=true })
    end

	---------------------------------------------------------------------------------------------------------
	-- destroy the star cleanly
	---------------------------------------------------------------------------------------------------------
	function destroyStar()
		if ( myGlobalData.levelReset==false) then
			display.remove(Star)
			Star = nil
		end
	end

	---------------------------------------------------------------------------------------------------------
	-- destroy the star from remote module
	---------------------------------------------------------------------------------------------------------
    function Star:destroy()
		if ( myGlobalData.levelReset==false) then
			display.remove(Star)
			Star = nil
			StarPopped = true
		end
	end

	---------------------------------------------------------------------------------------------------------
	-- Start / stop any animations
	---------------------------------------------------------------------------------------------------------
	function pausePlaySprite()
		if(myGlobalData.levelPaused == true) then
			Star:pause()
		else
			Star:play()
		end
	end


	---------------------------------------------------------------------------------------------------------
	-- reset any sounds on the star
	---------------------------------------------------------------------------------------------------------
    local function resetSound(event)
        if event.completed then
            playSound=false
        else
            playSound=false
        end
    end


	---------------------------------------------------------------------------------------------------------
	-- function to handle when a star is hit/popped
	---------------------------------------------------------------------------------------------------------
    local function StarPop()
    
        if ( myGlobalData.levelFailed == false and myGlobalData.sweetSmashed==false and myGlobalData.levelReset==false) then

			---------------------------------------------------------------------------------------------------------
			-- set the stars popped flagged to true
			---------------------------------------------------------------------------------------------------------
			StarPopped = true
			
			---------------------------------------------------------------------------------------------------------
			-- remove the GLOW effect
			---------------------------------------------------------------------------------------------------------
			display.remove(StarGlow)
			StarGlow = nil
		
			---------------------------------------------------------------------------------------------------------
			-- increment the levels star counter
			---------------------------------------------------------------------------------------------------------
			myGlobalData.starsCollected = myGlobalData.starsCollected + 1

			---------------------------------------------------------------------------------------------------------
			-- update the HUD INTERFACE with the correct number of collected stars shown
			---------------------------------------------------------------------------------------------------------
			if(myGlobalData.starsCollected == 1) then
				hudStar1:setSequence( "hudStarOn" )
				hudStar1:play()
			elseif(myGlobalData.starsCollected == 2) then
				hudStar2:setSequence( "hudStarOn" )
				hudStar2:play()
			elseif(myGlobalData.starsCollected == 3) then
				hudStar3:setSequence( "hudStarOn" )
				hudStar3:play()
			end
				
			-----------------------------------------------------------------
			-- Update Score on the screen:
			-----------------------------------------------------------------
			myScoreText.text = "Score: "..myGlobalData.starsCollected
			--myScoreText:setReferencePoint(display.CenterLeftReferencePoint);
			myScoreText.anchorX = 0.0		-- Graphics 2.0 Anchoring method
			myScoreText.anchorY = 0.5		-- Graphics 2.0 Anchoring method
			myScoreText.x = 10; myScoreText.y = 45
		
			---------------------------------------------------------------------------------------------------------
			-- change the star animation to a COLLECTED animation.
			---------------------------------------------------------------------------------------------------------
			Star:setSequence( "starCollect" )
			Star:play()
			
			---------------------------------------------------------------------------------------------------------
			-- add a SPRITE event listener to the animation. We'll use this to detect when the animation is done
			-- Once it has completed we'll destroy it cleanly from the screen.
			---------------------------------------------------------------------------------------------------------
			--Star:addEventListener( "sprite", starAnimationListener ) -- Add a sprite Listener event.
			
			--Remove the STAR sprite after 1/2 a second...
			timer.performWithDelay(300, function(event) display.remove(Star);Star=nil end)
		
		end
    	
    end

	---------------------------------------------------------------------------------------------------------
	-- function to handle touches on the star: not used at present, but could be used at a later date?
	---------------------------------------------------------------------------------------------------------
    local function handleTouch ( event )
        if(event.phase == "began") then

        end
        if( event.phase == "moved" ) then

        end
        if "ended" == event.phase or "cancelled" == event.phase then
        	if ( myGlobalData.levelFailed == false and myGlobalData.sweetSmashed==false and myGlobalData.levelReset==false) then
            	StarPop()
            end
        end
    end


	---------------------------------------------------------------------------------------------------------
	-- function to handle the star (sprite)'s animation status. we need to know when the star animation has finished.
	---------------------------------------------------------------------------------------------------------
	function starAnimationListener( event )
 	--print(event.name)
	  if ( event.phase == "ended" ) then
	  	--destroyStar()
	  	print("Star Animation finished")
			--event.name:stop()
			--display.remove(event.target)
			--event.target = nil
			--Star:destroy()
			--timer.performWithDelay(10, destroyStar )
			--local thisSprite = event.target  --"event.target" references the sprite
	  end
 
	end

	---------------------------------------------------------------------------------------------------------
	-- Handle collisions with the stars.
	---------------------------------------------------------------------------------------------------------
    local function onCollisionStar( self, event )
        if ( event.phase == "began" ) then
        
 		---------------------------------------------------------------------------------------------------------
       	--has the biscuit(sweet) hit our star?
 		---------------------------------------------------------------------------------------------------------
       	if (event.other.objectType == "Sweet" and starCollected==false) then
				if ( myGlobalData.levelFailed == false and myGlobalData.sweetSmashed==false and myGlobalData.levelReset==false) then
					starCollected 				= true
					StarPopped 					= false
					myGlobalData.starCollected 	= true -- This variable is used by our hero animation.
					local delayAction 			= timer.performWithDelay( 20, StarPop )
					delayAction.StarBody 		= Star
					delayAction.sweetBody 		= event.other
					---------------------------------------------------------------------------------------------------------
					--Play the star collected sfx
					---------------------------------------------------------------------------------------------------------
					audio.play(sfx_Coin)
				end
        	end
        	
        	
		         
        end
        if ( event.phase == "ended" ) then
            --timer.performWithDelay(10000, resetSound, 1)
            --event.other.collisionStart=false
        end
    end

	---------------------------------------------------------------------------------------------------------
	--Add a physics body to our star
	---------------------------------------------------------------------------------------------------------
    physics.addBody( Star,"static", { density=1, friction=0.2, bounce=0, isSensor=true })
	Star.isFixedRotation = true

	---------------------------------------------------------------------------------------------------------
	--Add a collision listener to this individual star
	---------------------------------------------------------------------------------------------------------
    Star.collision = onCollisionStar
    Star:addEventListener( "collision", Star )
    
	---------------------------------------------------------------------------------------------------------
	--add the completed, constructed star to the starGroup
	---------------------------------------------------------------------------------------------------------
	starGroup:insert( Star )
    
	---------------------------------------------------------------------------------------------------------
	--return the completed data.
	---------------------------------------------------------------------------------------------------------
    return starGroup

end



