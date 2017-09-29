
-- 0 - disable debug info, 1 - less debug info, 2 - verbose debug info
DEBUG = 2

-- use framework, will disable all deprecated API, false - use legacy API
CC_USE_FRAMEWORK = true

-- show FPS on screen
CC_SHOW_FPS = true

-- disable create unexpected global variable
CC_DISABLE_GLOBAL = false

CONFIG_SCREEN_WIDTH = 1280
CONFIG_SCREEN_HEIGHT = 720

-- for module display
CC_DESIGN_RESOLUTION = {
    width = CONFIG_SCREEN_WIDTH,
    height = CONFIG_SCREEN_HEIGHT,
    autoscale = "FIXED_HEIGHT",
    callback = function(framesize)
        local ratio = framesize.width / framesize.height
        if ratio <= 1.34 then
            -- iPad 768*1024(1536*2048) is 4:3 screen
            return {autoscale = "FIXED_HEIGHT"}
        end
    end
}

USER_PROTOBUF = false

-- env
APP_ENV = "DEVELOP"
--APP_ENV = "TEST"
--APP_ENV = "PUBLISH"


LAUNCH_SCENE = "SplashScene"

