--
-- Author: Your Name
-- Date: 2017-09-22 22:12:43
--
local BaseView = require('app.views.base_view')
local M = class("SplashView", BaseView)


function M:ctor()
    self.super.ctor(self)
    
    local sp = display.newSprite("rw.png")
    self:addChild(sp)
    sp:setPosition(display.cx, display.cy)
end

function M:onInit()
    self.super.onInit(self)
end

function M:onEnter()
    self.super.onEnter(self)
end

function M:onExit()
    self.super.onExit(self)
end

return M