--
-- Author: Chen
-- Date: 2017-09-12 16:07:54
-- Brief: 
--


IS_WRITE_TO_FILE = true

import(".printLog")


logger.setLevel(0)

logger.trace = logger.trace  --// level 1
logger.debug = logger.debug  --// level 2
logger.info  = logger.info   --// level 3
logger.warn  = logger.warn   --// level 4
logger.error = logger.error  --// level 5
logger.fatal = logger.fatal  --// level 6
