// #popclip extension for ChatGPT
// name: GPT Sensei
// icon: sparkles.svg
// language: javascript
// module: true
// entitlements: [network]
// options: [{
//   identifier: apikey, label: API Key, type: string,
//   description: 'Obtain API key from https://platform.openai.com/account/api-keys'
// }]
async function chat (input, options, lang) {
    const openai = require("axios").create({
      baseURL: "https://api.openai.com/v1",
      headers: { Authorization: `Bearer ${options.apikey}` },
    });
  
    let messages
    switch (lang) {
    case "grammar fix":
        messages = [
          {"role": "system", "content": "你是我的写作助手，检查接收到的文字的拼写、语法错误，对其进行润色，向我提供修改后的文字。"},
          {"role": "user", "content": `修改和润色下面的文字，直接输出修改后的结果，不需要额外的声明:\n${input.text}`}
        ]
        break;
    case "summarize":
        messages = [
          {"role": "system", "content": "You are an assistant helping summarize a document. "},
          {"role": "user", "content": `总结这段文字，直接输出总结后的结果，不需要额外的声明:\n${input.text}`}
        ]
        break;
    case "help me write":
        messages = [
          {"role": "system", "content": "You are an assistant helping a user write more content in a document based on a prompt. "},
          {"role": "user", "content": `帮我续写这段文字，直接输出续写后的结果，不需要额外的声明:\n${input.text}`}
        ]
        break;
    }
  
    const { data } = await openai.post("/chat/completions", {
      model: "gpt-3.5-turbo",
      messages,
    });
    const result = data.choices[0].message;
    return input.text.trimEnd() + "\n\n" + result.content.trim();
  };
  
  exports.actions = [
  {
    title: "Grammar Fix",
    icon: "aiFixSpellingGrammar.svg",
    after: "paste-result",
    code: async (input, options) => chat(input, options, "grammar fix"),
  },
  {
    title: "Summarize",
    icon: "assistSummarize.svg",
    after: "paste-result",
    code: async (input, options) => chat(input, options, "summarize"),
  },
  {
    title: "Help Me Write",
    icon: "assistContinueWriting.svg",
    after: "paste-result",
    code: async (input, options) => chat(input, options, "help me write"),
  }

];