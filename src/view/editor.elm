module View.Editor exposing (view)

import Html as Html
import Html.Events as Events
import Html.Attributes as Attr

import Update as Update

view : String -> Html.Html Update.Msg
view script =
  Html.div
    [ Attr.class "view-editor" ]
    [ Html.textarea
      [ Attr.class "input"
      , Attr.value script
      , Events.onInput Update.ScriptInput
      ]
      []
    ]
