module View.Canvas exposing (view)

import Html as Html
import Html.Attributes as Attr

import Update as Update

view : String -> Html.Html Update.Msg
view script =
  Html.p
    [ Attr.class "view-canvas" ]
    [ Html.text script ]
