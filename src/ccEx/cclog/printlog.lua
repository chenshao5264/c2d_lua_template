--
-- Author: Chen
-- Date: 2017-09-12 17:06:47
-- Brief: 
--

local old_print    = print

local LOG_DIR_ROOT = cc.FileUtils:getInstance():getWritablePath() .."logs/"
if not cc.FileUtils:getInstance():isDirectoryExist(LOG_DIR_ROOT) then
    cc.FileUtils:getInstance():createDirectory(LOG_DIR_ROOT)
end


local HTML_COLOR = {"blue", "cyan", "green", "yellow", "red", "purple"}

local _thisFileName

local function write2File(color, str)


    if not _thisFileName then
        _thisFileName = LOG_DIR_ROOT ..os.date("%Y-%m-%d %H-%M-%S") .."-log.html"
    end

    local file = io.open(_thisFileName, "a+")
    if file then
        local content = os.date("%Y-%m-%d %H:%M:%S") ..": " ..str ..'\n'
        content = string.format("<font color=%s>%s</font><br/>\n", color, content)
        file:write(content)
        file:close()
    end
end


local function checkArgType(arg)
    if type(arg) == "table" then
        local result = dump(arg, "table_table", 10, 10086)
        arg = table.concat(result, "\n")
    else
        arg = tostring(arg)
    end

    return arg
end

local function concat(...)
    local tb = {}
    for i=1, select('#', ...) do
        local arg = select(i, ...)  

        tb[#tb + 1] = checkArgType(arg)
    end
    return table.concat(tb, "\t")
end

local color      = import(".color")
local colorPrint = color.colorPrint
local colors = {color.BLUE, color.CYAN, color.GREEN, color.YELLOW, color.RED, color.PURPLE}

local methods    = {"trace", "debug", "info", "warn", "error", "fatal"}
local levels = {ALL = 0}

cclog = {}

local funcs = {}
local nop = function() end

for i, name in ipairs(methods) do
    local level_name = string.upper(name)
    levels[level_name] = i
    local tag = '['..level_name..']'
    funcs[name] = function(...)
        local pntRet = os.date("[%H:%M:%S] ") .. concat(...) .. "\n"
        colorPrint(colors[i], tag, pntRet)
        write2File(HTML_COLOR[i], pntRet)
    end
end

function cclog.setLevel(lv)
    for i, funcname in ipairs(methods) do
        if i < lv then
            cclog[funcname] = nop
        else
            cclog[funcname] = funcs[funcname]
        end
    end
end