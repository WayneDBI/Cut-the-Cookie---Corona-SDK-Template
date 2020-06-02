module(..., package.seeall)

---------------------------------------------------------------------------------------------------------
-- Collect any global Variables for use in this module
---------------------------------------------------------------------------------------------------------
local myGlobalData 		= require( "globalData" )

---------------------------------------------------------------------------------------------------------
-- Function to create the Spikes around our game area.
-- Parameters we can feed to the function:
-- spikeType (1 to 4), x, y, getAngle, doRotate (true/false), rotateSpeed
---------------------------------------------------------------------------------------------------------
function newSpike(params)
	
	---------------------------------------------------------------------------------------------------------
	-- Local variables for this module
	---------------------------------------------------------------------------------------------------------
    local spikeCanRotate 	= params.doRotate
    local spikeRotateSpeed 	= params.rotateSpeed
    local density			= 1.0
    local playSound			= false
    local spikeCollected	= false
	local SpikePopped		= false
	local spikeTransition

	---------------------------------------------------------------------------------------------------------
	-- Add the correct spike to the screen
	---------------------------------------------------------------------------------------------------------
	local Spike = display.newSprite( myGlobalData.imageSheet, myGlobalData.animationSequenceData )
	Spike:setSequence( "spikes"..params.spikeType )
	Spike:play()
    Spike.objectType	= "Spike"
    Spike.x				= params.x
    Spike.y 			= params.y
    Spike.rotation 		= params.getAngle
    
	
	---------------------------------------------------------------------------------------------------------
	-- Change spike density if required
	---------------------------------------------------------------------------------------------------------
    function Spike:density(value)
        physics.removeBody(Spike)
        physics.addBody( Spike,"static", { density=value, friction=0.2, bounce=0, isSensor=true })
    end

	---------------------------------------------------------------------------------------------------------
	-- Destroy spike / change variable to popped.
	---------------------------------------------------------------------------------------------------------
    function Spike:destroy()        
		display.remove(Spike)
		Spike = nil
		SpikePopped = true
	end

	---------------------------------------------------------------------------------------------------------
	-- Reset sounds if assigned.
	---------------------------------------------------------------------------------------------------------
    local function resetSound(event)
        if event.completed then
            playSound=false
        else
            playSound=false
        end
    end


	---------------------------------------------------------------------------------------------------------
	-- Reset the scene variables.
	---------------------------------------------------------------------------------------------------------
    local function resetTheScene()
		myGlobalData.spikeHit 		= true
        myGlobalData.levelFailed 	= true
    end


	---------------------------------------------------------------------------------------------------------
	-- Handle touch events: Not used in this template, but you could add more functionality as required.
	---------------------------------------------------------------------------------------------------------
    local function handleTouch ( event )
        if(event.phase == "began") then

        end
        
        if( event.phase == "moved" ) then

        end
        
        if "ended" == event.phase or "cancelled" == event.phase then
            SpikePop()
        end
    end



	---------------------------------------------------------------------------------------------------------
	-- We assign the spike CLASS to the enterFrame event
	-- This way we can have SEPARATE enterFrame events PER SPIKE on the scene
	-- and control them independently
	---------------------------------------------------------------------------------------------------------
	function Spike:enterFrame(event)
		if ( myGlobalData.levelFailed == false and myGlobalData.levelReset==false ) then
				if(spikeCanRotate==true) then
					if (myGlobalData.levelPaused == false ) then
						Spike.rotation = Spike.rotation + spikeRotateSpeed
					end
				end
			else
			--A reset level was called - so cancel the Spike update/enterFrame events
			Runtime:removeEventListener("enterFrame", Spike)
		end
	end


	---------------------------------------------------------------------------------------------------------
	-- Detect if the biscuit has hit a spike.. Change game variables accordingly
	---------------------------------------------------------------------------------------------------------
    local function onCollisionSpike( self, event )
        if ( event.phase == "began" ) then
        
        	if (event.other.objectType == "Sweet") then
				myGlobalData.spikeHit = true
				
				---------------------------------------------------------------------------------------------------------
				--Play the cookie smashed sfx
				---------------------------------------------------------------------------------------------------------
				audio.play(sfx_Bomb)
        	end

        end
        if ( event.phase == "ended" ) then
            --timer.performWithDelay(10000, resetSound, 1)
            --event.other.collisionSpiket=false
        end
    end

	---------------------------------------------------------------------------------------------------------
	-- Add physics body to the spike
	---------------------------------------------------------------------------------------------------------
    physics.addBody( Spike,"static", { density=10, friction=0.2, bounce=0, isSensor=true })
	Spike.isFixedRotation = true

	---------------------------------------------------------------------------------------------------------
	-- assign the collision event for this spike
	---------------------------------------------------------------------------------------------------------
    Spike.collision = onCollisionSpike
    Spike:addEventListener( "collision", Spike )
	
	---------------------------------------------------------------------------------------------------------
	-- start the rotation event. if this biscuit needs to be rotated.
	---------------------------------------------------------------------------------------------------------
	function startRotationEvents()
		Runtime:addEventListener("enterFrame", Spike)
	end
	
	---------------------------------------------------------------------------------------------------------
	-- call the rotate option, after a short delay
	---------------------------------------------------------------------------------------------------------
	local delayAction = timer.performWithDelay( 20, startRotationEvents )
	
	---------------------------------------------------------------------------------------------------------
	-- return the finished constructed Spike.
	---------------------------------------------------------------------------------------------------------
    return Spike

    
end

