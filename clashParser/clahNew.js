// Clash Nyanpasu JavaScript Template
// Documentation on https://nyanpasu.elaina.moe/

export default function main(profile) {
  const proxy_keyword = "Pro-美国";

  // 筛选出包含 "Pro-美国" 的代理
  const keywords = ["美国", "us", "gpt"];
  const gptNodes = [];
  profile.proxies.forEach((proxy) => {
    const nodeName = proxy.name.toLowerCase();
    for (const keyword of keywords) {
      // if (nodeName.includes(keyword) && nodeName.includes("pro-")) {
      if (nodeName.includes(keyword)) {
        gptNodes.push(proxy);
        break;
      }
    }
  });

  // 创建一个新的代理组
  const gptGroup = {
    name: "🎬ChatGPT",
    type: "url-test",
    url: "http://www.gstatic.com/generate_204",
    interval: "300",
    proxies: gptNodes.map((proxy) => proxy.name),
  };

// 删除原来的 "🎬ChatGPT" 代理组
  profile['proxy-groups'] = profile['proxy-groups'].filter(
    (group) => group.name !== "🎬ChatGPT"
  );

  // 将新创建的代理组添加到 `proxy_groups` 中
  profile['proxy-groups'].push(gptGroup);

  return profile;
}
