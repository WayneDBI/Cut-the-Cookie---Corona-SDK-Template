module(..., package.seeall)

---------------------------------------------------------------------------------------------------------
-- Collect any global Variables for use in this module
---------------------------------------------------------------------------------------------------------
local myGlobalData 		= require( "globalData" )

---------------------------------------------------------------------------------------------------------
-- Function to create the Biscuit (Cookie) in our game area.
-- Accepts the X,Y, and any extra velocityX & Y (vx,vy) parameters from the called class. The extra
-- velocity params, will give the biscuit an initial KICK of movement when the level is 1st created.
---------------------------------------------------------------------------------------------------------
function newCookie(x, y, vx, vy)
	
	---------------------------------------------------------------------------------------------------------
	-- Local variables for this module
	---------------------------------------------------------------------------------------------------------
    local density						= 80.3
    local playSound						= false
	local cookieGroup 					= display.newGroup()
	local cookieRadius 					= 20
	
	---------------------------------------------------------------------------------------------------------
	-- Exploded Biscuit should not interact with other items
	---------------------------------------------------------------------------------------------------------
	local cookieChoppedProp 				= {density = 1.0, friction = 0.3, bounce = 0.2, filter = {categoryBits = 4, maskBits = 8} } 
	
	---------------------------------------------------------------------------------------------------------
	-- Chopped cookie properties 
	---------------------------------------------------------------------------------------------------------
	local minCookieParticleRadius		= 10 
	local maxCookieParticleRadius		= 25
	local numOfCookieParticleParticles	= 5
	local CookieParticleFadeTime 		= 500
	local CookieParticleFadeDelay 		= 500
	local minCookieParticleVelocityX 	= -100
	local maxCookieParticleVelocityX 	= 100
	local minCookieParticleVelocityY 	= -50
	local maxCookieParticleVelocityY 	= 50
	
	---------------------------------------------------------------------------------------------------------
	-- Add our biscuit (was a cookie) to the scene. Add meta data as required. 
	---------------------------------------------------------------------------------------------------------
    --local Cookie = display.newImageRect(myGlobalData.imagePath.."cookie.png", 38, 38 )
	local Cookie 		= display.newSprite( myGlobalData.imageSheet, myGlobalData.animationSequenceData )
	Cookie:setSequence( "cookieMain" )
	Cookie:play()
    Cookie.objectType	= "Sweet"
    Cookie.objectStatus	= "ok"
    Cookie.x				= x
    Cookie.y				= y
    Cookie.xScale		= 1.0
    Cookie.yScale		= 1.0
	
	---------------------------------------------------------------------------------------------------------
	-- Insert the biscuit into the holding group 
	---------------------------------------------------------------------------------------------------------
	cookieGroup:insert(Cookie)

	---------------------------------------------------------------------------------------------------------
	-- function to manage/change the biscuits density 
	---------------------------------------------------------------------------------------------------------
    function Cookie:density(value)
        physics.removeBody(Cookie)
        physics.addBody( Cookie, { density=value, friction=1.5, bounce=0, radius=cookieRadius })
    end

	---------------------------------------------------------------------------------------------------------
	-- function to destroy the biscuit
	---------------------------------------------------------------------------------------------------------
    function Cookie:destroy()
		display.remove(Cookie)
		Cookie = nil
	end
	
	---------------------------------------------------------------------------------------------------------
	-- function to self destroy the biscuit
	---------------------------------------------------------------------------------------------------------
    function selfDestruct()
		display.remove(Cookie)
		Cookie = nil
	end
	
	---------------------------------------------------------------------------------------------------------
	-- function to Start / stop any animations
	---------------------------------------------------------------------------------------------------------
	function pausePlaySprite()
		if(myGlobalData.levelPaused == true) then
			Cookie:pause()
		else
			Cookie:play()
		end
	end
	
	---------------------------------------------------------------------------------------------------------
	-- function to create an 'exploding' biscuit effect.
	---------------------------------------------------------------------------------------------------------
	function chopCookieUp(event)
		---------------------------------------------------------------------------------------------------------
		-- set the biscuit smashed variable to true!
		---------------------------------------------------------------------------------------------------------
		myGlobalData.cookieSmashed = true
		
		if ( myGlobalData.levelFailed == false ) then

			local cookieBody = event.source.cookieBody
			local i
			
			---------------------------------------------------------------------------------------------------------
			-- set the status of the biscuit to broke
			---------------------------------------------------------------------------------------------------------
			cookieBody.objectStatus="broke"

			---------------------------------------------------------------------------------------------------------
			-- remove the main physics body, to stop further interactions with scene items.
			---------------------------------------------------------------------------------------------------------
			physics.removeBody(cookieBody)
			--Cookie:destroy()
			display.remove(Cookie)
			Cookie = nil

			
			---------------------------------------------------------------------------------------------------------
			-- trigger a reset level event. This is done by a globally managed variable.
			---------------------------------------------------------------------------------------------------------
			local function triggerLevelReset()
				myGlobalData.levelFailed = true
			end

			---------------------------------------------------------------------------------------------------------
			-- create a exploding sequence for each of the biscuit parts
			---------------------------------------------------------------------------------------------------------
			for  i = 1, numOfCookieParticleParticles do
				local CookieParticle = display.newSprite( myGlobalData.imageSheet, myGlobalData.animationSequenceData )
				CookieParticle:setSequence( "cookieBreak"..(i) )
				CookieParticle:play()
				CookieParticle.x=cookieBody.x
				CookieParticle.y=cookieBody.y
				CookieParticle.xScale = 1.3
				CookieParticle.yScale = 1.3
		
				cookieChoppedProp.radius = CookieParticle.width / 2
				physics.addBody(CookieParticle, "dynamic", cookieChoppedProp)

				---------------------------------------------------------------------------------------------------------
				-- set each of the exploded biscuit bits with a random X, Y velocity.
				---------------------------------------------------------------------------------------------------------
				local xVelocity = math.random(minCookieParticleVelocityX, maxCookieParticleVelocityX)
				local yVelocity = math.random(minCookieParticleVelocityY, maxCookieParticleVelocityY)
				CookieParticle:setLinearVelocity(xVelocity, yVelocity)
				transition.to(CookieParticle, {time = CookieParticleFadeTime, delay = CookieParticleFadeDelay, alpha=0, onComplete = function(event) display.remove(CookieParticle) end})		
			end
		
			local delayAction = timer.performWithDelay( 1200, triggerLevelReset )
				
		end
		
	end -- Finish creating the exploding biscuit effect.


	---------------------------------------------------------------------------------------------------------
	-- reset any sound events we have assigned to the biscuit/cookie.
	---------------------------------------------------------------------------------------------------------
    local function resetSound(event)
        if event.completed then
            playSound=false
        else
            playSound=false
        end
    end

 	---------------------------------------------------------------------------------------------------------
	-- manage all the collision events with the biscuit
	-- we'll also use this area to update any animation effects.
	---------------------------------------------------------------------------------------------------------
   local function onCollisionCookie( self, event )
        if ( event.phase == "began" ) then
        
			if (event.other.objectType == "Star") then
				Cookie:setSequence( "cookieShine" )
				Cookie:play()
			end
        
			if (event.other.objectType == "Spike" or event.other.objectType == "Wall" ) then
				---------------------------------------------------------------------------------------------------------
				--Play unhappy sound fx!
				---------------------------------------------------------------------------------------------------------
				audio.play(sfx_Poor)
				
				myGlobalData.heroIsSad = true
				local delayAction = timer.performWithDelay( 20, chopCookieUp )
				delayAction.cookieBody = event.target
			end
        
			if (event.other.objectType == "HeroMouth" ) then
				---------------------------------------------------------------------------------------------------------
				--Play happy sound fx!
				---------------------------------------------------------------------------------------------------------
				audio.play(sfx_Great)
				
				---------------------------------------------------------------------------------------------------------
				--Play happy sound fx! 2
				---------------------------------------------------------------------------------------------------------
				audio.play(sfx_Victory)

				myGlobalData.sweetInGoal = true
				local delayAction = timer.performWithDelay( 40, selfDestruct )
				delayAction.cookieBody = event.target
			end
        
        end
        if ( event.phase == "ended" ) then
            --timer.performWithDelay(10000, resetSound, 1)
            --event.other.collisionStart=false
        end
    end

	---------------------------------------------------------------------------------------------------------
	-- Add a physics body to the biscuit/cookie.
	---------------------------------------------------------------------------------------------------------
    physics.addBody( Cookie, { density=density, friction=0.1, bounce=120.0,radius=cookieRadius })
	--Cookie.dampingRatio	= 0
	--Cookie.frequency		= 0
	--Cookie.isFixedRotation = false
    Cookie.collision = onCollisionCookie

	---------------------------------------------------------------------------------------------------------
	-- Apply a linear impulse to the cookie, if required from the passed params.
	---------------------------------------------------------------------------------------------------------
	Cookie:applyLinearImpulse( vx,vy,Cookie.x,Cookie.y )

 	---------------------------------------------------------------------------------------------------------
	-- add event listeners to the biscuit.
	---------------------------------------------------------------------------------------------------------
   Cookie:addEventListener( "collision", Cookie )
	
	---------------------------------------------------------------------------------------------------------
	-- return the completed, constructed biscuit/cookie
	---------------------------------------------------------------------------------------------------------
    return Cookie
    
end


