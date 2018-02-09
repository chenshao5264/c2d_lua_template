--
-- Author: Chen
-- Date: 2017-11-21 19:48:07
-- Brief: 
--


local TestView = class("TestView", function()
    return cc.Layer:create()
end)

function TestView:ctor()
   
    local function onKeyReleased(keyCode, event)
        if keyCode == 47 then
           
        end
    end


    local listener = cc.EventListenerKeyboard:create()
    listener:registerScriptHandler(onKeyReleased, cc.Handler.EVENT_KEYBOARD_RELEASED )

    local eventDispatcher = self:getEventDispatcher()
    eventDispatcher:addEventListenerWithSceneGraphPriority(listener, self)
end


return TestView