--
-- Author: Chen
-- Date: 2017-09-22 09:53:35
-- Brief: 
--


local WebSocket = require("app.network.ws.web_socket")

local WSAgent = class("WSAgent")

function WSAgent:ctor()
    self._ws = nil
    
end

function WSAgent:connect(ip, port)
    if self._ws then
        printLog("WSAgent", "ws已连接")
        return
    end
    self._ws = WebSocket.new(string.format("ws://%s:%d", ip, port))
    self._ws:addEventListener(WebSocket.OPEN_EVENT, handler(self, self.onOpen))
    self._ws:addEventListener(WebSocket.MESSAGE_EVENT, handler(self, self.onMessage))
    self._ws:addEventListener(WebSocket.CLOSE_EVENT, handler(self, self.onClose))
    self._ws:addEventListener(WebSocket.ERROR_EVENT, handler(self, self.onError))
end

function WSAgent:onOpen()
    printLog("WSAgent", "onOpen")

    self._ws:send("client: hello server")
end

function WSAgent:onMessage(event)
    printLog("WSAgent", "onMessage: %s", event.message)
end

function WSAgent:onClose()
    printLog("WSAgent", "onClose")
end

function WSAgent:onError(event)
    printLog("WSAgent", "onError: %s", event.error)
end


return WSAgent