module Model exposing (Model)

import Lang.Tree as Tree

type alias Model =
  { script : String
  , parsed : Maybe Tree.Tree
  , error : Maybe String
  }
