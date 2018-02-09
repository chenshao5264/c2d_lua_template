--
-- Author: Chen
-- Date: 2017-08-24 18:06:58
-- Brief: 
--

local BaseController = class("BaseController", function()
    return cc.Node:create()
end)

function BaseController:ctor(csb)
    self:enableNodeEvents()
    
    if csb then
        self.resNode = MyApp:createNode(csb)
        self:addChild(self.resNode, 1)

        self:onRelateViewElements()
    end
end

function BaseController:onEnterTransitionFinish()
    --// 进入场景动画
    if self.onEnterAnimation then
        self:onEnterAnimation()
    end
end

function BaseController:onEnter()
    self:onRegisterEventProxy()
end

function BaseController:onExit()

end

return BaseController