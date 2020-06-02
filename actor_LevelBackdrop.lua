module(..., package.seeall)

---------------------------------------------------------------------------------------------------------
-- Collect any global Variables for use in this module
---------------------------------------------------------------------------------------------------------
local myGlobalData 		= require( "globalData" )

---------------------------------------------------------------------------------------------------------
-- Function to create the Backdrop for each level
---------------------------------------------------------------------------------------------------------
function newBackdrop(params)
	
	local backdropGroup = display.newGroup()

	-------------------------------------------------------------------------------------------------------------
	--Draw the background image as a SOLID SQUARE (RECT) Display object
	-------------------------------------------------------------------------------------------------------------
	local colouredSquare = display.newRect(0,0,myGlobalData._w,myGlobalData._h)
	colouredSquare.anchorX = 0.0		-- Graphics 2.0 Anchoring method
	colouredSquare.anchorY = 0.0		-- Graphics 2.0 Anchoring method
	
	-------------------------------------------------------------------------------------------------------------
	--Set the BG colour different for EACH WORLD
	--You could load in a different IMAGE for each world etc..
	-------------------------------------------------------------------------------------------------------------
	if( myGlobalData.worldSelected == 1 ) then
		colouredSquare:setFillColor(0.39,0.22,0.65)--purple
	elseif( myGlobalData.worldSelected == 2 ) then
		colouredSquare:setFillColor(0.05,0.65,0.25)--green
	elseif( myGlobalData.worldSelected == 3 ) then
		colouredSquare:setFillColor(0.15,0.26,0.62)--blue
	elseif( myGlobalData.worldSelected == 4 ) then
		colouredSquare:setFillColor(0.83,0.7,0.21)--Drk Yellow
	end
	
	-------------------------------------------------------------------------------------------------------------
	--Insert the COLOURED backdrop into the main group
	-------------------------------------------------------------------------------------------------------------
	backdropGroup:insert( colouredSquare )
	
	-------------------------------------------------------------------------------------------------------------
	--Add a semi-transparent GREYSCALE image over the top of the coloured square.
	-------------------------------------------------------------------------------------------------------------
	local bgImageVisual = display.newImageRect( myGlobalData.imagePath.."Background_Overlay.png", 384,569 )
	bgImageVisual.anchorX = 0.5		-- Graphics 2.0 Anchoring method
	bgImageVisual.anchorY = 0.5		-- Graphics 2.0 Anchoring method
	bgImageVisual.x = myGlobalData._w/2
	bgImageVisual.y = myGlobalData._h/2
	backdropGroup:insert( bgImageVisual )
	bgImageVisual.alpha = 1.0

	------------------------------------------------------------------------------------------------------------------------------------
	-- add extra floor data if on iPhone 5
	------------------------------------------------------------------------------------------------------------------------------------
	if ( myGlobalData.iPhone5 == true or myGlobalData.iPad	== true) then
		local floor = display.newImageRect( myGlobalData.imagePath.."floor.png", 543,179 )
		--floor:setReferencePoint(display.CenterLeftReferencePoint)
		floor.x = myGlobalData._w/2; floor.y = 520;
		backdropGroup:insert(floor)
	end


	-------------------------------------------------------------------------------------------------------------
	--To add an image dynamically based on the selected level, update the code below.
	-------------------------------------------------------------------------------------------------------------
	--[[
	--Main bg image
	-- This code will load a DIFFERENT image for each world backdrop
	local bgImage = display.newImageRect(myGlobalData.imagePath.."worldBackdrop"..myGlobalData.worldSelected..".png" ,myGlobalData._w,myGlobalData._h)
    bgImage:setReferencePoint( display.TopLeftReferencePoint )
	bgImage.x = 0--myGlobalData._w/2
	bgImage.y = 0--myGlobalData._h/2
	backdropGroup:insert(bgImage)
	--]]
	
	-------------------------------------------------------------------------------------------------------------
	--Temp Debug grid overlay.
	--Shown if the MAIN.lua showDebugGrid variable is set to true
	--Was used to help position display objects
	-------------------------------------------------------------------------------------------------------------
	if (myGlobalData.showDebugGrid == true)then
		local bgImageVisual = display.newImageRect( myGlobalData.imagePath.."iPhone_grid_PortraitINV.png", 320,480 )
		--bgImageVisual:setReferencePoint( display.TopLeftReferencePoint )
		bgImageVisual.anchorX = 0.5		-- Graphics 2.0 Anchoring method
		bgImageVisual.anchorY = 0.5		-- Graphics 2.0 Anchoring method
		bgImageVisual.x = 0--myGlobalData._w/2
		bgImageVisual.y = 0--myGlobalData._h/2
		backdropGroup:insert( bgImageVisual )
		bgImageVisual.alpha = 0.35
	end

    return backdropGroup
end

