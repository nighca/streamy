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
      case (Debug.log "tree result" (Tree.extractTree parsed)) of
        Err error ->
          ( { model
            | parsed = Nothing
            , error = Just error
            }
            , Cmd.none
          )
        Ok tree ->
          ( { model
            | parsed = Just tree
            , error = Nothing
            }
            , Cmd.none
          )
