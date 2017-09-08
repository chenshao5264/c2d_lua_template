--
-- Author: Chen
-- Date: 2017-08-24 18:18:01
-- Brief: 
--

local BaseView = require('app.views.base_view')
local M = class("TemplateView", BaseView)


function M:ctor()
    self.super.ctor(self, myApp.kCSB[self.__cname])
    
    local sp = display.newSprite("rw.png")
    self:addChild(sp)
    sp:setPosition(display.cx, display.cy)

    local ShaderHelper = require("app.helper.shader_helper")
    ShaderHelper:outline(sp, false, {ply = 5.0, color = ShaderHelper:convertColor3b(cc.c3b(1, 1, 0))})
    
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