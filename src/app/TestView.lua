--
-- Author: Your Name
-- Date: 2017-06-16 09:56:33
--
local TestView = class("TestView", cc.Layer)

function TestView:ctor()

   

	local function onKeyReleased(keyCode, event)
		
        if keyCode == 47 then
            
            myApp:runScene("loading_scene")
        elseif keyCode == 48 then
            
        end
    end

    local listener = cc.EventListenerKeyboard:create()
    listener:registerScriptHandler(onKeyReleased, cc.Handler.EVENT_KEYBOARD_RELEASED )

    local eventDispatcher = self:getEventDispatcher()
    eventDispatcher:addEventListenerWithSceneGraphPriority(listener, self)

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
