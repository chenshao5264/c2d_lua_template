--
-- Author: Chen
-- Date: 2017-11-17 15:16:49
-- Brief: 
--

local gg         = gg
local ggDialog   = gg.Dialog
local ggUIHelper = gg.UIHelper

local BaseController = require('controllers.BaseController')
local M = class("LoginController", BaseController)

--// step1
function M:ctor()
    self.super.ctor(self, "LoginLayer")
end


--// step3_1
--// 关联画布上的元素
function M:onRelateViewElements()
    self._btnLogin = self.resNode:getChildByName("Button_Login")
    self._btnLogin:onClick(function(obj)
        cclog.trace('click login')
    end)

    self._btnRegister = self.resNode:getChildByName("Button_Register")
    self._btnRegister:onClick(function(obj)
        cclog.trace('click register')
        ggUIHelper:showDialog(ggDialog.RegisterDialog)
    end)
end

--// 监听视图数据更新UI
function M:onRegisterEventProxy()
    cc.EventProxy.new(MyApp, self)
        :on("evt_PL_PHONE_LC_LOGIN_ACK_P", function(evt)
            local data = evt.data
            
        end)
end


function M:onEnter()
    self.super.onEnter(self)
    --// todo
    --// ...
end

function M:onExit()
    --// todo
    --// ...
    self.super.onExit(self)
end

return M