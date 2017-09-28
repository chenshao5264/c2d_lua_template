### 介绍
基于mvc模式实现的一套简易coco2d-lua模版

### 引擎版本
cocos2d-x 3.6, quick-lua 2.5

### 目录结构
src
----- app
---------- configs      配置
---------- constant     游戏内部常量定义
---------- controller   视图控制器
---------- helper       游戏相关helper
---------- models       游戏数据模型
---------- network      网络相关
---------- scenes       游戏场景
---------- views        游戏视图
---- ccEx               cc的扩展
---- debugtool          日志sdk
---- utils              app相关工具,与游戏本身没有关系

#### scene, view, controller, model关系
scene中创建controller, view model
```
local mainView = myApp:createView(kView.XXX_VIEW)
self:addChild(mainView, 1)

local mainController = myApp:createView(kController.XXX_CONTROLLER)
self:addChild(mainController, 1)

local playModel = myApp:createModel(kModel.XXX_MODEL)

--// controller 与view, model绑定关系
mainController:bindView(mainView)
mainController:bindModel(playModel)

--// 多model对应一controller
-- mainController:bindModel("playModel", playModel)
```

#### 代码片段
sublime-snippets/下保存了常用的代码片段
> cnode.sublime-snippet         创建node
> model.sublime-snippet         创建model
> note.sublime-snippet          创建注释
> scene.sublime-snippet         创建scene
> touchlayer.sublime-snippet    创建触摸事件
> view.sublime-snippet          创建view

#### 功能
__1. 国际化__  
utils/i18n 和 app/helper/i18n_helper.lua

__2. http__  
utils/http_utils.lua

__3. shader__  
utils/shader_utils.lua

__4. 常用工具集__  
utils/utility.lua

__5. 日志__  
debugtool/  