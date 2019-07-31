@{%
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
%}

@lexer lexer

main -> _ statements _ {% extractMain %}

statements -> statement {% extractStatements %}
  | statements _ statement {% appendStatements %}

statement -> textStatement {% id %}
  | whileStatement {% id %}
  | ifStatement {% id %}
  | ifElseStatement {% id %}
  | switchStatement {% id %}
  | %comment {% nuller %}

textStatement -> text _ ";" {% extractTextStatement %}

whileStatement -> "while" _ "(" _ text _ ")" _ "{" _ statements _ "}" {% extractWhileStatement %}

ifStatement -> "if" _ "(" _ text _ ")" _ "{" _ statements _ "}" {% extractIfStatement %}

ifElseStatement -> "if" _ "(" _ text _ ")" _ "{" _ statements _ "}" _ "else" _ "{" _ statements _ "}" {% extractIfElseStatement %}

switchStatement -> "switch" _ "(" _ text _ ")" _ "{" _ caseStatements _ "}" {% extractSwitchStatement %}

caseStatements -> caseStatement
  | caseStatements _ caseStatement {% appendItem(0, 2) %}

caseStatement -> "case" _ text _ ":" _ statements {% extractCaseStatement %}

text -> %word {% arr => arr[0].value %}
  | text _ %word {% arr => arr[0] + (arr[1] || '') + arr[2].value %}

_ -> null | %space {% arr => arr[0].value %}
