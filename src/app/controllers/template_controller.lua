--
-- Author: Chen
-- Date: 2017-08-24 18:17:55
-- Brief: 
--

local BaseController = require('app.controllers.base_controller')
local TemplateController = class("TemplateController", BaseController)

--// step1
function TemplateController:ctor()
    self.super.ctor(self)

end

--// step2
function TemplateController:onInit()
    self.super.onInit(self)
    --// todo
    --// ...
end

--// step3_1
--// 关联画布上的元素
function TemplateController:onRelateViewElements()
    self.textNickname = self._viewRoot:getChildByName("Text_nickname")

end

--// step3_2
--// 注册视图上的交互事件
function TemplateController:onRegisterButtonClickEvent()

end

--// step4
--// 根据model数据填充ui
function TemplateController:onFillData2UI()
    self.textNickname:setString(self._models["player"]._nickname)
end

--// 监听视图数据变化事件
function TemplateController:onRegisterEventProxy()
    cc.EventProxy.new(myApp, self)
        :on(gkEvt.CHANGE_NAME, handler(self, self.onChangeNickname))
end

function TemplateController:onChangeNickname()

    self.textNickname:setString(self._models[gkModel.PLAYER]._nickname)
end

function TemplateController:onEnter()
    self.super.onEnter(self)
    --// todo
    --// ...
end

function TemplateController:onExit()
    --// todo
    --// ...
    self.super.onExit(self)
end

return TemplateController