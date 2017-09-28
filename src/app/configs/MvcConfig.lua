--
-- Author: Chen
-- Date: 2017-08-29 20:02:26
-- Brief: 
--


local kMVC = {
    template = {
        m = "player_model",
        v = "template_view",
        c = "SplashController",
    }
}

local kModel = {
    APP      = "AppModel",
    RESPONSE = "response_model",

}

local kView = {
    SplashView = "SplashView",
}

local kController = {
    SplashController = "SplashController",
}

return {kMVC = kMVC, kModel = kModel, kView = kView, kController = kController}