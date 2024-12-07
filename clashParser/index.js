#!/usr/bin/env node

const yaml = require('js-yaml');
const fs = require('fs');
const clashParser = require('./clashNew.js');

async function processConfig(configPath) {
  try {
    // 读取配置文件
    const rawConfig = fs.readFileSync(configPath, 'utf8');
    const config = yaml.load(rawConfig);
    
    // 使用 clashParser 处理配置
    const processedConfig = clashParser(config);
    
    // 将处理后的配置转换回 yaml
    const outputYaml = yaml.dump(processedConfig, {
      indent: 2,
      lineWidth: -1  // 禁用行宽限制
    });
    
    // 输出到新文件
    const outputPath = configPath.replace('.yml', '.processed.yml');
    fs.writeFileSync(outputPath, outputYaml, 'utf8');
    
    console.log(`配置已处理完成，输出到: ${outputPath}`);
    return outputPath;
  } catch (error) {
    console.error('处理配置时出错:', error);
    throw error;
  }
}

// 使用示例
if (require.main === module) {
  const configPath = process.argv[2] || './Proxy.yml'; // 允许通过命令行参数指定文件路径
  processConfig(configPath).catch(console.error);
}

module.exports = {
  processConfig
};