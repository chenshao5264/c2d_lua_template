--
-- Author: Chen
-- Date: 2017-09-05 20:05:00
-- Brief: 
--

require("debugtool.init")

--// app通用配置
myApp.kCommon = require("app.configs.CommonConfig") 

--// cs画布配置
myApp.kCSB    = require("app.configs.CsbConfig") 

--// mvc配置
local mvc = require("app.configs.MvcConfig")
myApp.kMVC        = mvc.kMVC
myApp.kModel      = mvc.kModel
myApp.kView       = mvc.kView
myApp.kController = mvc.kController

--// 数据模型常量
myApp.kSchema = require("app.constant.SchemaConst")

--// 事件名称常量
myApp.kEvt    = require("app.constant.EvtConst")

--// 游戏中用到的常量
myApp.kDef  = require("app.constant.DefineConst")

--// 实用工具集
myApp.utility     = require("utils.utility")
--// shader
myApp.ShaderUtils = require("utils.ShaderUtils")
--// luaoc luaj
myApp.CrossHelper = require("app.helper.CrossHelper")
--// 本地化
myApp.i18n        = require("app.helper.I18nHelper")

myApp.LocalStore = require("utils.LocalStorage")

--// 定时器
myApp.scheduler = require("utils.scheduler")