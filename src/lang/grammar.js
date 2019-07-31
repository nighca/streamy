// Generated automatically by nearley, version 2.17.0
// http://github.com/Hardmath123/nearley
(function () {
function id(x) { return x[0]; }

const moo = require("moo")

const lexer = moo.compile({
  space: { match: /\s+/, lineBreaks: true },
  comment: /\/\/.*?$/,
  '(':  '(',
  ')':  ')',
  '{': '{',
  '}': '}',
  ':': ':',
  ';': ';',
  keyword: ['while', 'if', 'else', 'switch', 'case'],
  word: /[^\s\(\)\{\}\:\;]+/
})

const meaningful = item => item != null

const extractMain = arr => ({
  type: 'main',
  children: arr[1]
})

const extractStatements = arr => ({
  type: 'statements',
  children: arr.filter(meaningful)
})

const appendStatements = arr => ({
  type: 'statements',
  children: [...arr[0].children, arr[2]].filter(meaningful)
})

const extractTextStatement = arr => ({
  type: 'textStatement',
  value: arr[0]
})

const extractBlockStatement = arr => arr[0]

const extractWhileStatement = arr => ({
  type: 'whileStatement',
  value: arr[4],
  children: [arr[10]]
})

const extractIfStatement = arr => ({
  type: 'ifStatement',
  value: arr[4],
  children: [arr[10]]
})

const extractIfElseStatement = arr => ({
  type: 'ifElseStatement',
  value: arr[4],
  children: [arr[10], arr[18]]
})

const extractSwitchStatement = arr => ({
  type: 'switchStatement',
  value: arr[4],
  children: arr[10]
})

const extractCaseStatement = arr => ({
  type: 'caseStatement',
  value: arr[2],
  children: [arr[6]]
})

const nuller = () => null

const appendItem = (listIndex, itemIndex) => arr => arr[listIndex].concat(arr[itemIndex]).filter(item => item != null)
var grammar = {
    Lexer: lexer,
    ParserRules: [
    {"name": "main", "symbols": ["_", "statements", "_"], "postprocess": extractMain},
    {"name": "statements", "symbols": ["statement"], "postprocess": extractStatements},
    {"name": "statements", "symbols": ["statements", "_", "statement"], "postprocess": appendStatements},
    {"name": "statement", "symbols": ["textStatement"], "postprocess": id},
    {"name": "statement", "symbols": ["whileStatement"], "postprocess": id},
    {"name": "statement", "symbols": ["ifStatement"], "postprocess": id},
    {"name": "statement", "symbols": ["ifElseStatement"], "postprocess": id},
    {"name": "statement", "symbols": ["switchStatement"], "postprocess": id},
    {"name": "statement", "symbols": [(lexer.has("comment") ? {type: "comment"} : comment)], "postprocess": nuller},
    {"name": "textStatement", "symbols": ["text", "_", {"literal":";"}], "postprocess": extractTextStatement},
    {"name": "whileStatement", "symbols": [{"literal":"while"}, "_", {"literal":"("}, "_", "text", "_", {"literal":")"}, "_", {"literal":"{"}, "_", "statements", "_", {"literal":"}"}], "postprocess": extractWhileStatement},
    {"name": "ifStatement", "symbols": [{"literal":"if"}, "_", {"literal":"("}, "_", "text", "_", {"literal":")"}, "_", {"literal":"{"}, "_", "statements", "_", {"literal":"}"}], "postprocess": extractIfStatement},
    {"name": "ifElseStatement", "symbols": [{"literal":"if"}, "_", {"literal":"("}, "_", "text", "_", {"literal":")"}, "_", {"literal":"{"}, "_", "statements", "_", {"literal":"}"}, "_", {"literal":"else"}, "_", {"literal":"{"}, "_", "statements", "_", {"literal":"}"}], "postprocess": extractIfElseStatement},
    {"name": "switchStatement", "symbols": [{"literal":"switch"}, "_", {"literal":"("}, "_", "text", "_", {"literal":")"}, "_", {"literal":"{"}, "_", "caseStatements", "_", {"literal":"}"}], "postprocess": extractSwitchStatement},
    {"name": "caseStatements", "symbols": ["caseStatement"]},
    {"name": "caseStatements", "symbols": ["caseStatements", "_", "caseStatement"], "postprocess": appendItem(0, 2)},
    {"name": "caseStatement", "symbols": [{"literal":"case"}, "_", "text", "_", {"literal":":"}, "_", "statements"], "postprocess": extractCaseStatement},
    {"name": "text", "symbols": [(lexer.has("word") ? {type: "word"} : word)], "postprocess": arr => arr[0].value},
    {"name": "text", "symbols": ["text", "_", (lexer.has("word") ? {type: "word"} : word)], "postprocess": arr => arr[0] + (arr[1] || '') + arr[2].value},
    {"name": "_", "symbols": []},
    {"name": "_", "symbols": [(lexer.has("space") ? {type: "space"} : space)], "postprocess": arr => arr[0].value}
]
  , ParserStart: "main"
}
if (typeof module !== 'undefined'&& typeof module.exports !== 'undefined') {
   module.exports = grammar;
} else {
   window.grammar = grammar;
}
})();
