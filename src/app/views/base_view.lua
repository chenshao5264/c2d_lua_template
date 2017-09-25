--
-- Author: Chen
-- Date: 2017-08-24 14:03:03
-- Brief: 
--

local BaseView = class("BaseView", function()
    return cc.Node:create()
end)

function BaseView:ctor()
    self:enableNodeEvents()
    self:onInit()

    if not myApp.kCSB[self.__cname] then
        logger.error("没有设置csb，在configs/csb_config中设置")
        return
    end
    logger.debug("load csb name = " ..self.__cname)

    self.root = cc.CSLoader:createNode(myApp.kCSB[self.__cname])
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