
local MyApp = class("MyApp")

require "ccEx.init"

function MyApp:ctor()
    math.randomseed(os.time())
    cc(self):addComponent("ccEx.cc.components.behavior.EventProtocol"):exportMethods()

    self._objModels = {}

    
end

function MyApp:run()
    require("app.init")

    --// 初始化app model
    local appModel = self:createModel(self.kModel.APP)
    self:setModel(self.kModel.APP, appModel)

    local scene = require("app.scenes.loading_scene").new()
    display.runScene(scene)
end

-- /**
--  * 创建mvc
--  * @param mvcConfig 对应app/configs/mvc_config.lua
--  */
function MyApp:createMVC(mvcConfig)

    local m = self:createModel(mvcConfig.m)
    local v = self:createView(mvcConfig.v)
    local c = self:createController(mvcConfig.c)

    return m, v, c
end

-- /**
--  * 设置model的映射
--  */
function MyApp:setModel(field, obj)
    self._objModels[field] = obj
end

function MyApp:getModel(field)
    return self._objModels[field]
end

-- /**
--  * 所以视图由此创建
--  * @param ... 可能需要的必要参数
--  */
function MyApp:createView(viewName, ...)
    local view = require("app.views." ..viewName).new(...)

    return view
end

-- /**
--  * 所以控制器由此创建
--  * @param ... 可能需要的必要参数
--  */
function MyApp:createController(ctrlName, ...)
    local ctrl = require("app.controllers." ..ctrlName).new(...)
    return ctrl
end

-- /**
--  * 所以数据模型由此创建
--  * @param ... 可能需要的必要参数
--  */
function MyApp:createModel(modelName, ...)
    local model = require("app.models." ..modelName).new(...)
    return model
end

function MyApp:enterScene(sceneName, ...)
    local scene = require("app.scenes." ..sceneName).new(...)
    display.runScene(scene)
end

--// 协程调用
local cos = {}
function MyApp:dispatch(name)
    coroutine.resume(cos[name])
end

function MyApp:call(name, cb)
    cos[name] = coroutine.create(function()
        cb()
    end)
end

return MyApp
