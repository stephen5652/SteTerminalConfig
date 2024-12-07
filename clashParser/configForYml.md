# Clash Nyanpasu 配置指南

## 基础配置
```yml
# 基础覆盖配置
filter__proxy-groups:
  when: 
    item.type == 'select'
  expr: 
    item.type = 'url-test'
    item.url = 'http://www.gstatic.com/generate_204'
    return item

prepend-rules:
  - 'DOMAIN-KEYWORD,github,🔰国外流量'
  - 'DOMAIN-KEYWORD,openai,ST-GPT-NODES'
```

## 进阶配置
```yml
# 自定义分组配置
custom-proxy-groups:
  - name: "ST-GPT-NODES"
    type: url-test
    url: http://www.gstatic.com/generate_204
    interval: 300
    proxies:
      - auto-select
      
# DNS 配置
dns:
  enable: true
  enhanced-mode: fake-ip
  nameserver:
    - 223.5.5.5
    - 119.29.29.29
```