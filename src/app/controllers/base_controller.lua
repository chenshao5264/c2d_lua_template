--
-- Author: Chen
-- Date: 2017-08-24 18:06:58
-- Brief: 
--

local BaseController = class("BaseController", function()
    return cc.Node:create()
end)

function BaseController:ctor()
    self:enableNodeEvents()
    self:onInit()
end

-- /**
--  * 绑定控制器对应的视图
--  */
function BaseController:bindView(view)
    self._viewRoot = view.root

    self:onRelateViewElements()
end

-- /**
--  * 绑定控制器对应的数据模型
--  * 一个控制器可能对应多个数据模型
--  */
function BaseController:bindModel(field, model)
    if not self._models[field] then
        self._models[field] = model
        self:onFillData2UI()
        myApp:setModel(field, model)
    end
end

function BaseController:onInit()
    self._models = {}
end

function BaseController:onEnter()
    self:onRegisterEventProxy()
    self:onRegisterButtonClickEvent()
end

function BaseController:onExit()

end

return BaseController