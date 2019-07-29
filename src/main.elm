import Browser

import Model as Model
import Update as Update
import View.Main as View
import Ports as Ports

type alias Flags = {}

init : Flags -> ( Model.Model, Cmd Update.Msg )
init flags =
  ( { script = "inited"
    , parsed = Nothing
    }
    , Cmd.none
  )

subscriptions : Model.Model -> Sub Update.Msg
subscriptions _ =
  Ports.scriptParsed Update.ScriptParsed

main =
  Browser.element
    { init = init
    , update = Update.update
    , view = View.view
    , subscriptions = subscriptions
    }
