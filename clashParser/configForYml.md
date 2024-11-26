在 clash-nyanpasu 可以使用如下yml，覆盖配置中的部分字段。
```yml
# Clash Nyanpasu Merge Template (YAML)
# Documentation on https://nyanpasu.elaina.moe/
# Set the default merge strategy to recursive merge. 
# Enable the old mode with the override__ prefix. 
# Use the filter__ prefix to filter lists (removing unwanted content). 
# All prefixes should support accessing maps or lists with a.b.c syntax.

filter__proxy-groups:
  when: 
    item.type == 'select'
  expr: 
    item.type = 'url-test'
    item.url = 'http://www.gstatic.com/generate_204'
    return item
prepend-rules :
 - 'DOMAIN-KEYWORD,github,🔰国外流量'
```
