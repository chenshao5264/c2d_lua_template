## Lua代码编写规范
此为cocos2d-x lua客户端开发团队遵循和约定的代码书写规范,意在提高代码的规范性和可维护性.
统一团队编码规范和风格,让所有代码都是有规可循的,并且能够得到沉淀,减少重复劳动.
cocos2d-x lua为例

#### 1 项目结构
```
---- app   
-------- scenes      // 场景        
-------- views       // 视图,基本由cocos studio创建
-------- controllers // 视图控制器
-------- models      // 数据处理
-------- tools       // app相关工具
-------- network     // 网络相关
-------- constant    // 常量定义
-------- configs     // 配置文件
-------- test        // 单元测试
---- cocos           // 引擎自带api
---- ccEx            // 对于cc的扩展
---- libs            // 第三方的库
---- utils           // app通用工具
```

#### 2 命名

##### 1.1 文件夹
统一使用小写字母

##### 1.2 文件名与类名
使用有意义的英文名字, 采用[大驼峰命名法](https://baike.baidu.com/item/%E9%AA%86%E9%A9%BC%E5%91%BD%E5%90%8D%E6%B3%95?fr=aladdin)
eg:
```
--// 文件名
SplashScene.lua
SplashView.lua 

--// 类名
SplashScene
SplashView
```

##### 1.3 变量名
* 使用有意义的英文名字,
* 变量第一个单词，使用变量类型区分
eg:
```
number:  nXXX
string:  strXXX
boolean: isXXX
table:   tbXXX
```
* 不要过度缩写, 让别人能快速理解你的代码为原则
eg:
```
local nError                // Good. 
local nCompletedConnection  // Good.

local nErr          // Bad.
local nCompConns    // Bad.
```

###### 1.3.1 局部变量
采用[骆驼式命名法](https://baike.baidu.com/item/%E9%AA%86%E9%A9%BC%E5%91%BD%E5%90%8D%E6%B3%95?fr=aladdin).
尽量使变量可以做到自我说明,无法做到的,隐晦的变量加上注释
eg:
```
local nCurSpeed   --// 当前速度
local strHeroName --// 英雄名字
```

###### 1.3.2 成员变量
成员变量加上前缀_, 人为约定为私有变量, 若有变量需被外部重现赋值, 使用setXXX函数封装, 便于后续维护
eg:
```
self._nAge      = 10
self._tbPlayers = {}
```

###### 1.3.3 函数名
采用动宾结构和[骆驼式命名法](https://baike.baidu.com/item/%E9%AA%86%E9%A9%BC%E5%91%BD%E5%90%8D%E6%B3%95?fr=aladdin)
eg:
```
getAge()
playAnimation()
```

###### 1.3.4 常量
使用全部大写, 单词间用_分割
eg:
```
YOUR_NAME    = XXXX
LAUNCH_SCENE = "SplashScene"
```

###### 1.3.5 控件命名
eg:
```
Button:             _btnXXX
Text:               _textXXX
Image:              _imgXXX
ListView:           _listViewXXX
ScrollView:         _scrollViewXXX
TextField:          _tfXXX
Checkbox:           _ckboxXXX
BitmapFontLabel:    _bfXXX
LoadingBar:         _barXXX
Slider:             _sliderXXX
Panel:              _layXXX
PageView:           _pageViewXXX
Node:               _nodeXXX
Sprite:             _spXXX
Lable:              _labelXXX
Editbox:            _editBoxXXX
```


#### 3 格式

##### 3.1 文件头说明
在文件开头使用如下格式,来说明该文件的内容,可以配合Sumlime Text和QuickDev快速实现
```
--
-- Author: xx
-- Date: 2012-12-12 12:12:12
-- Brief: [模块功能]
--
```

##### 3.2 空格还是制表符
* 只使用空格, 每次缩进4个空格.
* 使用空格进行缩进,不要使用tabs,设定编辑器tabs转为空格
* 编辑器的spaces设为4

##### 3.3 空格

###### 3.3.1 等号左右
eg:
```
local nAge = 10
```
###### 3.3.2 逗号后
eg:
```
doSomething(p1, p2, p3)
```
###### 3.3.3 待补充

##### 3.4 空行
* 函数之间使用空行隔开
* 同一函数内部,有条理使用空行
* 特补充

#### 3.5 新行
* 函数声明
* 变量声明
* return 单独为一行
* end 单独为一行
* 待补充


#### 4注释

##### 4.1 变量注释
紧跟变量名, 使用--//
eg:
```
local nCurSpeed = 10  --// 当前速度 
```

##### 4.2 函数注释
* 对外接口使用如下:
eg:
```
-- /**
--  * 淡出动画
--  * @param obj 执行动作主体
--  * @param time 执行动作时间
--  * return
--  */
function ActionHelper:fadeOut(obj, time)
end
```

* 私有函数在函数声明上一行:
eg:
```
--// ....
function M:doString()
end
```
或者使用对外接口形式

#### 5 类
* view类继承BaseView
* controller类继承BaseController
* model类继承BaseModel

###### 5.1 冒号(:)和点(.)
统一使用冒号(:)声明函数

#### 6 生产力工具推荐

##### 6.1 编辑器
Sublime Text 3, Visual Studio 2012/2015

##### 6.2 插件
```
1. QuickXDev        快速启动模拟器，和创建lua文件
2. Aligment         等号对齐
3. A Flie Coin      文件图标
4. SublimeLinter    语法检查
5. IMESupport       输入法框光标处显示
6. Pretty JSON      json格式化
```
##### 6.3 推荐字体
Source Code Pro

#### 7 相关技巧

##### 7.1 善用快捷键
```
1. ctrl + p         // 快速定位文件
2. ctrl + f         // 查找
3. F3               // 查找下一个
4. ctrl + g         // 快速定位到行
5. ctrl + r         // 定位函数
```

##### 7.2 代码片段
保存常用的[代码片段](http://www.jianshu.com/p/c828dea65e07)