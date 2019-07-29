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

const extractMain = arr => ({
  type: 'main',
  statements: arr[1]
})

const extractTextStatement = arr => ({
  type: 'textStatement',
  text: arr[0]
})

const extractBlockStatement = arr => ({
  type: 'blockStatement',
  block: arr[0]
})

const extractWhileBlock = arr => ({
  type: 'whileBlock',
  checkText: arr[4],
  body: arr[10]
})

const extractIfBlock = arr => ({
  type: 'ifBlock',
  checkText: arr[4],
  body: arr[10]
})

const extractIfElseBlock = arr => ({
  type: 'ifElseBlock',
  checkText: arr[4],
  trueBody: arr[10],
  elseBody: arr[18]
})

const extractSwitchBlock = arr => ({
  type: 'switchBlock',
  checkText: arr[4],
  cases: arr[10]
})

const extractCaseBlock = arr => ({
  type: 'caseBlock',
  checkText: arr[2],
  statements: arr[6]
})

const nuller = () => null

const appendItem = (listIndex, itemIndex) => arr => arr[listIndex].concat(arr[itemIndex]).filter(item => item != null)
var grammar = {
    Lexer: lexer,
    ParserRules: [
    {"name": "main", "symbols": ["_", "statements", "_"], "postprocess": extractMain},
    {"name": "statements", "symbols": ["statement"]},
    {"name": "statements", "symbols": ["statements", "_", "statement"], "postprocess": appendItem(0, 2)},
    {"name": "statement", "symbols": ["textStatement"], "postprocess": id},
    {"name": "statement", "symbols": ["blockStatement"], "postprocess": id},
    {"name": "statement", "symbols": [(lexer.has("comment") ? {type: "comment"} : comment)], "postprocess": nuller},
    {"name": "textStatement", "symbols": ["text", "_", {"literal":";"}], "postprocess": extractTextStatement},
    {"name": "blockStatement", "symbols": ["block"], "postprocess": extractBlockStatement},
    {"name": "block", "symbols": ["whileBlock"], "postprocess": id},
    {"name": "block", "symbols": ["ifBlock"], "postprocess": id},
    {"name": "block", "symbols": ["ifElseBlock"], "postprocess": id},
    {"name": "block", "symbols": ["switchBlock"], "postprocess": id},
    {"name": "whileBlock", "symbols": [{"literal":"while"}, "_", {"literal":"("}, "_", "text", "_", {"literal":")"}, "_", {"literal":"{"}, "_", "statements", "_", {"literal":"}"}], "postprocess": extractWhileBlock},
    {"name": "ifBlock", "symbols": [{"literal":"if"}, "_", {"literal":"("}, "_", "text", "_", {"literal":")"}, "_", {"literal":"{"}, "_", "statements", "_", {"literal":"}"}], "postprocess": extractIfBlock},
    {"name": "ifElseBlock", "symbols": [{"literal":"if"}, "_", {"literal":"("}, "_", "text", "_", {"literal":")"}, "_", {"literal":"{"}, "_", "statements", "_", {"literal":"}"}, "_", {"literal":"else"}, "_", {"literal":"{"}, "_", "statements", "_", {"literal":"}"}], "postprocess": extractIfElseBlock},
    {"name": "switchBlock", "symbols": [{"literal":"switch"}, "_", {"literal":"("}, "_", "text", "_", {"literal":")"}, "_", {"literal":"{"}, "_", "caseBlocks", "_", {"literal":"}"}], "postprocess": extractSwitchBlock},
    {"name": "caseBlocks", "symbols": ["caseBlock"]},
    {"name": "caseBlocks", "symbols": ["caseBlocks", "_", "caseBlock"], "postprocess": appendItem(0, 2)},
    {"name": "caseBlock", "symbols": [{"literal":"case"}, "_", "text", "_", {"literal":":"}, "_", "statements"], "postprocess": extractCaseBlock},
    {"name": "text", "symbols": [(lexer.has("word") ? {type: "word"} : word)], "postprocess": arr => arr[0].value},
    {"name": "text", "symbols": ["text", "_", (lexer.has("word") ? {type: "word"} : word)], "postprocess": arr => arr[0] + ' ' + arr[2].value},
    {"name": "_", "symbols": []},
    {"name": "_", "symbols": [(lexer.has("space") ? {type: "space"} : space)], "postprocess": nuller}
]
  , ParserStart: "main"
}
if (typeof module !== 'undefined'&& typeof module.exports !== 'undefined') {
   module.exports = grammar;
} else {
   window.grammar = grammar;
}
})();
