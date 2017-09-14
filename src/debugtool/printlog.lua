--
-- Author: Chen
-- Date: 2017-09-12 17:06:47
-- Brief: 
--
local fileutils    = cc.FileUtils:getInstance()
local writablePath = device.writablePath
local old_print    = print

local function getLogDir()
    local dir = device.writablePath .. "/pntlog/" ..os.date("%Y%m%d/")
    if not fileutils:isDirectoryExist(dir) then
         fileutils:createDirectory(dir)
    end

    return dir
end

local function concat(...)
    local tb = {}
    for i=1, select('#', ...) do
        local arg = select(i, ...)  
        tb[#tb + 1] = tostring(arg)
    end
    return table.concat(tb, "\t")
end

local logFile
local function writeToFile(szStr)

    if not logFile then
        local fileName = string.format("%s.log", os.date("%H-%M-%S"))
        logFile = io.open(getLogDir() ..fileName, "a+")
        gCurLogFilePath = getLogDir() ..fileName

        local f = io.open(getLogDir() .."fileLists.txt", "a+")
        if f then
            f:write(fileName .."\n")
            f:close()
        end
    end
    
    local f = logFile
    if f then
        f:write(szStr)
        f:flush()
    else
        old_print("文件不存在")
    end
end

function print(...)
    local pntRet = os.date("[%H:%M:%S] ") .. concat(...) .. "\n"
    writeToFile(pntRet)

    old_print(...)
end

--//
LOGGER_LEVEL = {
    ALL   = 0,  
    TRACE = 1,
    INFO  = 2,
    WARN  = 3,
    ERROR = 4,
    FATAL = 5,
}

LOGGER_LEVEL_COLOR = {
    [0] = cc.c4b(255, 255, 255, 255),
    cc.c4b(0, 0, 255, 255),       --// 蓝
    cc.c4b(0, 255, 0, 255),       --// 绿
    cc.c4b(255, 255, 0, 255),     --// 黄
    cc.c4b(255, 0, 0, 255),       --// 红
    cc.c4b(255, 192, 0, 203),     --// 粉
}

logger = {}

logger.level = LOGGER_LEVEL.TRACE

-- level 1
logger.trace = function(...)
    if logger.level > LOGGER_LEVEL.TRACE then
        return
    end

    local pntRet = os.date("[%H:%M:%S] ") .."[TRACE] " .. concat(...) .. "\n"
    writeToFile(pntRet)

    old_print("[TRACE] " .. ...)
end

-- level 2
logger.info = function(...)
    if logger.level > LOGGER_LEVEL.INFO then
        return
    end

    local pntRet = os.date("[%H:%M:%S] ") .."[INFO] " .. concat(...) .. "\n"
    writeToFile(pntRet)

    old_print("[INFO] " .. ...)
end

-- level 3
logger.warn = function(...)
    if logger.level > LOGGER_LEVEL.WARN then
        return
    end

    local pntRet = os.date("[%H:%M:%S] ") .."[WARN] " .. concat(...) .. "\n"
    writeToFile(pntRet)

    old_print("[WARN] " .. ...)
end

-- level 4
logger.error = function(...)
    if logger.level > LOGGER_LEVEL.ERROR then
        return
    end

    local pntRet = os.date("[%H:%M:%S] ") .."[ERROR] " .. concat(...) .. "\n"
    writeToFile(pntRet)

    old_print("[ERROR] " .. ...)
end

-- level 5
logger.fatal = function(...)
    if logger.level > LOGGER_LEVEL.FATAL then
        return
    end

    local pntRet = os.date("[%H:%M:%S] ") .."[FATAL] " .. concat(...) .. "\n"
    writeToFile(pntRet)

    old_print("[FATAL] " .. ...)
end
