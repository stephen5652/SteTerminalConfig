const { filterGPTNodes, createGPTGroup } = require('./utils');

module.exports.parse = async (
  raw,
  { axios, yaml, notify, console },
  { name, url, interval, selected },
) => {
  const parseResult = yaml.parse(raw);
  
  // 使用工具函数
  const gptNodes = filterGPTNodes(parseResult.proxies);
  const gptNodeGroup = createGPTGroup(gptNodes);
  
  const proxyGroups = parseResult["proxy-groups"];

  if (!proxyGroups.some((group) => group.name === "GPT nodes")) {
    proxyGroups.push(gptNodeGroup);
  }

  // 合并代理组更新逻辑
  proxyGroups.forEach((group) => {
    // 更新所有 select 类型的组为 url-test
    if (group.type === "select") {
      Object.assign(group, {
        type: "url-test",
        url: "http://www.gstatic.com/generate_204",
        interval: "300"
      });
    }

    // 更新 ST-GPT-NODES 组的节点
    if (group.name === "ST-GPT-NODES") {
      group.proxies = gptNodeGroup.proxies;
    }
  });

  if (
    gptNodeGroup.proxies.length > 0 &&
    parseResult.rules &&
    Array.isArray(parseResult.rules)
  ) {
    parseResult.rules.unshift("DOMAIN-KEYWORD,openai,ST-GPT-NODES");
  }

  // DOMAIN-KEYWORD,openai,ST-GPT-NODES
  return yaml.stringify(parseResult);
};
