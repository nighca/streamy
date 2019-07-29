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
%}

@lexer lexer

main -> _ statements _ {% extractMain %}

statements -> statement
  | statements _ statement {% appendItem(0, 2) %}

statement -> textStatement {% id %}
  | blockStatement {% id %}
  | %comment {% nuller %}

textStatement -> text _ ";" {% extractTextStatement %}

blockStatement -> block {% extractBlockStatement %}

block -> whileBlock {% id %}
  | ifBlock {% id %}
  | ifElseBlock {% id %}
  | switchBlock {% id %}

whileBlock -> "while" _ "(" _ text _ ")" _ "{" _ statements _ "}" {% extractWhileBlock %}

ifBlock -> "if" _ "(" _ text _ ")" _ "{" _ statements _ "}" {% extractIfBlock %}

ifElseBlock -> "if" _ "(" _ text _ ")" _ "{" _ statements _ "}" _ "else" _ "{" _ statements _ "}" {% extractIfElseBlock %}

switchBlock -> "switch" _ "(" _ text _ ")" _ "{" _ caseBlocks _ "}" {% extractSwitchBlock %}

caseBlocks -> caseBlock
  | caseBlocks _ caseBlock {% appendItem(0, 2) %}

caseBlock -> "case" _ text _ ":" _ statements {% extractCaseBlock %}

text -> %word {% arr => arr[0].value %}
  | text _ %word {% arr => arr[0] + ' ' + arr[2].value %}

_ -> null | %space {% nuller %}
