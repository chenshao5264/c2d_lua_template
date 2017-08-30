--
-- Author: Chen
-- Date: 2017-08-24 14:03:03
-- Brief: 
--

local BaseView = class("BaseView", function()
    return cc.Node:create()
end)

function BaseView:ctor(nodePath)
    self:enableNodeEvents()
    self:onInit()

    self.root = cc.CSLoader:createNode(nodePath)
    self:addChild(self.root, 1)
end

function BaseView:onInit()
    self.root = nil --// csb根节点
end

function BaseView:onEnter()
end

function BaseView:onExit()
end

return BaseView