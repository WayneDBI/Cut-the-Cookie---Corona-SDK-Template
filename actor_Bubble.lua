module(..., package.seeall)

---------------------------------------------------------------------------------------------------------
-- Collect any global Variables for use in this module
---------------------------------------------------------------------------------------------------------
local myGlobalData 		= require( "globalData" )

---------------------------------------------------------------------------------------------------------
-- Function to create the floating Bubble
-- The Bubble function accepts 2 x parameters: [x & y].
-- These variables are used to POSITION the bubble on the screen
---------------------------------------------------------------------------------------------------------
function newBubble(x, y)

	---------------------------------------------------------------------------------------------------------
	-- Local variables for this module
	---------------------------------------------------------------------------------------------------------
    local density			= 1.0
    local playSound			= false
    local connectSweet 		= false
	local bubblePopped 		= false
	local bubbleVelocity 	= -300 -- How FAST the bubbly will float up against gravity

	---------------------------------------------------------------------------------------------------------
	-- Add the Bubble to the screen, and assign any meta data
	---------------------------------------------------------------------------------------------------------
    --local Bubble = display.newImageRect(imagePath.."bubble.png", 60, 60 )
	local Bubble = display.newSprite( myGlobalData.imageSheet, myGlobalData.animationSequenceData )
	Bubble:setSequence( "bubbleFixed" )
	Bubble:play()
    Bubble.objectType	= "Bubble"
    Bubble.x			= x
    Bubble.y			= y

	---------------------------------------------------------------------------------------------------------
	-- modify the bubbles density value:
	---------------------------------------------------------------------------------------------------------
    function Bubble:density(value)
        physics.removeBody(Bubble)
        physics.addBody( Bubble,"static", { density=value, friction=0.2, bounce=0, radius=19, isSensor=true })
    end

	---------------------------------------------------------------------------------------------------------
	-- Function to START/STOP the bubble animation
	---------------------------------------------------------------------------------------------------------
	function pausePlaySprite()
		if(myGlobalData.levelPaused == true) then
			Bubble:pause()
		else
			Bubble:play()
		end
	end

	---------------------------------------------------------------------------------------------------------
	-- Function to destroy the Bubble and stop any event listeners accordingly
	---------------------------------------------------------------------------------------------------------
    function Bubble:destroy()        
		---------------------------------------------------------------------------------------------------------
		--Play the bubble going down sfx
		---------------------------------------------------------------------------------------------------------
		audio.play(sfx_GoingDown)
		
		display.remove(Bubble)
		Bubble 			= nil
		bubblePopped 	= true
        Runtime:removeEventListener("enterFrame", Bubble)
	end


	---------------------------------------------------------------------------------------------------------
	-- Function to reset any sound effects on the bubble
	---------------------------------------------------------------------------------------------------------
    local function resetSound(event)
        if event.completed then
            playSound=false
        else
            playSound=false
        end
    end

	---------------------------------------------------------------------------------------------------------
	-- Function to POP the bubble
	---------------------------------------------------------------------------------------------------------
    local function BubblePop()
    
		---------------------------------------------------------------------------------------------------------
		--Play the bubble popping sfx
		---------------------------------------------------------------------------------------------------------
		audio.play(sfx_Pop)

 		local function destroyBubble()
 			physics.removeBody(Bubble)
			Bubble:destroy()
			
			if (myGlobalData.sweetInBubble==true) then
				myGlobalData.sweetInBubble=false
			end
		end

    	--print("Pop bubble")
    	
		---------------------------------------------------------------------------------------------------------
		-- Run an animation sequence when the user pops the bubble
		---------------------------------------------------------------------------------------------------------
    	Bubble:setSequence( "bubblePop" )
		Bubble:play()
		timer.performWithDelay(300, destroyBubble )
    	
    end

	---------------------------------------------------------------------------------------------------------
	-- handle the touch on the bubble
	---------------------------------------------------------------------------------------------------------
    local function handleTouch ( event )
        if(event.phase == "began") then

        end
        
        if( event.phase == "moved" ) then

        end

		---------------------------------------------------------------------------------------------------------
		-- only trigger the actions after the user has 'ended' the touch.
		---------------------------------------------------------------------------------------------------------
        if "ended" == event.phase or "cancelled" == event.phase then
        	if ( myGlobalData.levelFailed == false and myGlobalData.sweetSmashed==false and bubblePopped == false) then
				if(bubblePopped == false) then
					bubblePopped = true
					BubblePop()
				end
            end
        end
        
		---------------------------------------------------------------------------------------------------------
		-- Stop the touch going THROUGH the bubble. Incase their are ropes UNDER the biscuit & Bubble!
		---------------------------------------------------------------------------------------------------------
        return true
    end


	---------------------------------------------------------------------------------------------------------
	-- We assign the Bubble CLASS to the enterFrame event
	-- This way we can have SEPARATE enterFrame events PER Bubble on the scene
	-- and control them independently - VERY IMPORTANT!
	---------------------------------------------------------------------------------------------------------
	function Bubble:enterFrame(event)

		if( myGlobalData.levelReset==false ) then
			if( connectSweet == true and bubblePopped==false ) then
				Bubble:applyForce( 0, -1, Bubble.x, Bubble.y)
				Bubble.dampingRatio=1
				local vx, vy = Bubble:getLinearVelocity()
				Bubble:setLinearVelocity(0,bubbleVelocity)
				
				if (myGlobalData.spikeHit == true) then
					bubblePopped = true
					BubblePop()
				end
				
			end
			
		else
			---------------------------------------------------------------------------------------------------------
			--A reset level was called - so cancel the Bubbles update/enterFrame events
			---------------------------------------------------------------------------------------------------------
			Runtime:removeEventListener("enterFrame", Bubble)

		end

	end


	---------------------------------------------------------------------------------------------------------
	-- if the BUBBLE and BISCUIT touch - glue the 2 together (gracefully!)
	---------------------------------------------------------------------------------------------------------
	local function glueSweetToBubble( event )
        if ( myGlobalData.levelFailed == false  ) then
			local bubbleBody = event.source.bubbleBody
			local sweetBody = event.source.sweetBody
		
			---------------------------------------------------------------------------------------------------------
			--Flag the Biscuit as being IN A BUBBLE!
			---------------------------------------------------------------------------------------------------------
			myGlobalData.sweetInBubble = true
		
			---------------------------------------------------------------------------------------------------------
			--Add a WELD joint to the 2 items
			---------------------------------------------------------------------------------------------------------
			local function joinTogether()
        		if ( myGlobalData.levelFailed == false and myGlobalData.sweetSmashed==false and bubblePopped == false) then
					--local BubbleAnmte = display.newSprite( imageSheet, animationSequenceData )

					---------------------------------------------------------------------------------------------------------
					--Start the Bubble animation, once connected
					---------------------------------------------------------------------------------------------------------
					Bubble:setSequence( "bubbleAnimate" )
					Bubble:play()
		
					---------------------------------------------------------------------------------------------------------
					--Play the bubble going up sfx
					---------------------------------------------------------------------------------------------------------
					audio.play(sfx_GoingUp)

					---------------------------------------------------------------------------------------------------------
					--Set the body's type to dynamic
					---------------------------------------------------------------------------------------------------------
					Bubble.bodyType = "dynamic"
					physics.newJoint( "weld", sweetBody, bubbleBody, Bubble.x, Bubble.y )
					Bubble.isFixedRotation = true
					Bubble.dampingRatio=1
					Bubble:setLinearVelocity(0,0)
					Runtime:addEventListener("enterFrame", Bubble)
				end
			end
			
			---------------------------------------------------------------------------------------------------------
			--Once the Biscuit and Bubble touch: MOVE the biscuit to the centre of the bubble, nicely...
			---------------------------------------------------------------------------------------------------------
			 transition.to(sweetBody, {time=200, x=Bubble.x, y=Bubble.y, onComplete=joinTogether})
		end
	end


	---------------------------------------------------------------------------------------------------------
	--Detect of the biscuit and bubble have touched.
	---------------------------------------------------------------------------------------------------------
    local function onCollisionBubble( self, event )
        if ( event.phase == "began" ) then
        	if ( myGlobalData.levelFailed == false and myGlobalData.sweetSmashed==false) then
        
				--Lock the Sweet to the bubbles location if contact is made..
				if (event.other.objectType == "Sweet" and connectSweet==false and bubblePopped == false) then
					if (myGlobalData.sweetInBubble==false) then
						connectSweet = true
						bubblePopped = false
					
						myGlobalData.sweetInBubble = true
				
						--print(event.other.objectType)
						print("In bubble")
						print(myGlobalData.levelFailed)
						print(myGlobalData.sweetSmashed)
				
						local delayAction = timer.performWithDelay( 20, glueSweetToBubble )
						delayAction.bubbleBody = Bubble
						delayAction.sweetBody = event.other
					end
				end
			
				if not(event.other.isSensor) then
					if not(playSound) then

						if(event.other.objectType=="Bubble")then
							if(event.other.playSound)then
								return;
							end
						else
							if (event.other.objectType)then
								return;
							end
						end

						--sound.playCollisionBubbleSound(resetSound)
						--playSound=true
					
					end
				end
			end
        
        end
        
        if ( event.phase == "ended" ) then
            --timer.performWithDelay(10000, resetSound, 1)
            --event.other.collisionStart=false
        end
    end

	---------------------------------------------------------------------------------------------------------
	--add the physics to the bubble body
	---------------------------------------------------------------------------------------------------------
    --physics.addBody( Bubble, { density=density, friction=0.5, bounce=0.1,radius=30 })
    physics.addBody( Bubble,"static", { density=1, friction=0.2, bounce=0, radius=25, isSensor=true })
	Bubble.isFixedRotation = true

	---------------------------------------------------------------------------------------------------------
	--assign the event listeners to the bubble and body.
	---------------------------------------------------------------------------------------------------------
    Bubble.collision = onCollisionBubble
    Bubble:addEventListener( "collision", Bubble )
	Bubble:addEventListener("touch", handleTouch)
	
    return Bubble
end