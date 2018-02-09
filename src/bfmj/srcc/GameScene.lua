--
-- Author: Chen
-- Date: 2017-11-17 10:31:35
-- Brief: 
--
local BaseScene = require('scenes.BaseScene')
local M = class("GameScene", BaseScene)

function M:ctor(...)
    self.super.ctor(self)
    --// todo
    --// ...
    
    local layTest = game:loadSource("TestView").new()
        :addTo(self)

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
    cc.EventProxy.new(MyApp, self)
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