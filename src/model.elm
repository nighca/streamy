module Model exposing (Model, init)

type alias Model =
  { script: String
  }

init : Model
init =
  { script = "inited"
  }
