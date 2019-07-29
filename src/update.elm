module Update exposing (Msg (..), update)

import Debug as Debug

import Model as Model
-- import Tree as Tree

type Msg = ScriptInput String

update : Msg -> Model.Model -> Model.Model
update msg model =
  case msg of
    ScriptInput newScript ->
      let
        _ = Debug.log "script" newScript
        -- _ = Debug.log "node" (Tree.parse newScript)
      in
      { model
      | script = newScript
      }
