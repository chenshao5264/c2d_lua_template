--
-- Author: Chen
-- Date: 2017-08-24 11:44:26
-- Brief: TemplateScene
--
local BaseScene = require('app.scenes.base_scene')
local M = class("TemplateScene", BaseScene)

function M:ctor(...)
    self.super.ctor(self)
    --// todo
    --// ...

    local tModel, tView, tController = myApp:createMVC(myApp.kMVC.template)
    tController:bindView(tView)
    tController:bindModel("player", tModel)

    self:addChild(tView, 1)
    self:addChild(tController, 1)
    
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