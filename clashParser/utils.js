// 新建工具函数文件
export const filterGPTNodes = (proxies, keywords = ["美国", "us", "gpt"]) => {
  const gptNodes = [];
  proxies.forEach((proxy) => {
    const nodeName = proxy.name.toLowerCase();
    for (const keyword of keywords) {
      if (nodeName.includes(keyword)) {
        gptNodes.push(proxy);
        break;
      }
    }
  });
  return gptNodes;
};

export const createGPTGroup = (nodes, name = "ST-GPT-NODES") => {
  return {
    name,
    type: "url-test", 
    url: "http://www.gstatic.com/generate_204",
    interval: "300",
    proxies: nodes.map(proxy => proxy.name)
  };
};

export const updateProxyGroup = (group, options = {}) => {
  const defaults = {
    type: "url-test",
    url: "http://www.gstatic.com/generate_204",
    interval: "300"
  };
  
  return Object.assign(group, { ...defaults, ...options });
};

export const addRuleToTop = (rules, rule) => {
  if (Array.isArray(rules)) {
    rules.unshift(rule);
  }
  return rules;
}; 