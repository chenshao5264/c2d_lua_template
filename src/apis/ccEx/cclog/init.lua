--
-- Author: Chen
-- Date: 2017-09-12 16:07:54
-- Brief: 
--


cc.exports.cclog = {}

require("cclog.printlog")


cclog.setLevel(0)


cclog.trace = cclog.trace  --// level 1
cclog.debug = cclog.debug  --// level 2
cclog.info  = cclog.info   --// level 3
cclog.warn  = cclog.warn   --// level 4
cclog.error = cclog.error  --// level 5
cclog.fatal = cclog.fatal  --// level 6


cclog.trace('trace trace trace')
cclog.debug('debug debug debug')
cclog.info('info info info')
cclog.warn('warn warn warn')
cclog.error('error error error')
cclog.fatal('fatal fatal fatal')