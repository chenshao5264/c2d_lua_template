--
-- Author: Chen
-- Date: 2017-09-14 19:56:16
-- Brief: 
--
local upload = {}

local shareScheduler = cc.Director:getInstance():getScheduler()
local math_floor = math.floor

local BUFSIZE    = 2^13

local function pathinfo(path)
    local pos = string.len(path)
    local extpos = pos + 1
    while pos > 0 do
        local b = string.byte(path, pos)
        if b == 46 then -- 46 = char "."
            extpos = pos
        elseif b == 47 then -- 47 = char "/" 
            break
        end
        pos = pos - 1
    end

    local dirname = string.sub(path, 1, pos)
    local filename = string.sub(path, pos + 1)
    extpos = extpos - pos
    local basename = string.sub(filename, 1, extpos - 1)
    local extname = string.sub(filename, extpos)
    return {
        dirname  = dirname or "",
        filename = filename or "",
        basename = basename or "",
        extname  = extname or "",
    }
end

function upload:init()
    self._uploading        = false --// 正在上传标志
    self._uploadBlockIndex = 0 --// 正在上传的块索引
    self.nScheduleId       = nil --// 上传启动的定时器
    self._tbBlocks         = {}
end

function upload:encodeURL(s)
    s = string.gsub(s, "([^%w%.%- ])", function(c) return string.format("%%%02X", string.byte(c)) end)
    return string.gsub(s, " ", "+")
end

function upload:httpencode(data)
    local newdata = ""
    local first = true
    for key,value in pairs(data) do
        if not first then 
            newdata = newdata .. "&"
        end
        first = false
        newdata = newdata .. key .. "=" .. self:encodeURL(value)
    end

    return newdata
end

function upload:send(data, callback)
    local xhr = cc.XMLHttpRequest:new()
    
    xhr:open('POST', "http://localhost:3000/upload?" ..self:httpencode(data))
    xhr.responseType = cc.XMLHTTPREQUEST_RESPONSE_STRING

    xhr:registerScriptHandler( function()
       if xhr.readyState == 4 and (xhr.status >= 200 and xhr.status < 207) then
            printLog('HttpUtils POST', 'response: %s', xhr.response)
            if callback then
                callback(xhr.response)
            end
        else
            printLog('HttpUtils POST', 'readyState: %s, status: %s', xhr.readyState, xhr.status)
            if callback then
                callback(false)
            end
        end
    end)

    xhr:send()
end

function upload:onUploadEvent(event)
    if self._uploadEventHandler then
        self._uploadEventHandler(event)
    end
end


function upload:upFileString(filePath)
    if self._uploading then
        return
    end
    local f = io.open(filePath, "r")
    if not f then
        return
    end
    filePath = string.gsub(filePath, "\\", "/")
    local fileinfo = pathinfo(filePath)

    self._uoloadDirName  = gCurDate
    self._uploadFileName = fileinfo.filename
    
    self._tbBlocks = {}
    while true do
        local block = f:read(BUFSIZE)
        if not block then
            break
        end
        self._tbBlocks[#self._tbBlocks + 1] = block
    end
    f:close()

    self:startScheduleUpload()
end

function upload:startScheduleUpload()
    self:onUploadEvent({state = "start"})
    self._uploading        = true
    self._uploadBlockIndex = 0
    self:stopScheduleUpload()
    self.nScheduleId = shareScheduler:scheduleScriptFunc(function()
        self:onScheduleUpload()
    end, 0, false)
end

function upload:stopScheduleUpload()
    if self.nScheduleId then
        shareScheduler:unscheduleScriptEntry(self.nScheduleId)
        self.nScheduleId = nil
    end
end

function upload:onScheduleUpload()
    if not self._uploading then
        return
    end

    self._uploadBlockIndex = self._uploadBlockIndex + 1

    local block = self._tbBlocks[self._uploadBlockIndex]
    if not block then
        self:stopScheduleUpload()
        return
    end

    local percent = self._uploadBlockIndex / #self._tbBlocks
    percent = math_floor(percent * 10000) / 100

    logger.info(percent)

    local data = {
        type     = 2,
        text     = block,
        dirname  = gCurDate,
        filename = self._uploadFileName,
        ishead   = (self._uploadBlockIndex == 1) and 1 or 0,
    }

    self:send(data, function(bSuccess)
        if not self._uploading then
            return
        end
        if not bSuccess then
            logger.info("上传失败")
            self:onUploadEvent({state = "finish", success = false})
            self:stopScheduleUpload()
            self._uploading = false
            return
        end
        local event = {
            state   = "uploading",
            percent = percent,
        }
        self:onUploadEvent(event)
        if percent >= 100 then
            logger.info("上传成功")
            self:onUploadEvent({state = "finish", success = true})
            self:stopScheduleUpload()
            self._uploading = false
        end
    end)
end

return upload