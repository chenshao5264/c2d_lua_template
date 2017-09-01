--
-- Author: Chen
-- Date: 2017-08-24 18:18:01
-- Brief: 
--

local BaseView = require('app.views.base_view')
local TemplateView = class("TemplateView", BaseView)


function TemplateView:ctor()
    self.super.ctor(self, gCsbConfig[self.__cname])
    
    local sp = display.newSprite("rw.png")
    self:addChild(sp)
    sp:setPosition(display.cx, display.cy)


    
end

function TemplateView:onInit()
    self.super.onInit(self)
end

function TemplateView:onEnter()
    self.super.onEnter(self)
end

function TemplateView:onExit()
    self.super.onExit(self)
end

return TemplateView