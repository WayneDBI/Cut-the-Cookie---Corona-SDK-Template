--
-- created with TexturePacker (http://www.codeandweb.com/texturepacker)
--
-- $TexturePacker:SmartUpdate:b39fa2961244352df82878ee40ed7a9d:1/1$
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
            x=1940,
            y=216,
            width=104,
            height=100,

        },
        {
            -- ButtonBackOn@2x
            x=1254,
            y=920,
            width=104,
            height=96,

            sourceX = 0,
            sourceY = 0,
            sourceWidth = 104,
            sourceHeight = 100
        },
        {
            -- ButtonLongOff@2x
            x=1362,
            y=4,
            width=620,
            height=102,

        },
        {
            -- ButtonLongOn@2x
            x=1362,
            y=110,
            width=616,
            height=102,

            sourceX = 2,
            sourceY = 0,
            sourceWidth = 620,
            sourceHeight = 102
        },
        {
            -- ButtonMediumOff@2x
            x=1454,
            y=584,
            width=376,
            height=110,

        },
        {
            -- ButtonMediumOn@2x
            x=1452,
            y=762,
            width=372,
            height=110,

            sourceX = 2,
            sourceY = 0,
            sourceWidth = 376,
            sourceHeight = 110
        },
        {
            -- ButtonSmallOff@2x
            x=980,
            y=800,
            width=272,
            height=108,

        },
        {
            -- ButtonSmallOn@2x
            x=980,
            y=912,
            width=270,
            height=108,

            sourceX = 0,
            sourceY = 0,
            sourceWidth = 272,
            sourceHeight = 108
        },
        {
            -- ButtonTinyOff@2x
            x=1128,
            y=4,
            width=218,
            height=102,

        },
        {
            -- ButtonTinyOn@2x
            x=1128,
            y=170,
            width=216,
            height=102,

            sourceX = 0,
            sourceY = 0,
            sourceWidth = 218,
            sourceHeight = 102
        },
        {
            -- IconCross@2x
            x=1992,
            y=1082,
            width=44,
            height=44,

        },
        {
            -- IconMusic@2x
            x=1362,
            y=866,
            width=68,
            height=94,

            sourceX = 14,
            sourceY = 2,
            sourceWidth = 102,
            sourceHeight = 98
        },
        {
            -- IconSFX@2x
            x=1032,
            y=1930,
            width=94,
            height=98,

            sourceX = 8,
            sourceY = 0,
            sourceWidth = 102,
            sourceHeight = 98
        },
        {
            -- LevelLockedPanel@2x
            x=1132,
            y=1024,
            width=114,
            height=118,

        },
        {
            -- LevelStars0@2x
            x=1362,
            y=818,
            width=86,
            height=44,

            sourceX = 2,
            sourceY = 2,
            sourceWidth = 88,
            sourceHeight = 50
        },
        {
            -- LevelStars1@2x
            x=1362,
            y=770,
            width=86,
            height=44,

            sourceX = 2,
            sourceY = 2,
            sourceWidth = 88,
            sourceHeight = 50
        },
        {
            -- LevelStars2@2x
            x=1362,
            y=722,
            width=86,
            height=44,

            sourceX = 2,
            sourceY = 2,
            sourceWidth = 88,
            sourceHeight = 50
        },
        {
            -- LevelStars3@2x
            x=1362,
            y=674,
            width=86,
            height=44,

            sourceX = 2,
            sourceY = 2,
            sourceWidth = 88,
            sourceHeight = 50
        },
        {
            -- LevelUnLockedPanel@2x
            x=1672,
            y=1048,
            width=114,
            height=118,

        },
        {
            -- Seperator@2x
            x=152,
            y=2028,
            width=428,
            height=8,

        },
        {
            -- Spikes_1@2x
            x=584,
            y=2008,
            width=90,
            height=36,

            sourceX = 0,
            sourceY = 0,
            sourceWidth = 89,
            sourceHeight = 35
        },
        {
            -- Spikes_2@2x
            x=958,
            y=1372,
            width=148,
            height=34,

        },
        {
            -- Spikes_3@2x
            x=1832,
            y=754,
            width=206,
            height=34,

        },
        {
            -- Spikes_4@2x
            x=1434,
            y=946,
            width=258,
            height=34,

            sourceX = 0,
            sourceY = 0,
            sourceWidth = 259,
            sourceHeight = 34
        },
        {
            -- StarBigOff@2x
            x=1180,
            y=1490,
            width=106,
            height=106,

        },
        {
            -- StarBigOn@2x
            x=958,
            y=1514,
            width=106,
            height=106,

        },
        {
            -- Text_About@2x
            x=1916,
            y=498,
            width=126,
            height=66,

            sourceX = 128,
            sourceY = 26,
            sourceWidth = 368,
            sourceHeight = 106
        },
        {
            -- Text_Continue@2x
            x=1828,
            y=926,
            width=182,
            height=64,

            sourceX = 100,
            sourceY = 28,
            sourceWidth = 368,
            sourceHeight = 106
        },
        {
            -- Text_Drawings@2x
            x=1828,
            y=860,
            width=190,
            height=62,

            sourceX = 96,
            sourceY = 28,
            sourceWidth = 368,
            sourceHeight = 106
        },
        {
            -- Text_Level@2x
            x=1698,
            y=876,
            width=126,
            height=54,

            sourceX = 126,
            sourceY = 26,
            sourceWidth = 368,
            sourceHeight = 106
        },
        {
            -- Text_LevelSelect@2x
            x=1434,
            y=876,
            width=260,
            height=66,

            sourceX = 60,
            sourceY = 26,
            sourceWidth = 368,
            sourceHeight = 106
        },
        {
            -- Text_Loading@2x
            x=1828,
            y=792,
            width=204,
            height=64,

            sourceX = 88,
            sourceY = 26,
            sourceWidth = 368,
            sourceHeight = 106
        },
        {
            -- Text_MainMenu@2x
            x=1128,
            y=110,
            width=218,
            height=56,

            sourceX = 82,
            sourceY = 26,
            sourceWidth = 368,
            sourceHeight = 106
        },
        {
            -- Text_Menu@2x
            x=1920,
            y=440,
            width=122,
            height=54,

            sourceX = 130,
            sourceY = 26,
            sourceWidth = 368,
            sourceHeight = 106
        },
        {
            -- Text_Next@2x
            x=1132,
            y=1242,
            width=114,
            height=64,

            sourceX = 134,
            sourceY = 28,
            sourceWidth = 368,
            sourceHeight = 106
        },
        {
            -- Text_Options@2x
            x=1250,
            y=1254,
            width=154,
            height=64,

            sourceX = 114,
            sourceY = 28,
            sourceWidth = 368,
            sourceHeight = 106
        },
        {
            -- Text_Play@2x
            x=578,
            y=1624,
            width=98,
            height=64,

            sourceX = 142,
            sourceY = 26,
            sourceWidth = 368,
            sourceHeight = 106
        },
        {
            -- Text_Replay@2x
            x=1248,
            y=1322,
            width=146,
            height=64,

            sourceX = 118,
            sourceY = 26,
            sourceWidth = 368,
            sourceHeight = 106
        },
        {
            -- Text_ScoreInfo0@2x
            x=1834,
            y=628,
            width=210,
            height=64,

            sourceX = 86,
            sourceY = 26,
            sourceWidth = 368,
            sourceHeight = 106
        },
        {
            -- Text_ScoreInfo1@2x
            x=1584,
            y=380,
            width=332,
            height=66,

            sourceX = 22,
            sourceY = 26,
            sourceWidth = 368,
            sourceHeight = 106
        },
        {
            -- Text_ScoreInfo2@2x
            x=1834,
            y=696,
            width=206,
            height=54,

            sourceX = 88,
            sourceY = 26,
            sourceWidth = 368,
            sourceHeight = 106
        },
        {
            -- Text_ScoreInfo3@2x
            x=1434,
            y=984,
            width=234,
            height=66,

            sourceX = 74,
            sourceY = 26,
            sourceWidth = 368,
            sourceHeight = 106
        },
        {
            -- Text_Season1@2x
            x=1876,
            y=568,
            width=166,
            height=56,

            sourceX = 108,
            sourceY = 26,
            sourceWidth = 368,
            sourceHeight = 106
        },
        {
            -- Text_Season2@2x
            x=1818,
            y=994,
            width=180,
            height=56,

            sourceX = 100,
            sourceY = 26,
            sourceWidth = 368,
            sourceHeight = 106
        },
        {
            -- Text_Season3@2x
            x=1254,
            y=1020,
            width=176,
            height=56,

            sourceX = 102,
            sourceY = 26,
            sourceWidth = 368,
            sourceHeight = 106
        },
        {
            -- Text_world1@2x
            x=1456,
            y=516,
            width=416,
            height=64,

            sourceX = 8,
            sourceY = 10,
            sourceWidth = 426,
            sourceHeight = 78
        },
        {
            -- Text_world2@2x
            x=1452,
            y=698,
            width=376,
            height=60,

            sourceX = 28,
            sourceY = 10,
            sourceWidth = 426,
            sourceHeight = 78
        },
        {
            -- Text_world3@2x
            x=1580,
            y=450,
            width=332,
            height=60,

            sourceX = 50,
            sourceY = 10,
            sourceWidth = 426,
            sourceHeight = 78
        },
        {
            -- Text_world4@2x
            x=1584,
            y=310,
            width=344,
            height=66,

            sourceX = 44,
            sourceY = 10,
            sourceWidth = 426,
            sourceHeight = 78
        },
        {
            -- WorldBase1@2x
            x=1128,
            y=276,
            width=214,
            height=124,

            sourceX = 2,
            sourceY = 0,
            sourceWidth = 219,
            sourceHeight = 123
        },
        {
            -- WorldBase2@2x
            x=762,
            y=818,
            width=214,
            height=124,

            sourceX = 2,
            sourceY = 0,
            sourceWidth = 219,
            sourceHeight = 123
        },
        {
            -- WorldBase3@2x
            x=544,
            y=818,
            width=214,
            height=124,

            sourceX = 2,
            sourceY = 0,
            sourceWidth = 219,
            sourceHeight = 123
        },
        {
            -- WorldBase4@2x
            x=414,
            y=1880,
            width=214,
            height=124,

            sourceX = 2,
            sourceY = 0,
            sourceWidth = 219,
            sourceHeight = 123
        },
        {
            -- bubble001@2x
            x=676,
            y=1724,
            width=94,
            height=112,

            sourceX = 14,
            sourceY = 4,
            sourceWidth = 120,
            sourceHeight = 120
        },
        {
            -- bubble002@2x
            x=728,
            y=1840,
            width=94,
            height=110,

            sourceX = 14,
            sourceY = 4,
            sourceWidth = 120,
            sourceHeight = 120
        },
        {
            -- bubble003@2x
            x=680,
            y=1532,
            width=98,
            height=110,

            sourceX = 14,
            sourceY = 4,
            sourceWidth = 120,
            sourceHeight = 120
        },
        {
            -- bubble004@2x
            x=1290,
            y=1502,
            width=102,
            height=104,

            sourceX = 10,
            sourceY = 6,
            sourceWidth = 120,
            sourceHeight = 120
        },
        {
            -- bubble005@2x
            x=1362,
            y=1402,
            width=110,
            height=96,

            sourceX = 6,
            sourceY = 10,
            sourceWidth = 120,
            sourceHeight = 120
        },
        {
            -- bubble006@2x
            x=1592,
            y=1344,
            width=110,
            height=96,

            sourceX = 6,
            sourceY = 12,
            sourceWidth = 120,
            sourceHeight = 120
        },
        {
            -- bubble007@2x
            x=1132,
            y=1146,
            width=114,
            height=92,

            sourceX = 4,
            sourceY = 12,
            sourceWidth = 120,
            sourceHeight = 120
        },
        {
            -- bubble008@2x
            x=1132,
            y=1310,
            width=112,
            height=96,

            sourceX = 4,
            sourceY = 12,
            sourceWidth = 120,
            sourceHeight = 120
        },
        {
            -- bubble009@2x
            x=1248,
            y=1390,
            width=110,
            height=96,

            sourceX = 6,
            sourceY = 10,
            sourceWidth = 120,
            sourceHeight = 120
        },
        {
            -- bubble010@2x
            x=958,
            y=1410,
            width=108,
            height=100,

            sourceX = 6,
            sourceY = 8,
            sourceWidth = 120,
            sourceHeight = 120
        },
        {
            -- bubble011@2x
            x=928,
            y=1838,
            width=98,
            height=104,

            sourceX = 10,
            sourceY = 8,
            sourceWidth = 120,
            sourceHeight = 120
        },
        {
            -- bubble012@2x
            x=826,
            y=1838,
            width=98,
            height=108,

            sourceX = 12,
            sourceY = 6,
            sourceWidth = 120,
            sourceHeight = 120
        },
        {
            -- bubble013@2x
            x=632,
            y=1842,
            width=92,
            height=114,

            sourceX = 14,
            sourceY = 2,
            sourceWidth = 120,
            sourceHeight = 120
        },
        {
            -- bubble014@2x
            x=578,
            y=1724,
            width=94,
            height=114,

            sourceX = 14,
            sourceY = 2,
            sourceWidth = 120,
            sourceHeight = 120
        },
        {
            -- bubbleNotMoving@2x
            x=1456,
            y=392,
            width=120,
            height=120,

        },
        {
            -- bubblePop001@2x
            x=958,
            y=1198,
            width=170,
            height=170,

        },
        {
            -- bubblePop002@2x
            x=1250,
            y=1080,
            width=170,
            height=170,

        },
        {
            -- bubblePop003@2x
            x=958,
            y=1024,
            width=170,
            height=170,

        },
        {
            -- bubblePop004@2x
            x=1782,
            y=1228,
            width=170,
            height=170,

        },
        {
            -- bubblePop005@2x
            x=1608,
            y=1170,
            width=170,
            height=170,

        },
        {
            -- bubblePop006@2x
            x=1434,
            y=1054,
            width=170,
            height=170,

        },
        {
            -- bubblePop007@2x
            x=1818,
            y=1054,
            width=170,
            height=170,

        },
        {
            -- bubblePop008@2x
            x=1282,
            y=404,
            width=170,
            height=170,

        },
        {
            -- bubblePop009@2x
            x=1424,
            y=1228,
            width=164,
            height=170,

            sourceX = 0,
            sourceY = 0,
            sourceWidth = 170,
            sourceHeight = 170
        },
        {
            -- cookieOnString@2x
            x=4,
            y=4,
            width=168,
            height=946,

            sourceX = 0,
            sourceY = 8,
            sourceWidth = 167,
            sourceHeight = 953
        },
        {
            -- coronaInfo@2x
            x=176,
            y=908,
            width=364,
            height=40,

            sourceX = 4,
            sourceY = 8,
            sourceWidth = 372,
            sourceHeight = 47
        },
        {
            -- cushionLarge@2x
            x=462,
            y=584,
            width=386,
            height=230,

            sourceX = 0,
            sourceY = 0,
            sourceWidth = 388,
            sourceHeight = 230
        },
        {
            -- cutTheCookie_logo@2x
            x=4,
            y=1534,
            width=570,
            height=342,

            sourceX = 2,
            sourceY = 2,
            sourceWidth = 571,
            sourceHeight = 343
        },
        {
            -- dbaLogo@2x
            x=1440,
            y=320,
            width=140,
            height=68,

            sourceX = 8,
            sourceY = 10,
            sourceWidth = 154,
            sourceHeight = 80
        },
        {
            -- dottedBox@2x
            x=1362,
            y=216,
            width=574,
            height=90,

            sourceX = 0,
            sourceY = 6,
            sourceWidth = 578,
            sourceHeight = 103
        },
        {
            -- heroSmile_Big
            x=176,
            y=584,
            width=282,
            height=320,

            sourceX = 2,
            sourceY = 2,
            sourceWidth = 289,
            sourceHeight = 325
        },
        {
            -- nubBase@2x
            x=1362,
            y=964,
            width=44,
            height=46,

            sourceX = 0,
            sourceY = 0,
            sourceWidth = 44,
            sourceHeight = 45
        },
        {
            -- nubBaseAuto@2x
            x=1982,
            y=166,
            width=44,
            height=46,

            sourceX = 0,
            sourceY = 0,
            sourceWidth = 44,
            sourceHeight = 45
        },
        {
            -- nubTop@2x
            x=1790,
            y=1120,
            width=24,
            height=24,

            sourceX = 10,
            sourceY = 12,
            sourceWidth = 44,
            sourceHeight = 45
        },
        {
            -- star001@2x
            x=2002,
            y=1010,
            width=32,
            height=30,

            sourceX = 0,
            sourceY = 2,
            sourceWidth = 34,
            sourceHeight = 34
        },
        {
            -- star002@2x
            x=1992,
            y=1166,
            width=28,
            height=30,

            sourceX = 2,
            sourceY = 2,
            sourceWidth = 34,
            sourceHeight = 34
        },
        {
            -- star003@2x
            x=1608,
            y=1054,
            width=26,
            height=30,

            sourceX = 4,
            sourceY = 2,
            sourceWidth = 34,
            sourceHeight = 34
        },
        {
            -- star004@2x
            x=1790,
            y=1086,
            width=24,
            height=30,

            sourceX = 4,
            sourceY = 2,
            sourceWidth = 34,
            sourceHeight = 34
        },
        {
            -- star005@2x
            x=1672,
            y=984,
            width=20,
            height=30,

            sourceX = 6,
            sourceY = 2,
            sourceWidth = 34,
            sourceHeight = 34
        },
        {
            -- star006@2x
            x=1410,
            y=964,
            width=20,
            height=30,

            sourceX = 6,
            sourceY = 2,
            sourceWidth = 34,
            sourceHeight = 34
        },
        {
            -- star007@2x
            x=958,
            y=982,
            width=16,
            height=32,

            sourceX = 8,
            sourceY = 0,
            sourceWidth = 34,
            sourceHeight = 34
        },
        {
            -- star008@2x
            x=2030,
            y=166,
            width=14,
            height=32,

            sourceX = 10,
            sourceY = 0,
            sourceWidth = 34,
            sourceHeight = 34
        },
        {
            -- star009@2x
            x=528,
            y=854,
            width=12,
            height=32,

            sourceX = 10,
            sourceY = 0,
            sourceWidth = 34,
            sourceHeight = 34
        },
        {
            -- star010@2x
            x=528,
            y=818,
            width=12,
            height=32,

            sourceX = 10,
            sourceY = 0,
            sourceWidth = 34,
            sourceHeight = 34
        },
        {
            -- star011@2x
            x=958,
            y=946,
            width=16,
            height=32,

            sourceX = 8,
            sourceY = 0,
            sourceWidth = 34,
            sourceHeight = 34
        },
        {
            -- star012@2x
            x=2022,
            y=860,
            width=20,
            height=34,

            sourceX = 6,
            sourceY = 0,
            sourceWidth = 34,
            sourceHeight = 34
        },
        {
            -- star013@2x
            x=2022,
            y=898,
            width=20,
            height=32,

            sourceX = 6,
            sourceY = 0,
            sourceWidth = 34,
            sourceHeight = 34
        },
        {
            -- star014@2x
            x=1790,
            y=1048,
            width=24,
            height=34,

            sourceX = 4,
            sourceY = 0,
            sourceWidth = 34,
            sourceHeight = 34
        },
        {
            -- star015@2x
            x=2002,
            y=1044,
            width=28,
            height=34,

            sourceX = 2,
            sourceY = 0,
            sourceWidth = 34,
            sourceHeight = 34
        },
        {
            -- star016@2x
            x=2014,
            y=972,
            width=30,
            height=34,

            sourceX = 2,
            sourceY = 0,
            sourceWidth = 34,
            sourceHeight = 34
        },
        {
            -- star017@2x
            x=2014,
            y=934,
            width=30,
            height=34,

            sourceX = 2,
            sourceY = 0,
            sourceWidth = 34,
            sourceHeight = 34
        },
        {
            -- star018@2x
            x=1876,
            y=514,
            width=34,
            height=32,

            sourceX = 0,
            sourceY = 0,
            sourceWidth = 34,
            sourceHeight = 34
        },
        {
            -- starCollect001@2x
            x=1932,
            y=320,
            width=112,
            height=116,

            sourceX = 30,
            sourceY = 44,
            sourceWidth = 180,
            sourceHeight = 180
        },
        {
            -- starCollect002@2x
            x=152,
            y=1880,
            width=132,
            height=144,

            sourceX = 24,
            sourceY = 14,
            sourceWidth = 180,
            sourceHeight = 180
        },
        {
            -- starCollect003@2x
            x=1256,
            y=800,
            width=102,
            height=116,

            sourceX = 40,
            sourceY = 32,
            sourceWidth = 180,
            sourceHeight = 180
        },
        {
            -- starCollect004@2x
            x=288,
            y=1880,
            width=122,
            height=126,

            sourceX = 30,
            sourceY = 24,
            sourceWidth = 180,
            sourceHeight = 180
        },
        {
            -- starCollect005@2x
            x=1128,
            y=404,
            width=150,
            height=176,

            sourceX = 14,
            sourceY = 0,
            sourceWidth = 180,
            sourceHeight = 180
        },
        {
            -- starCollect006@2x
            x=4,
            y=1880,
            width=144,
            height=158,

            sourceX = 14,
            sourceY = 10,
            sourceWidth = 180,
            sourceHeight = 180
        },
        {
            -- starCollect007@2x
            x=1476,
            y=1402,
            width=108,
            height=114,

            sourceX = 32,
            sourceY = 38,
            sourceWidth = 180,
            sourceHeight = 180
        },
        {
            -- starCollect008@2x
            x=1070,
            y=1410,
            width=106,
            height=108,

            sourceX = 28,
            sourceY = 36,
            sourceWidth = 180,
            sourceHeight = 180
        },
        {
            -- starCollect009@2x
            x=1362,
            y=578,
            width=88,
            height=92,

            sourceX = 40,
            sourceY = 42,
            sourceWidth = 180,
            sourceHeight = 180
        },
        {
            -- starCollect010@2x
            x=1068,
            y=1522,
            width=106,
            height=96,

            sourceX = 30,
            sourceY = 42,
            sourceWidth = 180,
            sourceHeight = 180
        },
        {
            -- starCollect011@2x
            x=1698,
            y=934,
            width=116,
            height=110,

            sourceX = 24,
            sourceY = 34,
            sourceWidth = 180,
            sourceHeight = 180
        },
        {
            -- starCollect012@2x
            x=462,
            y=818,
            width=62,
            height=60,

            sourceX = 56,
            sourceY = 60,
            sourceWidth = 180,
            sourceHeight = 180
        },
        {
            -- starCollect013@2x
            x=4,
            y=2042,
            width=2,
            height=2,

            sourceX = 0,
            sourceY = 0,
            sourceWidth = 180,
            sourceHeight = 180
        },
        {
            -- starGlow@2x
            x=1346,
            y=310,
            width=90,
            height=88,

            sourceX = 0,
            sourceY = 0,
            sourceWidth = 90,
            sourceHeight = 90
        },
        {
            -- starOff@2x
            x=1986,
            y=66,
            width=58,
            height=58,

        },
        {
            -- starOn@2x
            x=1986,
            y=4,
            width=58,
            height=58,

        },
        {
            -- sweetBreak_001@2x
            x=1992,
            y=1130,
            width=28,
            height=32,

            sourceX = 2,
            sourceY = 0,
            sourceWidth = 36,
            sourceHeight = 34
        },
        {
            -- sweetBreak_002@2x
            x=1834,
            y=584,
            width=32,
            height=34,

            sourceX = 2,
            sourceY = 0,
            sourceWidth = 36,
            sourceHeight = 34
        },
        {
            -- sweetBreak_003@2x
            x=1992,
            y=1200,
            width=26,
            height=34,

            sourceX = 6,
            sourceY = 0,
            sourceWidth = 36,
            sourceHeight = 34
        },
        {
            -- sweetBreak_004@2x
            x=462,
            y=882,
            width=26,
            height=22,

            sourceX = 4,
            sourceY = 6,
            sourceWidth = 36,
            sourceHeight = 34
        },
        {
            -- sweetBreak_005@2x
            x=1982,
            y=128,
            width=50,
            height=34,

            sourceX = 0,
            sourceY = 0,
            sourceWidth = 49,
            sourceHeight = 33
        },
        {
            -- sweetMain@2x
            x=1086,
            y=1724,
            width=100,
            height=98,

            sourceX = 6,
            sourceY = 8,
            sourceWidth = 106,
            sourceHeight = 106
        },
        {
            -- sweetShine_001@2x
            x=1030,
            y=1828,
            width=100,
            height=98,

            sourceX = 6,
            sourceY = 8,
            sourceWidth = 106,
            sourceHeight = 106
        },
        {
            -- sweetShine_002@2x
            x=982,
            y=1726,
            width=100,
            height=98,

            sourceX = 6,
            sourceY = 8,
            sourceWidth = 106,
            sourceHeight = 106
        },
        {
            -- sweetShine_003@2x
            x=928,
            y=1946,
            width=100,
            height=98,

            sourceX = 6,
            sourceY = 8,
            sourceWidth = 106,
            sourceHeight = 106
        },
        {
            -- sweetShine_004@2x
            x=878,
            y=1736,
            width=100,
            height=98,

            sourceX = 6,
            sourceY = 8,
            sourceWidth = 106,
            sourceHeight = 106
        },
        {
            -- sweetShine_005@2x
            x=774,
            y=1736,
            width=100,
            height=98,

            sourceX = 6,
            sourceY = 8,
            sourceWidth = 106,
            sourceHeight = 106
        },
        {
            -- sweetShine_006@2x
            x=782,
            y=1634,
            width=100,
            height=98,

            sourceX = 6,
            sourceY = 8,
            sourceWidth = 106,
            sourceHeight = 106
        },
        {
            -- sweetShine_007@2x
            x=886,
            y=1624,
            width=100,
            height=98,

            sourceX = 6,
            sourceY = 8,
            sourceWidth = 106,
            sourceHeight = 106
        },
        {
            -- sweetShine_008@2x
            x=782,
            y=1532,
            width=100,
            height=98,

            sourceX = 6,
            sourceY = 8,
            sourceWidth = 106,
            sourceHeight = 106
        },
        {
            -- sweetShine_009@2x
            x=1068,
            y=1622,
            width=100,
            height=98,

            sourceX = 6,
            sourceY = 8,
            sourceWidth = 106,
            sourceHeight = 106
        },
        {
            -- sweetShine_010@2x
            x=1178,
            y=1600,
            width=100,
            height=98,

            sourceX = 6,
            sourceY = 8,
            sourceWidth = 106,
            sourceHeight = 106
        },
        {
            -- worldLocked@2x
            x=852,
            y=584,
            width=506,
            height=212,

            sourceX = 0,
            sourceY = 0,
            sourceWidth = 505,
            sourceHeight = 212
        },
        {
            -- worldOven1@2x
            x=482,
            y=952,
            width=472,
            height=576,

            sourceX = 2,
            sourceY = 0,
            sourceWidth = 474,
            sourceHeight = 576
        },
        {
            -- worldOven2@2x
            x=654,
            y=4,
            width=470,
            height=576,

            sourceX = 4,
            sourceY = 0,
            sourceWidth = 475,
            sourceHeight = 576
        },
        {
            -- worldOven3@2x
            x=176,
            y=4,
            width=474,
            height=576,

            sourceX = 2,
            sourceY = 0,
            sourceWidth = 475,
            sourceHeight = 576
        },
        {
            -- worldOven4@2x
            x=4,
            y=954,
            width=474,
            height=576,

            sourceX = 2,
            sourceY = 0,
            sourceWidth = 475,
            sourceHeight = 576
        },
    },
    
    sheetContentWidth = 2048,
    sheetContentHeight = 2048
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
