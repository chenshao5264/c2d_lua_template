require "net.protocol.protocolPublic"

local packBody  = require "net.protocol.packBody"

local socketTCP = require "framework.net.SocketTCP"
local scheduler = require "framework.scheduler"
local ByteArray = require "framework.utils.ByteArray"

local clientConfig = clientConfig
local protocolNumber = gg.protocolNum

local ClientSocket = class("ClientSocket")


local MsgHandler = gg.MsgHandler

function ClientSocket:ctor()

    
    self._isQueuePause = false
    self._dataQueue = {}


    self:startDoMsgQueue()
end

function ClientSocket:startDoMsgQueue()
    
    local function doMsgProc()
        if self._isQueuePause then
            return
        end

        local msg = self._dataQueue[1]
        if not msg then
            return
        end
        table.remove(self._dataQueue, 1)

        local buffer = ByteArray.new():writeString(msg):setPos(1)
        local pack = packBody.new(buffer:readUInt(), buffer:readUInt(), buffer:readUShort(), buffer:readUInt(), buffer:readUInt())
        
        if MsgHandler[pack.opCode] then   
            cclog.debug("[recv msg from server] " ..pack.opCode)
            MsgHandler[pack.opCode](buffer)
        else

        end
    end

    scheduler.scheduleGlobal(doMsgProc, 0.1)
end

function ClientSocket:setIsQueuePause(flag)
    self._isQueuePause = flag
end

function ClientSocket:connect(stage)
    local _socket = self._socketLogin


    local function onConnected(__event)

    end

    local function onClosed(__event)
        print(stage .." connect closed.")
        print(string.format("socket status: %s", __event.name))


        if __event.socket == self._socketGame then
            
        elseif __event.socket == self._socketLobby then
            self._socketLobbyConnecting = false
        end
    end

    local function onConnectFailed(__event)
        print(stage .." connect failed.")
        print(string.format("socket status: %s", __event.name))
    end


    local function onData(__event)
        table.insert(self._dataQueue, __event.data)
    end

    _socket.eventProtocol:addEventListener(socketTCP.EVENT_CONNECTED, onConnected)
    _socket.eventProtocol:addEventListener(socketTCP.EVENT_CLOSED, onClosed)
    _socket.eventProtocol:addEventListener(socketTCP.EVENT_CONNECT_FAILURE, onConnectFailed)
    _socket.eventProtocol:addEventListener(socketTCP.EVENT_DATA, onData)

    _socket:connect()
end

--// 与login server创建socket连接
function ClientSocket:connectToLogin()
    if self._socketLogin then
        return
    end
    self._socketLogin = socketTCP.new(clientConfig.serverHost, clientConfig.serverPort, false)
    self:connect("login")
end

--// 断开login socket
function ClientSocket:disconnectFromLogin()
    if self._socketLogin then
        self._socketLogin:disconnect()
        self._socketLogin:close()
        self._socketLogin = nil
    end
end

--// 发送消息到loginserver
function ClientSocket:sendMsg2Login(pack)
    if not self._socketLogin then
        cclog.warn("self._socketLogin has disconnect!")
        return
    end
    if DEBUG == 2 then
        local buffer = ByteArray.new():writeString(pack):setPos(1)
        local pack = packBody.new(buffer:readUInt(), buffer:readUInt(), buffer:readUShort(), buffer:readUInt(), buffer:readUInt())
        cclog.debug("[send msg to login server] " ..pack.opCode)
    end
    self._socketLogin:send(pack)
end


return ClientSocket