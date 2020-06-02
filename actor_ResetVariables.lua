local resetVariables = {}

	---------------------------------------------------------------------------------------------------------
	-- Collect any global Variables for use in this module
	---------------------------------------------------------------------------------------------------------
	local myGlobalData 		= require( "globalData" )

	---------------------------------------------------------------------------------------------------------
	-- All of our LEVEL controlled variables are here, to manage a reset.
	-- Additionally this code (FUNCTION) is called at other intervals too.
	---------------------------------------------------------------------------------------------------------
	resetVariables.VariableReset = function()
	
		myGlobalData.starsCollected 	= 0
		
		myGlobalData.levelFailed		= false	
		myGlobalData.levelReset			= false
		myGlobalData.levelCompleted		= false
	
		myGlobalData.sweetSmashed		= false
		myGlobalData.sweetInGoal 		= false
		myGlobalData.sweetInBubble 		= false
	
		myGlobalData.spikeHit 			= false
	
		myGlobalData.heroIsSad 			= false
		myGlobalData.starCollected 		= false	

		myGlobalData.endGame			= false
	end


return resetVariables
