module(..., package.seeall)

---------------------------------------------------------------------------------------------------------
-- Collect any global Variables for use in this module
---------------------------------------------------------------------------------------------------------
local myGlobalData 		= require( "globalData" )

---------------------------------------------------------------------------------------------------------
-- Function to create the BOUNDARY WALLS around our game area
---------------------------------------------------------------------------------------------------------
function newBackdrop(params)

	---------------------------------------------------------------------------------------------------------
	-- Local variables for this module
	---------------------------------------------------------------------------------------------------------
	local wallGroup 	= display.newGroup()
	local depth 		= 20
	local debugAlpha 	= 0.7
	local visualOffsetY = 60
	local visualOffsetX = 500
	local fullLength 	= 5000 
	
	---------------------------------------------------------------------------------------------------------
	-- We need to make the HIT BOX for each wall very long, to account for the X,Y offsets...
	---------------------------------------------------------------------------------------------------------
	
	---------------------------------------------------------------------------------------------------------
	-- Setup the Walls around the game.
	---------------------------------------------------------------------------------------------------------
	--TOP
	---------------------------------------------------------------------------------------------------------
	local worldWall = display.newRect( 0, 0, fullLength, depth )
	--worldWall:setReferencePoint( display.CenterReferencePoint )
	worldWall.anchorX = 0.5		-- Graphics 2.0 Anchoring method
	worldWall.anchorY = 0.5		-- Graphics 2.0 Anchoring method
	worldWall.x = myGlobalData._w/2
	worldWall.y = 0 - visualOffsetY
	worldWall.objectType = "Wall"
	worldWall.alpha = debugAlpha
	physics.addBody( worldWall, "static" )
	worldWall.isSensor = true
	wallGroup:insert( worldWall )

	---------------------------------------------------------------------------------------------------------
	--BOTTOM
	---------------------------------------------------------------------------------------------------------
	local worldWall = display.newRect( 0, 0, fullLength, depth )
	--worldWall:setReferencePoint( display.CenterReferencePoint )
	worldWall.anchorX = 0.5		-- Graphics 2.0 Anchoring method
	worldWall.anchorY = 0.5		-- Graphics 2.0 Anchoring method
	worldWall.x = myGlobalData._w/2
	worldWall.y = myGlobalData.levelSizeH + visualOffsetY
	worldWall.objectType = "Wall"
	worldWall.alpha = debugAlpha
	physics.addBody( worldWall, "static" )
	worldWall.isSensor = true
	wallGroup:insert( worldWall )

	---------------------------------------------------------------------------------------------------------
	--LEFT
	---------------------------------------------------------------------------------------------------------
	local worldWall = display.newRect( 0, 0, depth, fullLength )
	--worldWall:setReferencePoint( display.CenterReferencePoint )
	worldWall.anchorX = 0.5		-- Graphics 2.0 Anchoring method
	worldWall.anchorY = 0.5		-- Graphics 2.0 Anchoring method
	worldWall.x = 0 - visualOffsetX
	worldWall.y = myGlobalData.levelSizeH/2
	worldWall.objectType = "Wall"
	worldWall.alpha = debugAlpha
	physics.addBody( worldWall, "static" )
	worldWall.isSensor = true
	wallGroup:insert( worldWall )

	---------------------------------------------------------------------------------------------------------
	--RIGHT
	---------------------------------------------------------------------------------------------------------
	local worldWall = display.newRect( 0, 0, depth, fullLength )
	--worldWall:setReferencePoint( display.CenterReferencePoint )
	worldWall.anchorX = 0.5		-- Graphics 2.0 Anchoring method
	worldWall.anchorY = 0.5		-- Graphics 2.0 Anchoring method
	worldWall.x = myGlobalData._w + visualOffsetX
	worldWall.y = myGlobalData.levelSizeH/2
	worldWall.objectType = "Wall"
	worldWall.alpha = debugAlpha
	physics.addBody( worldWall, "static" )
	worldWall.isSensor = true
	wallGroup:insert( worldWall )

    return wallGroup
    
    
end

