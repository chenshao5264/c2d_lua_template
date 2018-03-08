--
-- Author: Chen
-- Date: 2017-09-12 17:06:47
-- Brief: 
--

local old_print    = print

local function checkArgType(arg)
    if type(arg) == "table" then
        local result = dump(arg, "table_table", 10)
        if result then
            arg = table.concat(result, "\n")
        else
            arg = ""
        end
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

local function checkArgType_(arg)
    if type(arg) == "table" then
        local result = dump(arg, "table_table", 10)
        if result then
            arg = table.concat(result, "<br/>\n")
        else
            arg = ""
        end
    else
        arg = tostring(arg)
    end

    return arg
end

local function concat_(...)
    local tb = {}
    for i=1, select('#', ...) do
        local arg = select(i, ...)  

        tb[#tb + 1] = checkArgType_(arg)
    end
    return table.concat(tb, "\t")
end

local color      = import(".color")
local colorPrint = color.colorPrint
local colors = {color.BLUE, color.CYAN, color.GREEN, color.YELLOW, color.RED, color.PURPLE}

local methods    = {"trace", "debug", "info", "warn", "error", "fatal"}
local levels = {ALL = 0}

local funcs = {}
local nop = function() end

for i, name in ipairs(methods) do
    local level_name = string.upper(name)
    levels[level_name] = i
    local tag = '['..level_name..']'
    funcs[name] = function(...)
        local date = os.date("[%H:%M:%S] ")
        local pntRet = date .. concat(...) .. "\n"
        colorPrint(colors[i], tag, pntRet)
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