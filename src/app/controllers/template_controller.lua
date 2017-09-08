--
-- Author: Chen
-- Date: 2017-08-24 18:17:55
-- Brief: 
--

local BaseController = require('app.controllers.base_controller')
local M = class("TemplateController", BaseController)

local kEvt = myApp.kEvt

--// step1
function M:ctor()
    self.super.ctor(self)

end

--// step2
function M:onInit()
    self.super.onInit(self)
    --// todo
    --// ...
end

--// step3_1
--// 关联画布上的元素
function M:onRelateViewElements()
    self.textNickname = self._viewRoot:getChildByName("Text_nickname"):hide()

end

--// step3_2
--// 注册视图上的交互事件
function M:onRegisterButtonClickEvent()

end

--// step4
--// 根据model数据填充ui
function M:onFillData2UI()
    self.textNickname:setString(self._models["player"]._nickname)
end

--// 监听视图数据变化事件
function M:onRegisterEventProxy()
    cc.EventProxy.new(myApp, self)
        :on(kEvt.CHANGE_NAME, handler(self, self.onChangeNickname))
end

function M:onChangeNickname()

    self.textNickname:setString(self._models["player"]._nickname)
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