--
-- Author: Chen
-- Date: 2017-09-05 19:52:57
-- Brief: 
--
local BaseScene = require('app.scenes.BaseScene')
local M = class("LoadingScene", BaseScene)

local kView       = myApp.kView
local kController = myApp.kController

function M:ctor(...)
    self.super.ctor(self)
    --// todo
    --// ...

    local mainView = myApp:createView(kView.SplashView)
    self:addChild(mainView, 1)

    local mianCtrl = myApp:createController(kController.SplashController)
    self:addChild(mianCtrl, 1)

    mianCtrl:bindView(mainView)
end

function M:onInit()
    self.super.onInit(self)
    --// todo
    --// ...
end

function M:onEnter()
    self.super.onEnter(self)
    --// todo
    --// ...

    
end

function M:onEnterTransitionFinish()
    self.super.onEnterTransitionFinish(self)

    --// todo
    --// ...
end

function M:onExit()
    --// todo
    --// ...

    self.super.onExit(self)
end

function M:onCleanup()
    --// todo
    --// ...

    self.super.onCleanup(self)
end

return M