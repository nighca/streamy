import nearley from 'nearley'
import grammar from './grammar'

export function parse(script) {
  const parser = new nearley.Parser(
    nearley.Grammar.fromCompiled(grammar)
  )
  parser.feed(script)
  return parser.results[0]
}
