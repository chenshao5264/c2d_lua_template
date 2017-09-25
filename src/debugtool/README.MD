## logger工具
1. windows根据日志级别区分颜色
2. app内置日志浏览器
3. 浏览历史日志
4. 上传日志配合nodejs/http_upload服务器

### 运行环境
控制台颜色区分仅限于windows

### 用法
```
require('log.init')

print('log with print')
log.trace('log with debug')
log.info('log with info')
log.warn('log with warn')
log.error('log with error')
log.fatal('log with fatal')
```

### 日志路径
可写目录下的pnglogs/