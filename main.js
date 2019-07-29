import { Elm } from './elm'
import { parse } from './src/lang'

const app = Elm.Main.init({
  node: document.getElementById('main')
})

app.ports.scriptToParse.subscribe(function(script) {
  const result = parse(script)
  console.log('parsed:', result)
  app.ports.scriptParsed.send(result)
})
