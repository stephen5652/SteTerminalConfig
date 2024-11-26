module.exports.parse = async (
  raw,
  { axios, yaml, notify, console },
  { name, url, interval, selected },
) => {
  const parseResult = yaml.parse(raw);
  const keywords = ["美国", "us", "gpt"];
  const gptNodes = [];
  parseResult.proxies.forEach((proxy) => {
    const nodeName = proxy.name.toLowerCase();
    for (const keyword of keywords) {
      // if (nodeName.includes(keyword) && nodeName.includes("pro-")) {
      if (nodeName.includes(keyword)) {
        gptNodes.push(proxy);
        break;
      }
    }
  });

  // const autoSelectGroup = parseResult["proxy-groups"].find(
  //   (group) => group.name === "♻️ 自动选择"
  // );
  //
  // if (autoSelectGroup) {
  //   gptNodes.push(autoSelectGroup);
  // }

  const gptNodeGroup = {
    name: "ST-GPT-NODES",
    type: "url-test",
    url: "http://www.gstatic.com/generate_204",
    interval: "300",
    proxies: gptNodes.map((proxy) => proxy.name),
  };
  const proxyGroups = parseResult["proxy-groups"];

  if (!proxyGroups.some((group) => group.name === "GPT nodes")) {
    proxyGroups.push(gptNodeGroup);
  } else {
    proxyGroups.forEach((group) => {

      if (group.type === "select") {
        console.log("Updating 'GPT nodes' group...");
        group.type = "url-test";
        group.url = "http://www.gstatic.com/generate_204";
        group.interval = "300";
      }

      if (group.name === "ST-GPT-NODES") {
        group.proxies = gptNodeGroup.proxies;
      }
    });
  }

  proxyGroups.forEach((group) => {
    if (group.type === "select") {
      console.log("Updating 'select nodes' group...");
      group.type = "url-test";
      group.url = "http://www.gstatic.com/generate_204";
      group.interval = "300";
    }
  })

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
