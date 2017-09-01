--
-- Author: Chen
-- Date: 2017-08-30 19:55:07
-- Brief: 
--
local WsClient = class("WsClient")

local WebSocket = require("app.network.ws_client")

function WsClient:ctor()

    
end

function WsClient:connect()
    if not self._ws then
        printLog("WsClient", "ws已连接")
        return
    end
    self._ws = WebSocket.new("http://127.0.0.1:3000")
    self._ws:on(WebSocket.OPEN_EVENT, handler(self, self.onOpen))
    self._ws:on(WebSocket.MESSAGE_EVENT, handler(self, self.onMessage))
    self._ws:on(WebSocket.CLOSE_EVENT, handler(self, self.onClose))
    self._ws:on(WebSocket.ERROR_EVENT, handler(self, self.onError))
end

function WsClient:onOpen()
    printLog("WsClient", "onOpen")
end

function WsClient:onMessage(event)
    printLog("WsClient", "onMessage: %s", event.message)
end

function WsClient:onClose()
    printLog("WsClient", "onClose")
end

function WsClient:onError(event)
    printLog("WsClient", "onError: %s", event.error)
end

return WsClient