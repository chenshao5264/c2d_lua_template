--
-- Author: Chen
-- Date: 2017-08-24 11:55:45
-- Brief: 所有scene的基类
--

local BaseScene = class("BaseScene", function()
    return cc.Scene:create()
end)

function BaseScene:ctor()
    self:enableNodeEvents()
    self:onInit()

    myApp:setRunningScene(self)

    local testView = require("app.TestView").new()
    self:addChild(testView, 1)
end

-- /**
--  * 用于变量声明定义
--  */
function BaseScene:onInit()

end

-- /**
--  * 进入场景
--  */
function BaseScene:onEnter()

end

-- /**
--  * 场景执行完过度动画
--  */
function BaseScene:onEnterTransitionFinish()

end

-- /**
--  * 退出场景
--  */
function BaseScene:onExit()

end

-- /**
--  * 完全退出场景
--  */
function BaseScene:onCleanup()
    
end

return BaseScene
