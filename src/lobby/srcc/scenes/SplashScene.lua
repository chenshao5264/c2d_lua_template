--
-- Author: Chen
-- Date: 2017-09-05 19:52:57
-- Brief: 
--
local BaseScene = require('scenes.BaseScene')
local M = class("SplashScene", BaseScene)

local ClientSocket = gg.ClientSocket

function M:ctor(...)
    self.super.ctor(self)
    --// todo
    --// ...
    local resNode = MyApp:createNode("SplashLayer")
        :addTo(self, 1)

end

function M:onEnter()
    self.super.onEnter(self)
    --// todo
    --// ...
    
    cc.ScheduleManager:performWithDelay(self, function()
        MyApp:enterScene(LOGIN_SCENE, true)
    end, 0)
end

function M:onEnterTransitionFinish()
    self.super.onEnterTransitionFinish(self)

    --// todo
    --// ...
end

function M:onExit()
    --// todo
    --// ...

    --// 退出时删除定时器
    cc.ScheduleManager:removeAllByTarget(self)

    self.super.onExit(self)
end

function M:onCleanup()
    --// todo
    --// ...

    self.super.onCleanup(self)
end

return M