--
-- created with TexturePacker (http://www.codeandweb.com/texturepacker)
--
-- $TexturePacker:SmartUpdate:7b31824bb1e81bd9841fe8d7f84dc8ac:1/1$
--
-- local sheetInfo = require("mysheet")
-- local myImageSheet = graphics.newImageSheet( "mysheet.png", sheetInfo:getSheet() )
-- local sprite = display.newSprite( myImageSheet , {frames={sheetInfo:getFrameIndex("sprite")}} )
--

local SheetInfo = {}

SheetInfo.sheet =
{
    frames = {
    
        {
            -- ButtonBackOff@2x
            x=970,
            y=108,
            width=52,
            height=50,

        },
        {
            -- ButtonBackOn@2x
            x=627,
            y=460,
            width=52,
            height=48,

            sourceX = 0,
            sourceY = 0,
            sourceWidth = 52,
            sourceHeight = 50
        },
        {
            -- ButtonLongOff@2x
            x=681,
            y=2,
            width=310,
            height=51,

        },
        {
            -- ButtonLongOn@2x
            x=681,
            y=55,
            width=308,
            height=51,

            sourceX = 1,
            sourceY = 0,
            sourceWidth = 310,
            sourceHeight = 51
        },
        {
            -- ButtonMediumOff@2x
            x=727,
            y=292,
            width=188,
            height=55,

        },
        {
            -- ButtonMediumOn@2x
            x=726,
            y=381,
            width=186,
            height=55,

            sourceX = 1,
            sourceY = 0,
            sourceWidth = 188,
            sourceHeight = 55
        },
        {
            -- ButtonSmallOff@2x
            x=490,
            y=400,
            width=136,
            height=54,

        },
        {
            -- ButtonSmallOn@2x
            x=490,
            y=456,
            width=135,
            height=54,

            sourceX = 0,
            sourceY = 0,
            sourceWidth = 136,
            sourceHeight = 54
        },
        {
            -- ButtonTinyOff@2x
            x=564,
            y=2,
            width=109,
            height=51,

        },
        {
            -- ButtonTinyOn@2x
            x=564,
            y=85,
            width=108,
            height=51,

            sourceX = 0,
            sourceY = 0,
            sourceWidth = 109,
            sourceHeight = 51
        },
        {
            -- IconCross@2x
            x=996,
            y=541,
            width=22,
            height=22,

        },
        {
            -- IconMusic@2x
            x=681,
            y=433,
            width=34,
            height=47,

            sourceX = 7,
            sourceY = 1,
            sourceWidth = 51,
            sourceHeight = 49
        },
        {
            -- IconSFX@2x
            x=516,
            y=965,
            width=47,
            height=49,

            sourceX = 4,
            sourceY = 0,
            sourceWidth = 51,
            sourceHeight = 49
        },
        {
            -- LevelLockedPanel@2x
            x=566,
            y=512,
            width=57,
            height=59,

        },
        {
            -- LevelStars0@2x
            x=681,
            y=409,
            width=43,
            height=22,

            sourceX = 1,
            sourceY = 1,
            sourceWidth = 44,
            sourceHeight = 25
        },
        {
            -- LevelStars1@2x
            x=681,
            y=385,
            width=43,
            height=22,

            sourceX = 1,
            sourceY = 1,
            sourceWidth = 44,
            sourceHeight = 25
        },
        {
            -- LevelStars2@2x
            x=681,
            y=361,
            width=43,
            height=22,

            sourceX = 1,
            sourceY = 1,
            sourceWidth = 44,
            sourceHeight = 25
        },
        {
            -- LevelStars3@2x
            x=681,
            y=337,
            width=43,
            height=22,

            sourceX = 1,
            sourceY = 1,
            sourceWidth = 44,
            sourceHeight = 25
        },
        {
            -- LevelUnLockedPanel@2x
            x=836,
            y=524,
            width=57,
            height=59,

        },
        {
            -- Seperator@2x
            x=76,
            y=1014,
            width=214,
            height=4,

        },
        {
            -- Spikes_1@2x
            x=292,
            y=1004,
            width=45,
            height=18,

            sourceX = 0,
            sourceY = 0,
            sourceWidth = 45,
            sourceHeight = 18
        },
        {
            -- Spikes_2@2x
            x=479,
            y=686,
            width=74,
            height=17,

        },
        {
            -- Spikes_3@2x
            x=916,
            y=377,
            width=103,
            height=17,

        },
        {
            -- Spikes_4@2x
            x=717,
            y=473,
            width=129,
            height=17,

            sourceX = 0,
            sourceY = 0,
            sourceWidth = 130,
            sourceHeight = 17
        },
        {
            -- StarBigOff@2x
            x=590,
            y=745,
            width=53,
            height=53,

        },
        {
            -- StarBigOn@2x
            x=479,
            y=757,
            width=53,
            height=53,

        },
        {
            -- Text_About@2x
            x=958,
            y=249,
            width=63,
            height=33,

            sourceX = 64,
            sourceY = 13,
            sourceWidth = 184,
            sourceHeight = 53
        },
        {
            -- Text_Continue@2x
            x=914,
            y=463,
            width=91,
            height=32,

            sourceX = 50,
            sourceY = 14,
            sourceWidth = 184,
            sourceHeight = 53
        },
        {
            -- Text_Drawings@2x
            x=914,
            y=430,
            width=95,
            height=31,

            sourceX = 48,
            sourceY = 14,
            sourceWidth = 184,
            sourceHeight = 53
        },
        {
            -- Text_Level@2x
            x=849,
            y=438,
            width=63,
            height=27,

            sourceX = 63,
            sourceY = 13,
            sourceWidth = 184,
            sourceHeight = 53
        },
        {
            -- Text_LevelSelect@2x
            x=717,
            y=438,
            width=130,
            height=33,

            sourceX = 30,
            sourceY = 13,
            sourceWidth = 184,
            sourceHeight = 53
        },
        {
            -- Text_Loading@2x
            x=914,
            y=396,
            width=102,
            height=32,

            sourceX = 44,
            sourceY = 13,
            sourceWidth = 184,
            sourceHeight = 53
        },
        {
            -- Text_MainMenu@2x
            x=564,
            y=55,
            width=109,
            height=28,

            sourceX = 41,
            sourceY = 13,
            sourceWidth = 184,
            sourceHeight = 53
        },
        {
            -- Text_Menu@2x
            x=960,
            y=220,
            width=61,
            height=27,

            sourceX = 65,
            sourceY = 13,
            sourceWidth = 184,
            sourceHeight = 53
        },
        {
            -- Text_Next@2x
            x=566,
            y=621,
            width=57,
            height=32,

            sourceX = 67,
            sourceY = 14,
            sourceWidth = 184,
            sourceHeight = 53
        },
        {
            -- Text_Options@2x
            x=625,
            y=627,
            width=77,
            height=32,

            sourceX = 57,
            sourceY = 14,
            sourceWidth = 184,
            sourceHeight = 53
        },
        {
            -- Text_Play@2x
            x=289,
            y=812,
            width=49,
            height=32,

            sourceX = 71,
            sourceY = 13,
            sourceWidth = 184,
            sourceHeight = 53
        },
        {
            -- Text_Replay@2x
            x=624,
            y=661,
            width=73,
            height=32,

            sourceX = 59,
            sourceY = 13,
            sourceWidth = 184,
            sourceHeight = 53
        },
        {
            -- Text_ScoreInfo0@2x
            x=917,
            y=314,
            width=105,
            height=32,

            sourceX = 43,
            sourceY = 13,
            sourceWidth = 184,
            sourceHeight = 53
        },
        {
            -- Text_ScoreInfo1@2x
            x=792,
            y=190,
            width=166,
            height=33,

            sourceX = 11,
            sourceY = 13,
            sourceWidth = 184,
            sourceHeight = 53
        },
        {
            -- Text_ScoreInfo2@2x
            x=917,
            y=348,
            width=103,
            height=27,

            sourceX = 44,
            sourceY = 13,
            sourceWidth = 184,
            sourceHeight = 53
        },
        {
            -- Text_ScoreInfo3@2x
            x=717,
            y=492,
            width=117,
            height=33,

            sourceX = 37,
            sourceY = 13,
            sourceWidth = 184,
            sourceHeight = 53
        },
        {
            -- Text_Season1@2x
            x=938,
            y=284,
            width=83,
            height=28,

            sourceX = 54,
            sourceY = 13,
            sourceWidth = 184,
            sourceHeight = 53
        },
        {
            -- Text_Season2@2x
            x=909,
            y=497,
            width=90,
            height=28,

            sourceX = 50,
            sourceY = 13,
            sourceWidth = 184,
            sourceHeight = 53
        },
        {
            -- Text_Season3@2x
            x=627,
            y=510,
            width=88,
            height=28,

            sourceX = 51,
            sourceY = 13,
            sourceWidth = 184,
            sourceHeight = 53
        },
        {
            -- Text_world1@2x
            x=728,
            y=258,
            width=208,
            height=32,

            sourceX = 4,
            sourceY = 5,
            sourceWidth = 213,
            sourceHeight = 39
        },
        {
            -- Text_world2@2x
            x=726,
            y=349,
            width=188,
            height=30,

            sourceX = 14,
            sourceY = 5,
            sourceWidth = 213,
            sourceHeight = 39
        },
        {
            -- Text_world3@2x
            x=790,
            y=225,
            width=166,
            height=30,

            sourceX = 25,
            sourceY = 5,
            sourceWidth = 213,
            sourceHeight = 39
        },
        {
            -- Text_world4@2x
            x=792,
            y=155,
            width=172,
            height=33,

            sourceX = 22,
            sourceY = 5,
            sourceWidth = 213,
            sourceHeight = 39
        },
        {
            -- WorldBase1@2x
            x=564,
            y=138,
            width=107,
            height=62,

            sourceX = 1,
            sourceY = 0,
            sourceWidth = 110,
            sourceHeight = 62
        },
        {
            -- WorldBase2@2x
            x=381,
            y=409,
            width=107,
            height=62,

            sourceX = 1,
            sourceY = 0,
            sourceWidth = 110,
            sourceHeight = 62
        },
        {
            -- WorldBase3@2x
            x=272,
            y=409,
            width=107,
            height=62,

            sourceX = 1,
            sourceY = 0,
            sourceWidth = 110,
            sourceHeight = 62
        },
        {
            -- WorldBase4@2x
            x=207,
            y=940,
            width=107,
            height=62,

            sourceX = 1,
            sourceY = 0,
            sourceWidth = 110,
            sourceHeight = 62
        },
        {
            -- bubble001@2x
            x=338,
            y=862,
            width=47,
            height=56,

            sourceX = 7,
            sourceY = 2,
            sourceWidth = 60,
            sourceHeight = 60
        },
        {
            -- bubble002@2x
            x=364,
            y=920,
            width=47,
            height=55,

            sourceX = 7,
            sourceY = 2,
            sourceWidth = 60,
            sourceHeight = 60
        },
        {
            -- bubble003@2x
            x=340,
            y=766,
            width=49,
            height=55,

            sourceX = 7,
            sourceY = 2,
            sourceWidth = 60,
            sourceHeight = 60
        },
        {
            -- bubble004@2x
            x=645,
            y=751,
            width=51,
            height=52,

            sourceX = 5,
            sourceY = 3,
            sourceWidth = 60,
            sourceHeight = 60
        },
        {
            -- bubble005@2x
            x=681,
            y=701,
            width=55,
            height=48,

            sourceX = 3,
            sourceY = 5,
            sourceWidth = 60,
            sourceHeight = 60
        },
        {
            -- bubble006@2x
            x=796,
            y=672,
            width=55,
            height=48,

            sourceX = 3,
            sourceY = 6,
            sourceWidth = 60,
            sourceHeight = 60
        },
        {
            -- bubble007@2x
            x=566,
            y=573,
            width=57,
            height=46,

            sourceX = 2,
            sourceY = 6,
            sourceWidth = 60,
            sourceHeight = 60
        },
        {
            -- bubble008@2x
            x=566,
            y=655,
            width=56,
            height=48,

            sourceX = 2,
            sourceY = 6,
            sourceWidth = 60,
            sourceHeight = 60
        },
        {
            -- bubble009@2x
            x=624,
            y=695,
            width=55,
            height=48,

            sourceX = 3,
            sourceY = 5,
            sourceWidth = 60,
            sourceHeight = 60
        },
        {
            -- bubble010@2x
            x=479,
            y=705,
            width=54,
            height=50,

            sourceX = 3,
            sourceY = 4,
            sourceWidth = 60,
            sourceHeight = 60
        },
        {
            -- bubble011@2x
            x=464,
            y=919,
            width=49,
            height=52,

            sourceX = 5,
            sourceY = 4,
            sourceWidth = 60,
            sourceHeight = 60
        },
        {
            -- bubble012@2x
            x=413,
            y=919,
            width=49,
            height=54,

            sourceX = 6,
            sourceY = 3,
            sourceWidth = 60,
            sourceHeight = 60
        },
        {
            -- bubble013@2x
            x=316,
            y=921,
            width=46,
            height=57,

            sourceX = 7,
            sourceY = 1,
            sourceWidth = 60,
            sourceHeight = 60
        },
        {
            -- bubble014@2x
            x=289,
            y=862,
            width=47,
            height=57,

            sourceX = 7,
            sourceY = 1,
            sourceWidth = 60,
            sourceHeight = 60
        },
        {
            -- bubbleNotMoving@2x
            x=728,
            y=196,
            width=60,
            height=60,

        },
        {
            -- bubblePop001@2x
            x=479,
            y=599,
            width=85,
            height=85,

        },
        {
            -- bubblePop002@2x
            x=625,
            y=540,
            width=85,
            height=85,

        },
        {
            -- bubblePop003@2x
            x=479,
            y=512,
            width=85,
            height=85,

        },
        {
            -- bubblePop004@2x
            x=891,
            y=614,
            width=85,
            height=85,

        },
        {
            -- bubblePop005@2x
            x=804,
            y=585,
            width=85,
            height=85,

        },
        {
            -- bubblePop006@2x
            x=717,
            y=527,
            width=85,
            height=85,

        },
        {
            -- bubblePop007@2x
            x=909,
            y=527,
            width=85,
            height=85,

        },
        {
            -- bubblePop008@2x
            x=641,
            y=202,
            width=85,
            height=85,

        },
        {
            -- bubblePop009@2x
            x=712,
            y=614,
            width=82,
            height=85,

            sourceX = 0,
            sourceY = 0,
            sourceWidth = 85,
            sourceHeight = 85
        },
        {
            -- cookieOnString@2x
            x=2,
            y=2,
            width=84,
            height=473,

            sourceX = 0,
            sourceY = 4,
            sourceWidth = 84,
            sourceHeight = 477
        },
        {
            -- coronaInfo@2x
            x=88,
            y=454,
            width=182,
            height=20,

            sourceX = 2,
            sourceY = 4,
            sourceWidth = 186,
            sourceHeight = 24
        },
        {
            -- cushionLarge@2x
            x=231,
            y=292,
            width=193,
            height=115,

            sourceX = 0,
            sourceY = 0,
            sourceWidth = 194,
            sourceHeight = 115
        },
        {
            -- cutTheCookie_logo@2x
            x=2,
            y=767,
            width=285,
            height=171,

            sourceX = 1,
            sourceY = 1,
            sourceWidth = 286,
            sourceHeight = 172
        },
        {
            -- dbaLogo@2x
            x=720,
            y=160,
            width=70,
            height=34,

            sourceX = 4,
            sourceY = 5,
            sourceWidth = 77,
            sourceHeight = 40
        },
        {
            -- dottedBox@2x
            x=681,
            y=108,
            width=287,
            height=45,

            sourceX = 0,
            sourceY = 3,
            sourceWidth = 289,
            sourceHeight = 52
        },
        {
            -- heroSmile_Big
            x=88,
            y=292,
            width=141,
            height=160,

            sourceX = 1,
            sourceY = 1,
            sourceWidth = 145,
            sourceHeight = 163
        },
        {
            -- nubBase@2x
            x=681,
            y=482,
            width=22,
            height=23,

            sourceX = 0,
            sourceY = 0,
            sourceWidth = 22,
            sourceHeight = 23
        },
        {
            -- nubBaseAuto@2x
            x=991,
            y=83,
            width=22,
            height=23,

            sourceX = 0,
            sourceY = 0,
            sourceWidth = 22,
            sourceHeight = 23
        },
        {
            -- nubTop@2x
            x=895,
            y=560,
            width=12,
            height=12,

            sourceX = 5,
            sourceY = 6,
            sourceWidth = 22,
            sourceHeight = 23
        },
        {
            -- star001@2x
            x=1001,
            y=505,
            width=16,
            height=15,

            sourceX = 0,
            sourceY = 1,
            sourceWidth = 17,
            sourceHeight = 17
        },
        {
            -- star002@2x
            x=996,
            y=583,
            width=14,
            height=15,

            sourceX = 1,
            sourceY = 1,
            sourceWidth = 17,
            sourceHeight = 17
        },
        {
            -- star003@2x
            x=804,
            y=527,
            width=13,
            height=15,

            sourceX = 2,
            sourceY = 1,
            sourceWidth = 17,
            sourceHeight = 17
        },
        {
            -- star004@2x
            x=895,
            y=543,
            width=12,
            height=15,

            sourceX = 2,
            sourceY = 1,
            sourceWidth = 17,
            sourceHeight = 17
        },
        {
            -- star005@2x
            x=836,
            y=492,
            width=10,
            height=15,

            sourceX = 3,
            sourceY = 1,
            sourceWidth = 17,
            sourceHeight = 17
        },
        {
            -- star006@2x
            x=705,
            y=482,
            width=10,
            height=15,

            sourceX = 3,
            sourceY = 1,
            sourceWidth = 17,
            sourceHeight = 17
        },
        {
            -- star007@2x
            x=479,
            y=491,
            width=8,
            height=16,

            sourceX = 4,
            sourceY = 0,
            sourceWidth = 17,
            sourceHeight = 17
        },
        {
            -- star008@2x
            x=1015,
            y=83,
            width=7,
            height=16,

            sourceX = 5,
            sourceY = 0,
            sourceWidth = 17,
            sourceHeight = 17
        },
        {
            -- star009@2x
            x=264,
            y=427,
            width=6,
            height=16,

            sourceX = 5,
            sourceY = 0,
            sourceWidth = 17,
            sourceHeight = 17
        },
        {
            -- star010@2x
            x=264,
            y=409,
            width=6,
            height=16,

            sourceX = 5,
            sourceY = 0,
            sourceWidth = 17,
            sourceHeight = 17
        },
        {
            -- star011@2x
            x=479,
            y=473,
            width=8,
            height=16,

            sourceX = 4,
            sourceY = 0,
            sourceWidth = 17,
            sourceHeight = 17
        },
        {
            -- star012@2x
            x=1011,
            y=430,
            width=10,
            height=17,

            sourceX = 3,
            sourceY = 0,
            sourceWidth = 17,
            sourceHeight = 17
        },
        {
            -- star013@2x
            x=1011,
            y=449,
            width=10,
            height=16,

            sourceX = 3,
            sourceY = 0,
            sourceWidth = 17,
            sourceHeight = 17
        },
        {
            -- star014@2x
            x=895,
            y=524,
            width=12,
            height=17,

            sourceX = 2,
            sourceY = 0,
            sourceWidth = 17,
            sourceHeight = 17
        },
        {
            -- star015@2x
            x=1001,
            y=522,
            width=14,
            height=17,

            sourceX = 1,
            sourceY = 0,
            sourceWidth = 17,
            sourceHeight = 17
        },
        {
            -- star016@2x
            x=1007,
            y=486,
            width=15,
            height=17,

            sourceX = 1,
            sourceY = 0,
            sourceWidth = 17,
            sourceHeight = 17
        },
        {
            -- star017@2x
            x=1007,
            y=467,
            width=15,
            height=17,

            sourceX = 1,
            sourceY = 0,
            sourceWidth = 17,
            sourceHeight = 17
        },
        {
            -- star018@2x
            x=938,
            y=257,
            width=17,
            height=16,

            sourceX = 0,
            sourceY = 0,
            sourceWidth = 17,
            sourceHeight = 17
        },
        {
            -- starCollect001@2x
            x=966,
            y=160,
            width=56,
            height=58,

            sourceX = 15,
            sourceY = 22,
            sourceWidth = 90,
            sourceHeight = 90
        },
        {
            -- starCollect002@2x
            x=76,
            y=940,
            width=66,
            height=72,

            sourceX = 12,
            sourceY = 7,
            sourceWidth = 90,
            sourceHeight = 90
        },
        {
            -- starCollect003@2x
            x=628,
            y=400,
            width=51,
            height=58,

            sourceX = 20,
            sourceY = 16,
            sourceWidth = 90,
            sourceHeight = 90
        },
        {
            -- starCollect004@2x
            x=144,
            y=940,
            width=61,
            height=63,

            sourceX = 15,
            sourceY = 12,
            sourceWidth = 90,
            sourceHeight = 90
        },
        {
            -- starCollect005@2x
            x=564,
            y=202,
            width=75,
            height=88,

            sourceX = 7,
            sourceY = 0,
            sourceWidth = 90,
            sourceHeight = 90
        },
        {
            -- starCollect006@2x
            x=2,
            y=940,
            width=72,
            height=79,

            sourceX = 7,
            sourceY = 5,
            sourceWidth = 90,
            sourceHeight = 90
        },
        {
            -- starCollect007@2x
            x=738,
            y=701,
            width=54,
            height=57,

            sourceX = 16,
            sourceY = 19,
            sourceWidth = 90,
            sourceHeight = 90
        },
        {
            -- starCollect008@2x
            x=535,
            y=705,
            width=53,
            height=54,

            sourceX = 14,
            sourceY = 18,
            sourceWidth = 90,
            sourceHeight = 90
        },
        {
            -- starCollect009@2x
            x=681,
            y=289,
            width=44,
            height=46,

            sourceX = 20,
            sourceY = 21,
            sourceWidth = 90,
            sourceHeight = 90
        },
        {
            -- starCollect010@2x
            x=534,
            y=761,
            width=53,
            height=48,

            sourceX = 15,
            sourceY = 21,
            sourceWidth = 90,
            sourceHeight = 90
        },
        {
            -- starCollect011@2x
            x=849,
            y=467,
            width=58,
            height=55,

            sourceX = 12,
            sourceY = 17,
            sourceWidth = 90,
            sourceHeight = 90
        },
        {
            -- starCollect012@2x
            x=231,
            y=409,
            width=31,
            height=30,

            sourceX = 28,
            sourceY = 30,
            sourceWidth = 90,
            sourceHeight = 90
        },
        {
            -- starCollect013@2x
            x=2,
            y=1021,
            width=1,
            height=1,

            sourceX = 0,
            sourceY = 0,
            sourceWidth = 90,
            sourceHeight = 90
        },
        {
            -- starGlow@2x
            x=673,
            y=155,
            width=45,
            height=44,

            sourceX = 0,
            sourceY = 0,
            sourceWidth = 45,
            sourceHeight = 45
        },
        {
            -- starOff@2x
            x=993,
            y=33,
            width=29,
            height=29,

        },
        {
            -- starOn@2x
            x=993,
            y=2,
            width=29,
            height=29,

        },
        {
            -- sweetBreak_001@2x
            x=996,
            y=565,
            width=14,
            height=16,

            sourceX = 1,
            sourceY = 0,
            sourceWidth = 18,
            sourceHeight = 17
        },
        {
            -- sweetBreak_002@2x
            x=917,
            y=292,
            width=16,
            height=17,

            sourceX = 1,
            sourceY = 0,
            sourceWidth = 18,
            sourceHeight = 17
        },
        {
            -- sweetBreak_003@2x
            x=996,
            y=600,
            width=13,
            height=17,

            sourceX = 3,
            sourceY = 0,
            sourceWidth = 18,
            sourceHeight = 17
        },
        {
            -- sweetBreak_004@2x
            x=231,
            y=441,
            width=13,
            height=11,

            sourceX = 2,
            sourceY = 3,
            sourceWidth = 18,
            sourceHeight = 17
        },
        {
            -- sweetBreak_005@2x
            x=991,
            y=64,
            width=25,
            height=17,

            sourceX = 0,
            sourceY = 0,
            sourceWidth = 25,
            sourceHeight = 17
        },
        {
            -- sweetMain@2x
            x=543,
            y=862,
            width=50,
            height=49,

            sourceX = 3,
            sourceY = 4,
            sourceWidth = 53,
            sourceHeight = 53
        },
        {
            -- sweetShine_001@2x
            x=515,
            y=914,
            width=50,
            height=49,

            sourceX = 3,
            sourceY = 4,
            sourceWidth = 53,
            sourceHeight = 53
        },
        {
            -- sweetShine_002@2x
            x=491,
            y=863,
            width=50,
            height=49,

            sourceX = 3,
            sourceY = 4,
            sourceWidth = 53,
            sourceHeight = 53
        },
        {
            -- sweetShine_003@2x
            x=464,
            y=973,
            width=50,
            height=49,

            sourceX = 3,
            sourceY = 4,
            sourceWidth = 53,
            sourceHeight = 53
        },
        {
            -- sweetShine_004@2x
            x=439,
            y=868,
            width=50,
            height=49,

            sourceX = 3,
            sourceY = 4,
            sourceWidth = 53,
            sourceHeight = 53
        },
        {
            -- sweetShine_005@2x
            x=387,
            y=868,
            width=50,
            height=49,

            sourceX = 3,
            sourceY = 4,
            sourceWidth = 53,
            sourceHeight = 53
        },
        {
            -- sweetShine_006@2x
            x=391,
            y=817,
            width=50,
            height=49,

            sourceX = 3,
            sourceY = 4,
            sourceWidth = 53,
            sourceHeight = 53
        },
        {
            -- sweetShine_007@2x
            x=443,
            y=812,
            width=50,
            height=49,

            sourceX = 3,
            sourceY = 4,
            sourceWidth = 53,
            sourceHeight = 53
        },
        {
            -- sweetShine_008@2x
            x=391,
            y=766,
            width=50,
            height=49,

            sourceX = 3,
            sourceY = 4,
            sourceWidth = 53,
            sourceHeight = 53
        },
        {
            -- sweetShine_009@2x
            x=534,
            y=811,
            width=50,
            height=49,

            sourceX = 3,
            sourceY = 4,
            sourceWidth = 53,
            sourceHeight = 53
        },
        {
            -- sweetShine_010@2x
            x=589,
            y=800,
            width=50,
            height=49,

            sourceX = 3,
            sourceY = 4,
            sourceWidth = 53,
            sourceHeight = 53
        },
        {
            -- worldLocked@2x
            x=426,
            y=292,
            width=253,
            height=106,

            sourceX = 0,
            sourceY = 0,
            sourceWidth = 253,
            sourceHeight = 106
        },
        {
            -- worldOven1@2x
            x=241,
            y=476,
            width=236,
            height=288,

            sourceX = 1,
            sourceY = 0,
            sourceWidth = 237,
            sourceHeight = 288
        },
        {
            -- worldOven2@2x
            x=327,
            y=2,
            width=235,
            height=288,

            sourceX = 2,
            sourceY = 0,
            sourceWidth = 238,
            sourceHeight = 288
        },
        {
            -- worldOven3@2x
            x=88,
            y=2,
            width=237,
            height=288,

            sourceX = 1,
            sourceY = 0,
            sourceWidth = 238,
            sourceHeight = 288
        },
        {
            -- worldOven4@2x
            x=2,
            y=477,
            width=237,
            height=288,

            sourceX = 1,
            sourceY = 0,
            sourceWidth = 238,
            sourceHeight = 288
        },
    },
    
    sheetContentWidth = 1024,
    sheetContentHeight = 1024
}

SheetInfo.frameIndex =
{

    ["ButtonBackOff@2x"] = 1,
    ["ButtonBackOn@2x"] = 2,
    ["ButtonLongOff@2x"] = 3,
    ["ButtonLongOn@2x"] = 4,
    ["ButtonMediumOff@2x"] = 5,
    ["ButtonMediumOn@2x"] = 6,
    ["ButtonSmallOff@2x"] = 7,
    ["ButtonSmallOn@2x"] = 8,
    ["ButtonTinyOff@2x"] = 9,
    ["ButtonTinyOn@2x"] = 10,
    ["IconCross@2x"] = 11,
    ["IconMusic@2x"] = 12,
    ["IconSFX@2x"] = 13,
    ["LevelLockedPanel@2x"] = 14,
    ["LevelStars0@2x"] = 15,
    ["LevelStars1@2x"] = 16,
    ["LevelStars2@2x"] = 17,
    ["LevelStars3@2x"] = 18,
    ["LevelUnLockedPanel@2x"] = 19,
    ["Seperator@2x"] = 20,
    ["Spikes_1@2x"] = 21,
    ["Spikes_2@2x"] = 22,
    ["Spikes_3@2x"] = 23,
    ["Spikes_4@2x"] = 24,
    ["StarBigOff@2x"] = 25,
    ["StarBigOn@2x"] = 26,
    ["Text_About@2x"] = 27,
    ["Text_Continue@2x"] = 28,
    ["Text_Drawings@2x"] = 29,
    ["Text_Level@2x"] = 30,
    ["Text_LevelSelect@2x"] = 31,
    ["Text_Loading@2x"] = 32,
    ["Text_MainMenu@2x"] = 33,
    ["Text_Menu@2x"] = 34,
    ["Text_Next@2x"] = 35,
    ["Text_Options@2x"] = 36,
    ["Text_Play@2x"] = 37,
    ["Text_Replay@2x"] = 38,
    ["Text_ScoreInfo0@2x"] = 39,
    ["Text_ScoreInfo1@2x"] = 40,
    ["Text_ScoreInfo2@2x"] = 41,
    ["Text_ScoreInfo3@2x"] = 42,
    ["Text_Season1@2x"] = 43,
    ["Text_Season2@2x"] = 44,
    ["Text_Season3@2x"] = 45,
    ["Text_world1@2x"] = 46,
    ["Text_world2@2x"] = 47,
    ["Text_world3@2x"] = 48,
    ["Text_world4@2x"] = 49,
    ["WorldBase1@2x"] = 50,
    ["WorldBase2@2x"] = 51,
    ["WorldBase3@2x"] = 52,
    ["WorldBase4@2x"] = 53,
    ["bubble001@2x"] = 54,
    ["bubble002@2x"] = 55,
    ["bubble003@2x"] = 56,
    ["bubble004@2x"] = 57,
    ["bubble005@2x"] = 58,
    ["bubble006@2x"] = 59,
    ["bubble007@2x"] = 60,
    ["bubble008@2x"] = 61,
    ["bubble009@2x"] = 62,
    ["bubble010@2x"] = 63,
    ["bubble011@2x"] = 64,
    ["bubble012@2x"] = 65,
    ["bubble013@2x"] = 66,
    ["bubble014@2x"] = 67,
    ["bubbleNotMoving@2x"] = 68,
    ["bubblePop001@2x"] = 69,
    ["bubblePop002@2x"] = 70,
    ["bubblePop003@2x"] = 71,
    ["bubblePop004@2x"] = 72,
    ["bubblePop005@2x"] = 73,
    ["bubblePop006@2x"] = 74,
    ["bubblePop007@2x"] = 75,
    ["bubblePop008@2x"] = 76,
    ["bubblePop009@2x"] = 77,
    ["cookieOnString@2x"] = 78,
    ["coronaInfo@2x"] = 79,
    ["cushionLarge@2x"] = 80,
    ["cutTheCookie_logo@2x"] = 81,
    ["dbaLogo@2x"] = 82,
    ["dottedBox@2x"] = 83,
    ["heroSmile_Big"] = 84,
    ["nubBase@2x"] = 85,
    ["nubBaseAuto@2x"] = 86,
    ["nubTop@2x"] = 87,
    ["star001@2x"] = 88,
    ["star002@2x"] = 89,
    ["star003@2x"] = 90,
    ["star004@2x"] = 91,
    ["star005@2x"] = 92,
    ["star006@2x"] = 93,
    ["star007@2x"] = 94,
    ["star008@2x"] = 95,
    ["star009@2x"] = 96,
    ["star010@2x"] = 97,
    ["star011@2x"] = 98,
    ["star012@2x"] = 99,
    ["star013@2x"] = 100,
    ["star014@2x"] = 101,
    ["star015@2x"] = 102,
    ["star016@2x"] = 103,
    ["star017@2x"] = 104,
    ["star018@2x"] = 105,
    ["starCollect001@2x"] = 106,
    ["starCollect002@2x"] = 107,
    ["starCollect003@2x"] = 108,
    ["starCollect004@2x"] = 109,
    ["starCollect005@2x"] = 110,
    ["starCollect006@2x"] = 111,
    ["starCollect007@2x"] = 112,
    ["starCollect008@2x"] = 113,
    ["starCollect009@2x"] = 114,
    ["starCollect010@2x"] = 115,
    ["starCollect011@2x"] = 116,
    ["starCollect012@2x"] = 117,
    ["starCollect013@2x"] = 118,
    ["starGlow@2x"] = 119,
    ["starOff@2x"] = 120,
    ["starOn@2x"] = 121,
    ["sweetBreak_001@2x"] = 122,
    ["sweetBreak_002@2x"] = 123,
    ["sweetBreak_003@2x"] = 124,
    ["sweetBreak_004@2x"] = 125,
    ["sweetBreak_005@2x"] = 126,
    ["sweetMain@2x"] = 127,
    ["sweetShine_001@2x"] = 128,
    ["sweetShine_002@2x"] = 129,
    ["sweetShine_003@2x"] = 130,
    ["sweetShine_004@2x"] = 131,
    ["sweetShine_005@2x"] = 132,
    ["sweetShine_006@2x"] = 133,
    ["sweetShine_007@2x"] = 134,
    ["sweetShine_008@2x"] = 135,
    ["sweetShine_009@2x"] = 136,
    ["sweetShine_010@2x"] = 137,
    ["worldLocked@2x"] = 138,
    ["worldOven1@2x"] = 139,
    ["worldOven2@2x"] = 140,
    ["worldOven3@2x"] = 141,
    ["worldOven4@2x"] = 142,
}

function SheetInfo:getSheet()
    return self.sheet;
end

function SheetInfo:getFrameIndex(name)
    return self.frameIndex[name];
end

return SheetInfo
