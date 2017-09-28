--
-- Author: Chen
-- Date: 2017-09-26 13:51:11
-- Brief: 
--
local ConfigHelper = {}

    
local dict = {}

-- /**
--  * 从res/config/下读取json文件, 并缓存
--  * @param  filename 只需要basename
--  * @return table 
--  */
function ConfigHelper.loadFile(filename)

    if dict[filename] then
        return dict[filename]
    end

    local strConfig = cc.FileUtils:getInstance():getStringFromFile(string.format("config/%s.json", filename))
    if strConfig == "" then
        return {}
    end

    local tb = json.decode(strConfig)

    dict[filename] = tb

    return tb
end

-- /**
--  * 根据文件名删除缓存
--  * @param  filename 只需要basename
--  */
function ConfigHelper.removeOne(filename)
    dict[filename] = nil
end

-- /**
--  * 清空缓存
--  */
function ConfigHelper.clear()
    dict = {}
end

return ConfigHelper