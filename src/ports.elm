port module Ports exposing (scriptToParse, scriptParsed)

import Json.Decode as D

port scriptToParse : D.Value -> Cmd msg

port scriptParsed : (D.Value -> msg) -> Sub msg
