module Update exposing (Msg (..), update)

import Json.Encode as E
import Debug as Debug

import Ports as Ports
import Model as Model
import Lang.Tree as Tree

type Msg = ScriptInput String
  | ScriptParsed E.Value

update : Msg -> Model.Model -> (Model.Model, Cmd Msg)
update msg model =
  case msg of
    ScriptInput newScript ->
      let
        _ = Debug.log "script" newScript
      in
      ( { model
        | script = newScript
        }
        , Ports.scriptToParse (E.string newScript)
      )
    ScriptParsed parsed ->
      case (Debug.log "main result" (Tree.extractMainFromJSONValue parsed)) of
        Err error ->
          ( { model
            | parsed = model.parsed
            , error = Just error
            }
            , Cmd.none
          )
        Ok main ->
          ( { model
            | parsed = Just main
            , error = Nothing
            }
            , Cmd.none
          )
