--
-- Author: Your Name
-- Date: 2017-06-16 09:56:33
--
local TestView = class("TestView", cc.Layer)

function TestView:ctor()

   

	local function onKeyReleased(keyCode, event)
		
        if keyCode == 47 then
            if not g_logView then
            local logView = require("debugtool.log_view").new()
                logView:setPosition(0, 0)
                myApp:getRunningScene():addChild(logView, 0xffffff)
                g_logView = logView
                g_logView:hide()
            end

            if g_logView:isVisible() then
                g_logView:hide()
            else
                g_logView:show()
            end
        elseif keyCode == 48 then
           
        elseif keyCode == 49 then
           
        end
    end

    local listener = cc.EventListenerKeyboard:create()
    listener:registerScriptHandler(onKeyReleased, cc.Handler.EVENT_KEYBOARD_RELEASED )

    local eventDispatcher = self:getEventDispatcher()
    eventDispatcher:addEventListenerWithSceneGraphPriority(listener, self)

    --// Êó±êÊÂ¼þ
    local mouseListener = cc.EventListenerMouse:create()
    mouseListener:registerScriptHandler(function(event)
        
    end, cc.Handler.EVENT_MOUSE_DOWN)

    mouseListener:registerScriptHandler(function(event)
        
    end, cc.Handler.EVENT_MOUSE_UP)

    mouseListener:registerScriptHandler(function(event)

    end, cc.Handler.EVENT_MOUSE_MOVE)

    mouseListener:registerScriptHandler(function(event)
        
    end, cc.Handler.EVENT_MOUSE_SCROLL)

    local eventDispatcher = self:getEventDispatcher()
    eventDispatcher:addEventListenerWithSceneGraphPriority(mouseListener, self)

end

return TestView
