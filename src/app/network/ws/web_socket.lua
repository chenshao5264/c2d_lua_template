--
-- Author: Chen
-- Date: 2017-08-30 19:43:34
-- Brief: 
--
local WebSocket = class("WebSocket")


WebSocket.OPEN_EVENT    = "open"
WebSocket.MESSAGE_EVENT = "message"
WebSocket.CLOSE_EVENT   = "close"
WebSocket.ERROR_EVENT   = "error"

function WebSocket:ctor(url)
    cc(self):addComponent("ccEx.cc.components.behavior.EventProtocol"):exportMethods()
    self.socket = cc.WebSocket:create(url)

    if self.socket then
        self.socket:registerScriptHandler(handler(self, self.onOpen), cc.WEBSOCKET_OPEN)
        self.socket:registerScriptHandler(handler(self, self.onMessage), cc.WEBSOCKET_MESSAGE)
        self.socket:registerScriptHandler(handler(self, self.onClose), cc.WEBSOCKET_CLOSE)
        self.socket:registerScriptHandler(handler(self, self.onError), cc.WEBSOCKET_ERROR)
    end
end

function WebSocket:isReady()
    return self.socket and self.socket:getReadyState() == cc.WEBSOCKET_STATE_OPEN
end

function WebSocket:send(data)
    if not self:isReady() then
        printError("WebSocket:send() - socket is't ready")
        return false
    end

    self.socket:sendString(tostring(data))

    return true
end

function WebSocket:close()
    if self.socket then
        self.socket:close()
        self.socket = nil
    end
    self:removeAllEventListeners()
end

function WebSocket:onOpen()
    printLog("WebSocket", "WebSocket:onOpen")
    self:dispatchEvent({name = WebSocket.OPEN_EVENT})
end

function WebSocket:onMessage(message)
    printLog("WebSocket", "WebSocket:onMessage")
    local params = {
        name    = WebSocket.MESSAGE_EVENT,
        message = message
    }

    self:dispatchEvent(params)
end

function WebSocket:onClose()
    printLog("WebSocket", "WebSocket:onClose")
    self:dispatchEvent({name = WebSocket.CLOSE_EVENT})
    self:close()
end

function WebSocket:onError(error)
    printLog("WebSocket", "WebSocket:onError")
    self:dispatchEvent({name = WebSocket.ERROR_EVENT, error = error})
end

return WebSocket