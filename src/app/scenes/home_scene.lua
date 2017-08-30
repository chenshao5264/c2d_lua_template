--
-- Author: Chen
-- Date: 2017-08-24 11:44:26
-- Brief: HomeScene
--
local BaseScene = require('app.scenes.base_scene')
local HomeScene = class("HomeScene", BaseScene)

function HomeScene:ctor(...)
    self.super.ctor(self)
    --// todo
    --// ...

    local tModel, tView, tController = myApp:createMVC(gMvcConfigs.template)
    tController:bindView(tView)
    tController:bindModel(gkModel.PLAYER, tModel)

    self:addChild(tView, 1)
    self:addChild(tController, 1)
end

function HomeScene:onInit()
    self.super.onInit(self)
    --// todo
    --// ...
end

function HomeScene:onEnter()
    self.super.onEnter(self)
    --// todo
    --// ...

end

function HomeScene:onEnterTransitionFinish()
    self.super.onEnterTransitionFinish(self)

    --// todo
    --// ...
end

function HomeScene:onExit()
    --// todo
    --// ...

    self.super.onExit(self)
end

function HomeScene:onCleanup()
    --// todo
    --// ...

    self.super.onCleanup(self)
end

return HomeScene