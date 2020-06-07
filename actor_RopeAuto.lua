module(..., package.seeall)

---------------------------------------------------------------------------------------------------------
-- Collect any global Variables for use in this module
---------------------------------------------------------------------------------------------------------
local myGlobalData 		= require( "globalData" )

---------------------------------------------------------------------------------------------------------
-- Function to create the Auto Ropes
---------------------------------------------------------------------------------------------------------
function newRopeAuto(params)

	---------------------------------------------------------------------------------------------------------
	-- Local variables for this module
	---------------------------------------------------------------------------------------------------------
	local PIE 				= 3.14159265358
	local mxropeAutosSet1 	= 0
	local mxropeAutosSet2 	= 0
	local ropeAutoWidth 	= 13
	local ropeAutoHeight 	= 40
	local angleDiff 		= 0
	local isConnected 		= false
	local usedConnector 	= false
	local y 				= params.y
	local wCeil 			= 10
	local hCeil 			= 0
	local joints 			= 1
	local array 			= {}
	local arrayJoints 		= {}
	local cut 				= false
	local removeropeAuto 	= true	
	local isRopeCut			= false
	local cutPosition 		= 0
	local numberOfLinks 	= 0
	local isBeingCut 		= false
	local removeRope 		= true
	local ropeAuto 			= display.newGroup()
	local ropePerimeter 	= display.newGroup()
    local xCenter 			= params.nubX

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
		--We need to offset the string X position by 1 pixel if it's the same as the sweets x position
		if (srcObj.x == dstObj.x) then srcObj.x=srcObj.x+1 end
		local xDist = dstObj.x-srcObj.x ; local yDist = dstObj.y-srcObj.y
		local angleBetween = math.deg( math.atan( yDist/xDist ) )
		if ( srcObj.x < dstObj.x ) then angleBetween = angleBetween+90 else angleBetween = angleBetween-90 end
		return angleBetween - 90
	end


	---------------------------------------------------------------------------------------------------------
	-- Draw the perimeter visual
	---------------------------------------------------------------------------------------------------------
	function magicTrigFunctionX(pointRatio)
		return math.cos(pointRatio*2*PIE)
	end
	
	function magicTrigFunctionY (pointRatio)
		return math.sin(pointRatio*2*PIE)
	end

	---------------------------------------------------------------------------------------------------------
	--Draw a semi transparent are to show the 'area' for an auto rope
	---------------------------------------------------------------------------------------------------------
	local areaCircle = display.newCircle(params.nubX,params.nubY,params.perimeter)
	areaCircle:setFillColor(0.78,0.78,0.94) --Light Blue1
	areaCircle.alpha = 0.15
	ropePerimeter:insert(areaCircle)

	---------------------------------------------------------------------------------------------------------
	-- We need to draw our own circle so we can create a DOTTED effect
	---------------------------------------------------------------------------------------------------------
	function drawCircle(centerX, centerY, radius, sides)
		for i=0, sides do
			local pointRatio = i/sides
			local xSteps = magicTrigFunctionX(pointRatio)
			local ySteps = magicTrigFunctionY(pointRatio)
			local pointX = centerX + xSteps * radius
			local pointY = centerY + ySteps * radius
			myLine = display.newRect(pointX, pointY, 1,1)
			myLine:setFillColor(0.78,0.78,0.94) --Light Blue1
			--myLine:setFillColor(58,80,96) --Light Blue2
			ropePerimeter:insert(myLine)
			i=i+1
		end
	end

	---------------------------------------------------------------------------------------------------------
	-- Call the DRAW DOTTED CIRCLE functions
	---------------------------------------------------------------------------------------------------------
	drawCircle(params.nubX,params.nubY, params.perimeter, (params.perimeter/1.0));
	ropeAuto:insert(ropePerimeter)
			
	---------------------------------------------------------------------------------------------------------
	-- Draw the BASE of the nub (Start Connector for the Rope)
	---------------------------------------------------------------------------------------------------------
	--local nubBase = display.newImageRect(myGlobalData.imagePath.."nubBaseAuto.png" ,21,21)
	local nubBase = display.newSprite( myGlobalData.imageSheet, myGlobalData.animationSequenceData )
	nubBase:setSequence( "nubBaseAuto" )
	nubBase:play()
    physics.addBody( nubBase,"static", { density=0.1, friction=0.1, bounce = 0.0, isSensor=true, radius=params.perimeter })
	nubBase.x = params.nubX
	nubBase.y = params.nubY
	nubBase.isFixedRotation = true
    nubBase.objectType="autoPerimeter"
	ropeAuto:insert(nubBase)
		
	---------------------------------------------------------------------------------------------------------
	-- handle the touch
	---------------------------------------------------------------------------------------------------------
	local function handleTouch ( event )
		event.target:removeSelf()
		event.target.isFocus=true
	end

	---------------------------------------------------------------------------------------------------------
	-- clear the ropes function
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
	-- function to remove the ROPES from the main game layer
	---------------------------------------------------------------------------------------------------------
	function ropeAuto:ropeClearAll()
		for x = 1, numberOfLinks do
			if(arrayJoints[x] and array[x].isAlive == true)then
				array[x].isAlive = false
				array[x]:setFillColor( 1,1,1 ) --white
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
	-- create the ropes connected together
	---------------------------------------------------------------------------------------------------------
	local function connectTheRope(event)
	---------------------------------------------------------------------------------------------------------
	--Play a connect sfx
	---------------------------------------------------------------------------------------------------------
	audio.play(Sfx_Hit)
	
		local nubBodyArea = event.source.theNubBody
		local sweetBody = event.source.sweetBody
		
		isConnected = true

		local function connectTheRopeAction(getNubBody, getSweetBody, sweetX, sweetY, sweetAngle, sweetDistance, jointCount)
			local theNubBody = getNubBody
			local body = getSweetBody
			
			---------------------------------------------------------------------------------------------------------
			--draw LINE Points [Note for debugging turn the ALPHA to 0.8]
			---------------------------------------------------------------------------------------------------------
			local c1 = display.newCircle(theNubBody.x, theNubBody.y,10);
			c1:setFillColor(1,0,0); c1.alpha=0.0

			local c3 = display.newCircle(getSweetBody.x, getSweetBody.y,10);
			c3:setFillColor(1,0,0); c3.alpha=0.0

			local targetDistance = distance(c1,c3 )
			local getAngle_1to2 = angleBetween( c1, c3)
			mxropeAutosSet1 = math.ceil(  (targetDistance+params.extraLength) / (ropeAutoWidth/1.24)   )

			local sweetX = body.x
			local sweetY = body.y

			if(params.removeropeAuto==false)then
				removeropeAuto=false
			end

			local density=5
			if(params.density)then
				density=params.density
			end

			local ceiling   = display.newRect (theNubBody.x, theNubBody.y, 2, 2)
			physics.addBody( ceiling, "static", { density=0, friction=10,bounce=0.2, isSensor=true } )
			ropeAuto:insert(ceiling)

			local prevBody = ceiling
			local w,h = ropeAutoWidth,ropeAutoWidth
			local halfW,halfH = 0.5*w,0.5*h

			-- center of body
			local y = theNubBody.y
			local x = theNubBody.x

			local xJoint = x
			local yJoint = y
			local xJoint1 = x
			local yJoint1 = y
			local xJoint2 = x
			local yJoint2 = y

			local ropeAutoCount = 0

			joints=1

			---------------------------------------------------------------------------------------------------------
			--ropeAuto SECTION 1
			---------------------------------------------------------------------------------------------------------
			while ropeAutoCount < mxropeAutosSet1 do

				if (myGlobalData.levelFailed == false) then

					local body = display.newImageRect(myGlobalData.imagePath.."rope_20x10.png", 22,10)
					body.isAlive = true
				
					local colourFactor = (ropeAutoCount*3)
					--Apply alternating colour to ropeAuto links
				
					if ropeAutoCount % 2 == 0 then
						body:setFillColor( 0.87,0.79,0.27 ) --even (Yellow)
						--body:setFillColor( 0.37,0.16,0.22 ) --even (drk brown)
					else
						body:setFillColor( 0.51,0.28,0.1 ) --odd (light brown)
					end        
				
				
				

					local targetAngle = getAngle_1to2 * PIE / 180
					local tempX = x + (w-4) * math.cos(targetAngle)	
					local tempY = y + (h-4) * math.sin(targetAngle)

					xJoint1 = x + (  (w-(ropeAutoWidth/2)) * math.cos(targetAngle)  )	
					yJoint1 = y + (  (h-(ropeAutoWidth/2)) * math.sin(targetAngle)  )

					xJoint2 = x + (  (w+5) * math.cos(targetAngle)  )	
					yJoint2 = y + (  (h+5) * math.sin(targetAngle)  )

					body.x = tempX
					body.y = tempY

					x = body.x
					y = body.y

					if ( ropeAutoCount == (mxropeAutosSet1-1)) then
						--body.rotation = (getAngle_1to2-90) - (angleDiff/2)
						body.rotation = (getAngle_1to2-90)
					else
						body.rotation = (getAngle_1to2-90)
					end
				
					body.objectType = "Rope"
					body.objectHit = false

					ropeAuto:insert(body)

					local isSensor=false
					if(params.isSensor)  then
						isSensor = params.isSensor
					end
					
					--{-Width,-Height,Width,-Height,Width,Height,-Width,Height}
					local ropeShapeArea = {-2,-5,2,-5,2,5,-2,5}
		
					physics.addBody( body, { density=params.density, friction=2222.1, bounce = 0.0, isSensor=true, shape = ropeShapeArea })
					local joint = physics.newJoint( "pivot", prevBody, body, xJoint1, yJoint1 )

					joint.frequency = 1
					joint.dampingRatio = 1
					--joint.isLimitEnabled = true
					--joint:setRotationLimits( -70, 70 )
					
					arrayJoints[joints]=joint

					array[joints]=body
					prevBody = body
					joints=joints+1
					ropeAutoCount=ropeAutoCount+1
			
				end
			end


			---------------------------------------------------------------------------------------------------------
			--JOIN THE LAST ropeAuto TO THE SWEET (Biscuit)
			---------------------------------------------------------------------------------------------------------
			joints=joints-1
			numberOfLinks = ropeAutoCount
			local body =  getSweetBody
			body.x = prevBody.x
			body.y = prevBody.y

			--local joint = physics.newJoint( "pivot", prevBody, body, body.x-10, yJoint+10 )
			local joint = physics.newJoint( "pivot", prevBody, body, body.x, body.y )
			joint.frequency = 50
			joint.dampingRatio=1
		
			body.x = sweetX
			body.y = sweetY
		
			---------------------------------------------------------------------------------------------------------
			--Add the TOP of the nub!
			---------------------------------------------------------------------------------------------------------
			--local nubTop = display.newImageRect(myGlobalData.imagePath.."nubTop.png" ,21,21)
			local nubTop = display.newSprite( myGlobalData.imageSheet, myGlobalData.animationSequenceData )
			nubTop:setSequence( "nubTop" )
			nubTop:play()
			nubTop.x = params.nubX
			nubTop.y = params.nubY
			ropeAuto:insert(nubTop)
		
		end
	
        	if ( myGlobalData.levelFailed == false and myGlobalData.sweetSmashed==false) then

				local c1 = display.newCircle(nubBodyArea.x, nubBodyArea.y,10);
				c1:setFillColor(1,0,0); c1.alpha=0.0
				local c3 = display.newCircle(sweetBody.x, sweetBody.y,10);
				c3:setFillColor(1,0,0); c3.alpha=0.0
				local getAngle_1to2 = angleBetween( c1, c3)

				connectTheRopeAction(nubBodyArea, sweetBody, sweetBody.x,sweetBody.y,getAngle_1to2-1,5, sweetBody.x, sweetBody.y, 1)
			end
		
	end
	
	---------------------------------------------------------------------------------------------------------
	-- Handle the collision events between the PERIMETER circle and the biscuit
	---------------------------------------------------------------------------------------------------------
    local function onCollisionSweet( self, event )
        if ( event.phase == "began" ) then
        
			---------------------------------------------------------------------------------------------------------
        	--Check if the Connector AREA and the sweet have touched
			---------------------------------------------------------------------------------------------------------
        	if (event.other.objectType == "Sweet" and isConnected==false and usedConnector==false) then
				
				---------------------------------------------------------------------------------------------------------
				--Hide the Rope perimeter circle...
				---------------------------------------------------------------------------------------------------------
				ropePerimeter.alpha=0.0
								
				if (myGlobalData.levelFailed == false) then
					local delayAction = timer.performWithDelay( 50, connectTheRope )
					delayAction.theNubBody = nubBase
					delayAction.sweetBody = event.other
				end

        	end
        	
        end
        
        if ( event.phase == "ended" ) then
            --timer.performWithDelay(10000, resetSound, 1)
            --event.other.collisionStart=false
        end
    end

	---------------------------------------------------------------------------------------------------------
	--Add a collision event listener to the PERIMETER area....
	---------------------------------------------------------------------------------------------------------
    nubBase.collision = onCollisionSweet
    nubBase:addEventListener( "collision", nubBase )

    return ropeAuto
    
end

