-- For iPads
if system.getInfo("model") == "iPad" or system.getInfo("model") == "iPad Simulator" then
        
        application = {
                content = {
                        width = 360,
                        height = 480,
                        scale = "zoomEven",
                        audioPlayFrequency="44100",
                        fps = 60,
                        imageSuffix = {
                            ["@2x"] = 2,
                                ["@4x"] = 4,
                        }
                }
        }
        
-- For "tall" sizes (iPhone 5 and new iTouch)
elseif display.pixelHeight > 960 then
 
        application = {
                content = {
                        width = 320,
                        height = 568, 
                        scale = "zoomEven",
                        audioPlayFrequency="44100",
                        fps = 60,
                        imageSuffix = {
                            ["@2x"] = 2,
                        }
                }
        }
 
else -- For traditional sizes (iPhone 4S & below, old iTouch)
 
        application = {
                content = {
                        width = 320,
                        height = 480, 
                        scale = "zoomEven",
                        audioPlayFrequency="44100",
                        fps = 60,
                        imageSuffix = {
                            ["@2x"] = 2,
                        }
                }
        }
                
end
