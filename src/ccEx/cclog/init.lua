--
-- Author: Chen
-- Date: 2017-09-12 16:07:54
-- Brief: 
--


import(".printLog")

cclog.setLevel(0)

cclog.trace = cclog.trace  --// level 1
cclog.debug = cclog.debug  --// level 2
cclog.info  = cclog.info   --// level 3
cclog.warn  = cclog.warn   --// level 4
cclog.error = cclog.error  --// level 5
cclog.fatal = cclog.fatal  --// level 6
