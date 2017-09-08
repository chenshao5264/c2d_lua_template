--
-- Author: Chen
-- Date: 2017-08-30 19:55:07
-- Brief: 
--

local WebSocket = require("app.network.ws.web_socket")

local WsConnect = class("WsConnect")

function WsConnect:ctor()
    self._ws = nil
    
end

function WsConnect:connect(ip, port)
    if self._ws then
        printLog("WsConnect", "ws已连接")
        return
    end
    self._ws = WebSocket.new(string.format("ws://%s:%d", ip, port))
    self._ws:addEventListener(WebSocket.OPEN_EVENT, handler(self, self.onOpen))
    self._ws:addEventListener(WebSocket.MESSAGE_EVENT, handler(self, self.onMessage))
    self._ws:addEventListener(WebSocket.CLOSE_EVENT, handler(self, self.onClose))
    self._ws:addEventListener(WebSocket.ERROR_EVENT, handler(self, self.onError))
end

function WsConnect:onOpen()
    printLog("WsConnect", "onOpen")

    self._ws:send("client: hello server")
end

function WsConnect:onMessage(event)
    printLog("WsConnect", "onMessage: %s", event.message)
end

function WsConnect:onClose()
    printLog("WsConnect", "onClose")
end

function WsConnect:onError(event)
    printLog("WsConnect", "onError: %s", event.error)
end

return WsConnect