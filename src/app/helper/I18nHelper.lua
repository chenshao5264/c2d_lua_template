--
-- Author: Your Name
-- Date: 2017-09-24 18:18:13
--

local i18nHelper = {}

local i18n = require("libs.init")

local function load(language)
    language = language or device.language
    i18n.setLocale(language)

    local properties
    if i18n.getLocale() == "en" then
        properties = cc.FileUtils:getInstance():getStringFromFile("properties/en_US.properties")
    elseif i18n.getLocale() == "zh" then
        properties = cc.FileUtils:getInstance():getStringFromFile("properties/zh_CN.properties")
    end

    local tbProperties = json.decode(properties)
    i18n.load({[language] = tbProperties}) 
end

load()

function i18nHelper.reset(locale)
    i18n.reset()
    i18n.setLocale(locale)
    load(locale)
end

function i18nHelper.getString(key, params)
    if params and type(params) == "table" then
        return i18n.translate(key, params)
    else
        return i18n.translate(key)
    end
end

return i18nHelper