--
-- Author: Chen
-- Date: 2017-09-12 16:07:54
-- Brief: 
--

TAG_LOG_VIEW     = 0xff0001
TAG_BUTTON_DEBUG = 0xff0002

IS_WRITE_TO_FILE = false

--// 是否在app内开启debugview
local platform = cc.Application:getInstance():getTargetPlatform()
if platform == cc.PLATFORM_OS_WINDOWS then
    IS_DEBUG_VIEW = false
else
    IS_DEBUG_VIEW = false
end

import(".printLog")

import(".debug_interface")

import(".controller")

