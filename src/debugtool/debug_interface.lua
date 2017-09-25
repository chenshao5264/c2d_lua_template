--
-- Author: Chen
-- Date: 2017-09-18 17:32:28
-- Brief: 
--



LOGGER_LEVEL_TEXT_COLOR = {
    [0] = cc.c4b(255, 255, 255, 255),
    cc.c4b(0,   0,   255, 255),         --// 蓝
    cc.c4b(0,   255, 255, 255),         --// 青
    cc.c4b(0,   255, 0,   255),         --// 绿
    cc.c4b(255, 255, 0,   255),         --// 黄
    cc.c4b(255, 0,   0,   255),         --// 红
    cc.c4b(128, 0,   255, 203),         --// 粉
}

logger.setLevel(0)

logger.trace = logger.trace  --// level 1
logger.debug = logger.debug  --// level 2
logger.info  = logger.info   --// level 3
logger.warn  = logger.warn   --// level 4
logger.error = logger.error  --// level 5
logger.fatal = logger.fatal  --// level 6