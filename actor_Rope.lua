module(..., package.seeall)

---------------------------------------------------------------------------------------------------------
-- Collect any global Variables for use in this module
---------------------------------------------------------------------------------------------------------
local myGlobalData 		= require( "globalData" )

---------------------------------------------------------------------------------------------------------
-- Function to create the Ropes
---------------------------------------------------------------------------------------------------------
function newRope(params)

	---------------------------------------------------------------------------------------------------------
	-- Local variables for this module
	---------------------------------------------------------------------------------------------------------
	local PIE 			= 3.14159265358
	local mxRopesSet1 	= 0
	local mxRopesSet2 	= 0
	local ropeWidth 	= 13
	local ropeHeight 	= 40
	local angleDiff 	= 0
	local isRopeCut		= false
	local cutPosition 	= 0
	local numberOfLinks	= 0
	local rope 			= display.newGroup()
	rope.super 			= self
	local xCenter 		= params.nubX
	local sweetX 		= params.body.x
	local sweetY 		= params.body.y
	local y 			= params.y
	local wCeil 		= 10
	local hCeil 		= 0
	local joints 		= params.joints
	local array 		= {}
	local arrayJoints 	= {}
	local cut 			= false
	local isBeingCut 	= false
	local removeRope 	= true
	local density		= 5

	---------------------------------------------------------------------------------------------------------
	-- calculate distance between o1 and o2 (Object1 and Object2)
	---------------------------------------------------------------------------------------------------------
	function distance(o1,o2)
		return math.sqrt((o1.x-o2.x)^2+(o1.y-o2.y)^2)
	end

	---------------------------------------------------------------------------------------------------------
	-- calculate angle between o1 and o2 (Object1 and Object2)
	---------------------------------------------------------------------------------------------------------
	function angleBetween ( srcObj, dstObj )
		--We need to offset the string X position by 1 pixel if it's the same as the biscuit x position
		if (srcObj.x == dstObj.x) then srcObj.x=srcObj.x+1 end
		local xDist = dstObj.x-srcObj.x ; local yDist = dstObj.y-srcObj.y
		local angleBetween = math.deg( math.atan( yDist/xDist ) )
		if ( srcObj.x < dstObj.x ) then angleBetween = angleBetween+90 else angleBetween = angleBetween-90 end
		return angleBetween - 90
	end

	---------------------------------------------------------------------------------------------------------
	-- Calculate the length, distance and angle of ropes to connect to Biscuit
	---------------------------------------------------------------------------------------------------------
	-- Draw DEBUG ploy points for the rope: change alpha to 0.7 to view
	---------------------------------------------------------------------------------------------------------
	local c1 = display.newCircle(params.nubX, params.nubY,10);
	c1:setFillColor(255,0,0); c1.alpha=0.0
 
	local c3 = display.newCircle(params.targetX, params.targetY,10);
	c3:setFillColor(255,0,0); c3.alpha=0.0

	---------------------------------------------------------------------------------------------------------
	-- calculate HOW MANY rope joints to create for this rope
	---------------------------------------------------------------------------------------------------------
	local targetDistance = distance(c1,c3 )
	local getAngle_1to2 = angleBetween( c1, c3)
	mxRopesSet1 = math.ceil(  (targetDistance+params.extraLength) / (ropeWidth/1.24)   )

	---------------------------------------------------------------------------------------------------------
	-- Draw the BASE of the nub (Start Connector for the Rope)
	---------------------------------------------------------------------------------------------------------
	--local nubBase = display.newImageRect(myGlobalData.imagePath.."nubBase.png" ,21,21)
	local nubBase = display.newSprite( myGlobalData.imageSheet, myGlobalData.animationSequenceData )
	nubBase:setSequence( "nubBase" )
	nubBase:play()
	nubBase.x = params.nubX
	nubBase.y = params.nubY

	---------------------------------------------------------------------------------------------------------
	-- Add the CEILING and the BASE NUB to the [Rope] Group
	---------------------------------------------------------------------------------------------------------
	---------------------------------------------------------------------------------------------------------
	-- Add a 'ceiling' to lock our rope to
	---------------------------------------------------------------------------------------------------------
	--local ceiling = display.newRect( xCenter - wCeil*0.5, 0, wCeil, hCeil )
	local ceiling  = display.newRect (params.nubX, params.nubY, 2, 2)
	physics.addBody( ceiling, "static", { density=0, friction=10,bounce=0.2, isSensor=true } )
	local prevBody = ceiling

	rope:insert(ceiling)
	rope:insert(nubBase)

	---------------------------------------------------------------------------------------------------------
	-- Setup some extra variable data from parameters fed from function
	---------------------------------------------------------------------------------------------------------
	if(params.removeRope==false)then
		removeRope=false
	end

	if(params.density)then
		density=params.density
	end

	---------------------------------------------------------------------------------------------------------
	-- Handle touch
	---------------------------------------------------------------------------------------------------------
	local function handleTouch ( event )
		event.target:removeSelf()
		event.target.isFocus=true
	end

	---------------------------------------------------------------------------------------------------------
	-- Clear out the Rope data
	---------------------------------------------------------------------------------------------------------
	local function killClearTheRopeBody(event)
		local RopeBody = event.source.RopeBody
		if ( myGlobalData.levelFailed == false and myGlobalData.sweetSmashed==false and RopeBody.isAlive == false) then
			if(RopeBody) then
				display.remove(RopeBody)
				RopeBody=nil
			end
		end
	end

	---------------------------------------------------------------------------------------------------------
	-- Clear the ropes from a remote call (external to this module)
	---------------------------------------------------------------------------------------------------------
	function rope:ropeClearAll()
		for x = 1, numberOfLinks do
			if(arrayJoints[x] and array[x].isAlive == true)then
				array[x].isAlive = false
				array[x]:setFillColor( 255,255,255 ) --white
				display.remove(arrayJoints[x])
				arrayJoints[x]=nil
				--transition.to(array[x], {time=350, alpha=0, onComplete=finishTransition})
			
				local delayAction = transition.to(array[x], {time=350, alpha=0})
				local delayAction = timer.performWithDelay( 355, killClearTheRopeBody )
				delayAction.RopeBody = array[x]
			end
		end
	end


	---------------------------------------------------------------------------------------------------------
	-- Define further variables for the rope function
	---------------------------------------------------------------------------------------------------------
	local w,h 			= ropeWidth,ropeWidth
	local halfW,halfH 	= 0.5*w,0.5*h

	---------------------------------------------------------------------------------------------------------
	-- setup the x,y center of body
	---------------------------------------------------------------------------------------------------------
	local y 			= params.nubY
	local x 			= params.nubX
	
	---------------------------------------------------------------------------------------------------------
	-- setup Joint and rope positions/count
	---------------------------------------------------------------------------------------------------------
	local xJoint 		= x
	local yJoint 		= y
	--local body 			= params.body
	local ropeCount 	= 0

	---------------------------------------------------------------------------------------------------------
	-- set the JOINTS counter to 1
	---------------------------------------------------------------------------------------------------------
	joints				= 1

	---------------------------------------------------------------------------------------------------------
	-- Create the ROPES [Section 1]
	---------------------------------------------------------------------------------------------------------

	---------------------------------------------------------------------------------------------------------
	-- Loop through, creating the desired number of rope connectors dynamically. Based on distance to biscuit
	---------------------------------------------------------------------------------------------------------
	while ropeCount < mxRopesSet1 do
 
		local body = display.newImageRect(myGlobalData.imagePath.."rope_20x10.png", 22,10)
		body.isAlive = true
		
		---------------------------------------------------------------------------------------------------------
		-- Rope colour. Note we use a MOD function to find the ODD/EVEN rope points to create the stripe effect
		---------------------------------------------------------------------------------------------------------
		local colourFactor = (ropeCount*3)
		--Apply alternating colour to rope links
		if ropeCount % 2 == 0 then
			body:setFillColor( 0.87,0.79,0.27 ) --even (Yellow)
			--body:setFillColor( 0.37,0.16,0.22 ) --even (drk brown)
		else
			body:setFillColor( 0.51,0.28,0.1 ) --odd (light brown)
		end        
	
	
		---------------------------------------------------------------------------------------------------------
		-- Draw the ROPE at the correct target ANGLE to the biscuit, and keep adding new points along this angle
		---------------------------------------------------------------------------------------------------------
		local targetAngle = getAngle_1to2 * PIE / 180
		local cosGet = math.cos(targetAngle)
		local sinGet = math.sin(targetAngle)
		
		local tempX = x + (w-4) * cosGet
		local tempY = y + (h-4) * sinGet
	
		xJoint1 = x + (  (w-(ropeWidth/2)) * cosGet  )	
		yJoint1 = y + (  (h-(ropeWidth/2)) * sinGet  )

		xJoint2 = x + (  (w+5) * cosGet  )	
		yJoint2 = y + (  (h+5) * sinGet  )

		body.x = tempX
		body.y = tempY
	
		x = body.x
		y = body.y
	
		---------------------------------------------------------------------------------------------------------
		-- We can fine tune the rope angle here if required.
		---------------------------------------------------------------------------------------------------------
		if ( ropeCount == (mxRopesSet1-1)) then
			--body.rotation = (getAngle_1to2-90) - (angleDiff/2)
			body.rotation = (getAngle_1to2-90)
		else
			body.rotation = (getAngle_1to2-90)
		end
	
		---------------------------------------------------------------------------------------------------------
		-- Assign some EXTRA meta data to the ROPE BODY. Used for detecting a SLASH etc
		---------------------------------------------------------------------------------------------------------
		body.objectType = "Rope"
		body.objectHit = false
	
		local isSensor=false
		if(params.isSensor)  then
			isSensor = params.isSensor
		end
		
		---------------------------------------------------------------------------------------------------------
		-- Add a physics body to the ROPE colour/image block.
		-- NOTE: This body has the gravity and physics world data on it
		---------------------------------------------------------------------------------------------------------
		--{-Width,-Height,Width,-Height,Width,Height,-Width,Height}
		local ropeShapeArea = {-2,-5,2,-5,2,5,-2,5}
		
		physics.addBody( body, { density=params.density, friction=22220.0, bounce = 120.0, isSensor=true, shape = ropeShapeArea })
		local joint = physics.newJoint( "pivot", prevBody, body, xJoint1, yJoint1 )

		joint.frequency		= 1
		joint.dampingRatio	= 1
		
		--joint.isLimitEnabled = true
		--joint:setRotationLimits( -180, 180 )
		
		joint.isCollideConnected = false
		
		---------------------------------------------------------------------------------------------------------
		-- Add the newly create ROPE (and all its meta data) to a trackable array{}
		---------------------------------------------------------------------------------------------------------
		arrayJoints[joints]	= joint
		array[joints]		= body
		
		--rope:insert(joint)

		---------------------------------------------------------------------------------------------------------
		-- Set the [prevBody] variable to the LAST body created: to link the NEXT rope to it...
		---------------------------------------------------------------------------------------------------------
		prevBody			= body
		
		---------------------------------------------------------------------------------------------------------
		-- Increment the Counter for our WHILE loop
		---------------------------------------------------------------------------------------------------------
		joints		= joints	+ 1
		ropeCount	= ropeCount	+ 1
		
		--rope:insert(body)
		rope:insert(prevBody)
		
	end
	-- End the ROPE creator WHILE loop


	---------------------------------------------------------------------------------------------------------
	-- JOIN THE LAST ROPE TO THE Biscuit
	---------------------------------------------------------------------------------------------------------
	joints			= joints - 1
	numberOfLinks	= ropeCount
	
	local body =  params.body
	--local joint = physics.newJoint( "pivot", prevBody, body, body.x-10, yJoint+10 )
	local joint = physics.newJoint( "pivot", prevBody, body, body.x, body.y-1 )
	joints=joints+1
	joint.frequency = 50
	joint.dampingRatio=1
	
	rope:insert(body)
		
	---------------------------------------------------------------------------------------------------------
	-- Add the TOP of the nub. A visual graphic
	---------------------------------------------------------------------------------------------------------
	--local nubTop = display.newImageRect(myGlobalData.imagePath.."nubTop.png" ,21,21)
	local nubTop = display.newSprite( myGlobalData.imageSheet, myGlobalData.animationSequenceData )
	nubTop:setSequence( "nubTop" )
	nubTop:play()
	nubTop.x = params.nubX
	nubTop.y = params.nubY
	rope:insert(nubTop)

	--print("ROPE, Joints created: "..joints)
		
	---------------------------------------------------------------------------------------------------------
	-- Finish: Return the Rope (a Group Display object)
	---------------------------------------------------------------------------------------------------------
	return rope
end