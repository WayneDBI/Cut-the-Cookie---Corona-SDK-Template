------------------------------------------------------------------------------------------------------------------------------------
-- CUT THE COOKIE Corona SDK Template
------------------------------------------------------------------------------------------------------------------------------------
-- Developed by Deep Blue Ideas.com [www.deepbueideas.com]
------------------------------------------------------------------------------------------------------------------------------------
-- Abstract: Get the cookie to the Chef hero. Along the way try and collect as many stars as possible.
-- Avoid any obstacles such as spikes. The Cookie is connect by a series of ropes on the
-- screen, which the user mush cut to get the cookie to the desired location.
------------------------------------------------------------------------------------------------------------------------------------
-- Release Version 2
-- Code developed for CORONA SDK STABLE RELEASE 2018.3326
-- 23rd December 2018
------------------------------------------------------------------------------------------------------------------------------------
-- main.lua
------------------------------------------------------------------------------------------------------------------------------------

display.setStatusBar( display.HiddenStatusBar )
local storyboard    = require "storyboard"

-- require controller module
local composer      = require( "composer" )
local physics 			= require( "physics" )
local myGlobalData 	= require( "globalData" )
local loadsave 			= require("loadsave") -- Require our external Load/Save module

_G.sprite = require "sprite"							-- Add SPRITE API for Graphics 1.0

scaleFactor = 0.5

myGlobalData._w 					= display.contentWidth  		-- Get the devices Width
myGlobalData._h 					= display.contentHeight 		-- Get the devices Height

myGlobalData.levelSizeW 			= display.contentHeight 		-- the screen / BOUNDRY SIZE for each level
myGlobalData.levelSizeH 			= display.contentHeight 		-- the screen / BOUNDRY SIZE for each level

myGlobalData.imagePath				= "_Assets/Images/"
myGlobalData.audioPath				= "_Assets/Audio/"
myGlobalData.worldPath				= "_Assets.Worlds."
myGlobalData.level					= 1								-- Global Level Select, Clean, Load, etc...
myGlobalData.myLevel				= 1								-- starting level
myGlobalData.worldSelected			= 1								-- Which world has the user chosen?

myGlobalData.maxLevels				= 25							-- How many levels do EACH world have?
myGlobalData.maxWorlds				= 4								-- How many worlds for the WHOLE game?

myGlobalData.levelReset				= false							-- We use this flag to help reset the level..
myGlobalData.levelCompleted		= false							-- We use this flag to indicate the user has completed the level..
myGlobalData.levelFailed			= false							-- We use this flag to indicate the user has failed a level..
myGlobalData.levelPaused			= false							-- has the user paused the level/game?..

myGlobalData.endGame				= false							-- is the game at an end?

myGlobalData.starsCollected			= 0								-- How many stars has the user collected on the level?								
myGlobalData.starsOnLevel			= 3								-- How many stars on the level?
myGlobalData.starBonusValue			= 100							-- Bonus value for EACH star collected
myGlobalData.bonusTime				= 2								-- Bonus for each second
myGlobalData.totalStarsCollected	= 0								-- Total of ALL stars collected

myGlobalData.heroIsSad				= false							-- used for our heros animation states

myGlobalData.bonusValue				= 10							-- How much are each BONUS items worth in game?
myGlobalData.showTutorial			= false							-- Does the level need to show a TUTORIAL?
myGlobalData.iPhone5				= false							-- Which device	

myGlobalData.volumeSFX				= 0.7							-- Define the SFX Volume
myGlobalData.volumeMusic			= 0.5							-- Define the Music Volume
myGlobalData.resetVolumeSFX			= myGlobalData.volumeSFX		-- Define the SFX Volume Reset Value
myGlobalData.resetVolumeMusic		= myGlobalData.volumeMusic		-- Define the Music Volume Reset Value
myGlobalData.soundON				= true							-- Is the sound ON or Off?
myGlobalData.musicON				= true							-- Is the sound ON or Off?

myGlobalData.factorX				= 0.4166	--2.400
myGlobalData.factorY				= 0.46875	--2.133

myGlobalData.sweetInBubble 			= false
myGlobalData.sweetSmashed 			= false
myGlobalData.sweetInGoal 			= false						-- Have we won?

myGlobalData.spikeHit				= false

-- Enable debug by setting to [true] to see FPS and Memory usage.
local doDebug 						= false						-- show the Memory and FPS box?
myGlobalData.showDebugGrid			= false						-- Show a grid to help positioning...

_G.saveDataTable		= {}							-- Define the Save/Load base Table to hold our data

composer.recycleOnSceneChange = false

-- Load in the saved data to our game table
-- check the files exists before !
if loadsave.fileExists("dbi_ctr_template_data.json", system.DocumentsDirectory) then
	saveDataTable = loadsave.loadTable("dbi_ctr_template_data.json")
else
	saveDataTable.levelReached 			= 1
	saveDataTable.worldReached 			= 1
	saveDataTable.gameCompleted 		= false
	saveDataTable.highScore 			= 0
	saveDataTable.totalStarsCollected 	= 0
	
	---------------------------------------------------------------------------------------------------
	--Setup the WORLD and LEVELS stats: 0=Access, (1, 2 & 3) = Number of stars, 4=locked (No access)
	---------------------------------------------------------------------------------------------------
	-- statsSetup[world][level] : Info: [world] = THE WORLD, [level] = THE LEVEL
	---------------------------------------------------------------------------------------------------
	local statsSetup = {}
	for world=1,myGlobalData.maxWorlds do
		statsSetup[world] = {4}
			for level=1,myGlobalData.maxLevels do
				statsSetup[world][level] = {4}
			end
	end
	
	statsSetup[1][1] = {0} -- We'll set LEVEL1, of each of the world, to accessible
	--statsSetup[2][1] = {0} -- We'll set LEVEL1, of each of the world, to accessible
	--statsSetup[3][1] = {0} -- We'll set LEVEL1, of each of the world, to accessible
	
	-- Pre populate Level 1 of each of the worlds with an ACCESSIBLE flag - so the user can play the 1st level!
	--for world=1,myGlobalData.maxWorlds do
	--	statsSetup[world][1] = {0} -- We'll set LEVEL1, of each of the world, to accessible
	--end
	
	-- Send our statsSetup table to the SAVE module
	saveDataTable.levelStats = statsSetup --Save the STARS collected details for world 1
	---------------------------------------------------------------------------------------------------
	
	-- Save the NEW json file, for referencing later..
	loadsave.saveTable(saveDataTable, "dbi_ctr_template_data.json")
end

--Now load in the Data
saveDataTable = loadsave.loadTable("dbi_ctr_template_data.json")

--Now assign the LOADED level to the Game Variable to control the levels the user can select.
myGlobalData.nextLevel				= saveDataTable.levelReached	-- Global The next available Level Select, Clean, Load, etc...
myGlobalData.allLevelsWon 			= saveDataTable.gameCompleted	-- Has the user completed EVERY level?
myGlobalData.highScore				= saveDataTable.highScore		-- Saved HighScore value
myGlobalData.gameScore				= 0								-- Set the Starting value of the score to ZERO ( 0 )
myGlobalData.resetScore				= 0								-- Used when a user RESETS a level, so we keep the correct score.
myGlobalData.totalStarsCollected	= saveDataTable.totalStarsCollected								-- Total of ALL stars collected

if system.getInfo("model") == "iPad" or system.getInfo("model") == "iPad Simulator" then
	myGlobalData.iPhone5	= false
	myGlobalData.iPad		= true
elseif display.pixelHeight > 960 then
	myGlobalData.iPhone5	= true
	myGlobalData.iPad		= false
end



-- Debug Data
if (doDebug) then
	local fps = require("fps")
	local performance = fps.PerformanceOutput.new();
	performance.group.x, performance.group.y = (display.contentWidth/2)-40,  380;
	performance.alpha = 0.3; -- So it doesn't get in the way of the rest of the scene
end


--Set the Music Volume
audio.setVolume( myGlobalData.volumeMusic, 	{ channel=0 } ) -- set the volume on channel 1
audio.setVolume( myGlobalData.volumeMusic, 	{ channel=1 } ) -- set the volume on channel 1
audio.setVolume( myGlobalData.volumeMusic, 	{ channel=2 } ) -- set the volume on channel 2
audio.setVolume( myGlobalData.volumeMusic, 	{ channel=3 } ) -- set the volume on channel 3

for i = 4, 32 do
	audio.setVolume( myGlobalData.volumeSFX, { channel=i } )
end 



function startGame()
	composer.gotoScene( "screenStart")	--This is our main menu
	--local buildPathToLevel = myGlobalData.worldPath.."World"..myGlobalData.worldSelected.."_Levels.level"..myGlobalData.myLevel
	--storyboard.gotoScene( buildPathToLevel )	--This is our main menu
end



------------------------------------------------------------------------------------------------------------------------------------
-- Preload Audio, music, sfx
------------------------------------------------------------------------------------------------------------------------------------
musicStart 				= audio.loadSound( myGlobalData.audioPath.."musicDBA001.mp3" )
musicGame				= audio.loadSound( myGlobalData.audioPath.."musicDBA002.mp3" )

sfx_Average				= audio.loadSound( myGlobalData.audioPath.."sfx_Average.mp3" )
sfx_BeenHereBefore		= audio.loadSound( myGlobalData.audioPath.."sfx_BeenHereBefore.mp3" )
sfx_Bomb				= audio.loadSound( myGlobalData.audioPath.."sfx_Bomb.mp3" )
sfx_Close				= audio.loadSound( myGlobalData.audioPath.."sfx_Close.mp3" )
sfx_Coin				= audio.loadSound( myGlobalData.audioPath.."sfx_Coin.mp3" )
sfx_CookieCut			= audio.loadSound( myGlobalData.audioPath.."sfx_CookieCut.mp3" )
sfx_CupOfTea			= audio.loadSound( myGlobalData.audioPath.."sfx_CupOfTea.mp3" )
sfx_Fail				= audio.loadSound( myGlobalData.audioPath.."sfx_Fail.mp3" )
sfx_FingerInTheWay		= audio.loadSound( myGlobalData.audioPath.."sfx_FingerInTheWay.mp3" )
sfx_GoingDown			= audio.loadSound( myGlobalData.audioPath.."sfx_GoingDown.mp3" )
sfx_GoingUp				= audio.loadSound( myGlobalData.audioPath.."sfx_GoingUp.mp3" )
sfx_Good				= audio.loadSound( myGlobalData.audioPath.."sfx_Good.mp3" )
sfx_Great				= audio.loadSound( myGlobalData.audioPath.."sfx_Great.mp3" )
sfx_LetsGo				= audio.loadSound( myGlobalData.audioPath.."sfx_LetsGo.mp3" )
sfx_NotBad				= audio.loadSound( myGlobalData.audioPath.."sfx_NotBad.mp3" )
sfx_Perfect				= audio.loadSound( myGlobalData.audioPath.."sfx_Perfect.mp3" )
sfx_Poor				= audio.loadSound( myGlobalData.audioPath.."sfx_Poor.mp3" )
sfx_Pop					= audio.loadSound( myGlobalData.audioPath.."sfx_Pop.mp3" )
sfx_PowerAid			= audio.loadSound( myGlobalData.audioPath.."sfx_PowerAid.mp3" )
sfx_Select				= audio.loadSound( myGlobalData.audioPath.."sfx_Select.mp3" )
sfx_Victory				= audio.loadSound( myGlobalData.audioPath.."sfx_Victory.mp3" )
Sfx_Hit					= audio.loadSound( myGlobalData.audioPath.."Sfx_Hit.mp3" )

------------------------------------------------------------------------------------------------------------------------------------
-- Preload SpriteSheets
------------------------------------------------------------------------------------------------------------------------------------
myGlobalData.sheetInfo = require("spriteSheet001")
myGlobalData.imageSheet = graphics.newImageSheet( myGlobalData.imagePath.."spriteSheet001.png", myGlobalData.sheetInfo:getSheet() )

--myGlobalData.sheetInfoHero = require("spriteSheetHero")
--myGlobalData.imageSheetHero = graphics.newImageSheet( myGlobalData.imagePath.."spriteSheetHero.png", myGlobalData.sheetInfoHero:getSheet() )

-----------------------------------------------------------------
-- Setup the various animation sequences used on the games scenes
-----------------------------------------------------------------
myGlobalData.animationSequenceData = {
  { name = "bubbleFixed", frames={ 68 }, time=700 },
  { name = "bubbleAnimate", frames={ 54,55,56,57,58,59,60,61,62,63,64,65,66,67 }, time=600 },
  { name = "bubblePop", frames={ 69,70,71,72,73,74,75,76,77 }, time=300, loopCount=1 },
  { name = "starAnimate", frames={ 88,89,90,91,92,93,94,95,96,97,98,99,100,101,102,103,104,105 }, time=700 },
  { name = "starCollect", frames={ 106,107,108,109,110,111,112,113,114,115,116,117,118 }, time=500, loopCount=1 },
  { name = "starGlow", frames={ 119 }, time=100, loopCount=1 },
  { name = "hudStarOn", frames={ 121 }, time=100, loopCount=1 },
  { name = "hudStarOff", frames={ 120 }, time=100, loopCount=1 },
  { name = "cookieBreak1", frames={ 122 }, time=100 },
  { name = "cookieBreak2", frames={ 123 }, time=100 },
  { name = "cookieBreak3", frames={ 124 }, time=100 },
  { name = "cookieBreak4", frames={ 125 }, time=100 },
  { name = "cookieBreak5", frames={ 126 }, time=100 },
  { name = "cookieMain", frames={ 127 }, time=100 },
  { name = "cookieShine", frames={ 128,129,130,131,132,133,134,135,136,137,127 }, time=400, loopCount=1 },
  --{ name = "blowBox", frames={ 75 }, time=400 },
  --{ name = "blowBoxAnimate", frames={ 75,76,77,78,79,80,79,78,77,76,75 }, time=400, loopCount=1 },
  --{ name = "blowBoxBits", frames={ 81 }, time=400 },
  { name = "spikes1", frames={ 21 }, time=400 },
  { name = "spikes2", frames={ 22 }, time=400 },
  { name = "spikes3", frames={ 23 }, time=400 },
  { name = "spikes4", frames={ 24 }, time=400 },
  { name = "starBigOff", frames={ 25 }, time=400 },
  { name = "starBigOn", frames={ 26 }, time=400 },
  { name = "buttonBackOff", frames={ 1 }, time=400 },
  { name = "buttonBackOn", frames={ 2 }, time=400 },
  { name = "buttonLongOff", frames={ 3 }, time=400 },
  { name = "buttonLongOn", frames={ 4 }, time=400 },
  { name = "buttonMediumOff", frames={ 5 }, time=400 },
  { name = "buttonMediumOn", frames={ 6 }, time=400 },
  { name = "buttonSmallOff", frames={ 7 }, time=400 },
  { name = "buttonSmallOn", frames={ 8 }, time=400 },
  { name = "buttonTinyOff", frames={ 9 }, time=400 },
  { name = "buttonTinyOn", frames={ 10 }, time=400 },
  { name = "iconCross", frames={ 11 }, time=400 },
  { name = "iconMusic", frames={ 12 }, time=400 },
  { name = "iconSFX", frames={ 13 }, time=400 },
  { name = "levelLocked", frames={ 14 }, time=400 },
  { name = "levelUnLocked", frames={ 19 }, time=400 },
  { name = "levelStars0", frames={ 15 }, time=400 },
  { name = "levelStars1", frames={ 16 }, time=400 },
  { name = "levelStars2", frames={ 17 }, time=400 },
  { name = "levelStars3", frames={ 18 }, time=400 },
  { name = "levelStars4", frames={ 15 }, time=400 },
  { name = "lineSeperator", frames={ 20 }, time=400 },
  { name = "worldBase1", frames={ 50 }, time=400 },
  { name = "worldBase3", frames={ 51 }, time=400 },
  { name = "worldBase4", frames={ 52 }, time=400 },
  { name = "worldBase2", frames={ 53 }, time=400 },
  
  { name = "worldBox1", frames={ 139 }, time=400 },
  { name = "worldBox2", frames={ 140 }, time=400 },
  { name = "worldBox3", frames={ 141 }, time=400 },
  { name = "worldBox4", frames={ 142 }, time=400 },

  { name = "textAbout", frames={ 27 }, time=400 },
  { name = "textContinue", frames={ 28 }, time=400 },
  { name = "textDrawings", frames={ 29 }, time=400 },
  { name = "textLevel", frames={ 30 }, time=400 },
  { name = "textLevelSelect", frames={ 31 }, time=400 },
  { name = "textLoading", frames={ 32 }, time=400 },
  { name = "textMainMenu", frames={ 33 }, time=400 },
  { name = "textMenu", frames={ 34 }, time=400 },
  { name = "textNext", frames={ 35 }, time=400 },
  { name = "textOptions", frames={ 36 }, time=400 },
  { name = "textPlay", frames={ 37 }, time=400 },
  { name = "textReplay", frames={ 38 }, time=400 },
  { name = "textScoreInfo0", frames={ 39 }, time=400 },
  { name = "textScoreInfo1", frames={ 40 }, time=400 },
  { name = "textScoreInfo2", frames={ 41 }, time=400 },
  { name = "textScoreInfo3", frames={ 42 }, time=400 },
  { name = "textSeason1", frames={ 43 }, time=400 },
  { name = "textSeason2", frames={ 44 }, time=400 },
  { name = "textSeason3", frames={ 45 }, time=400 },
  { name = "textWorld1", frames={ 46 }, time=400 },
  { name = "textWorld2", frames={ 47 }, time=400 },
  { name = "textWorld3", frames={ 48 }, time=400 },
  { name = "textWorld4", frames={ 49 }, time=400 },
  { name = "worldLocked", frames={ 138 }, time=400 },
  { name = "heroBig", frames={ 84 }, time=400 },
  { name = "nubBase", frames={ 85 }, time=400 },
  { name = "nubBaseAuto", frames={ 86 }, time=400 },
  { name = "nubTop", frames={ 87 }, time=400 },

  { name = "cookieOnString", frames={ 78 }, time=400 },
  { name = "coronaInfo", frames={ 79 }, time=400 },
  { name = "cushionLarge", frames={ 80 }, time=400 },
  { name = "cutTheCookie_logo", frames={ 81 }, time=400 },
  { name = "dbaLogo", frames={ 82 }, time=400 },
  { name = "dottedBox", frames={ 83 }, time=400 },
  
}

--direction="bounce"
--{ name = "heroNormal", frames={ 65,66,67,68,69,70,71,72,73,74,75,76,77,78,79,80,81,82,83}, time=1100 },
--{ name = "heroFeedMe", frames={ 12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30,31,32,33,34,35,36,37,38,39 }, time=1800 },

--[[
-----------------------------------------------------------------
-- Setup the various animation sequences used on the games scenes
-----------------------------------------------------------------
myGlobalData.animationSequenceDataHero = {
  { name = "heroBlink", frames={ 1,2 }, time=200 },
  { name = "heroEat", frames={ 3,4,5,6,7,8,9,10,11 }, time=400 },
  { name = "heroFeedMe", frames={ 12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30,31,32,33,34,35,36,37,38,39 }, time=1800 },
  { name = "heroOpenMouth", frames={ 40,41,42,43,44,45,46,47,48,49,50,51,52 }, time=800, loopCount=1 },
  { name = "heroSad", frames={ 53,54,55,56,57,58,59,60,61,62,63,64 }, time=600 },
  { name = "heroNormal", frames={ 65,66,67,68,69,70,71,72,73,74,75,76,77,78,79,80,81,82,83, 65,66,67,68,69,70,71,72,73,74,75,76,77,78,79,80,81,82,83,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30,31,32,33,34,35,36,37,38,39,65,66,67,68,69,70,71,72,73,74,75,76,77,78,79,80,81,82,83}, time=4000 },
  { name = "heroHappy", frames={ 84,85,86,87,88,89,90,91,92,93,94,95,96,97,98,99,100,101,102,103}, time=800, loopCount=1 },
}
--]]

--Start Game after a short delay.
timer.performWithDelay(5, startGame )

