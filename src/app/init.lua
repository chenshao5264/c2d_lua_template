--
-- Author: Chen
-- Date: 2017-09-05 20:05:00
-- Brief: 
--


require "debugtool.init"



--// app通用配置
myApp.kCommon = require("app.configs.common_config") 

--// cs画布配置
myApp.kCSB    = require("app.configs.csb_config") 

--// mvc配置
local mvc = require("app.configs.mvc_config")
myApp.kMVC        = mvc.kMVC
myApp.kModel      = mvc.kModel
myApp.kView       = mvc.kView
myApp.kController = mvc.kController

--// 数据模型常量
myApp.kSchema = require("app.constant.schema_const")

--// 事件名称常量
myApp.kEvt    = require("app.constant.evt_const")

--// 游戏中用到的常量
local def = require("app.constant.define_const")

--// 实用工具集
myApp.utility = require("utils.utility")

myApp.LocalStore = require("utils.local_store")

--// 定时器
myApp.scheduler = require("utils.scheduler")