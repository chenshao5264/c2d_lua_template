--
-- Author: Your Name
-- Date: 2017-06-16 09:56:33
--
local TestView = class("TestView", cc.Layer)

function TestView:ctor()

   

	local function onKeyReleased(keyCode, event)
		
        if keyCode == 47 then
            local player =  myApp:getModel(gkModel.PLAYER)

            player:setNickname("chenshao02")
        elseif keyCode == 48 then
           
        elseif keyCode == 49 then
           
        end
    end

    local listener = cc.EventListenerKeyboard:create()
    listener:registerScriptHandler(onKeyReleased, cc.Handler.EVENT_KEYBOARD_RELEASED )

    local eventDispatcher = self:getEventDispatcher()
    eventDispatcher:addEventListenerWithSceneGraphPriority(listener, self)
end

return TestView
