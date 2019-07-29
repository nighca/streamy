module View.Main exposing (view)

import Html as Html
import Html.Attributes as Attr

import Update as Update
import Model as Model
import View.Editor as Editor
import View.Canvas as Canvas

view : Model.Model -> Html.Html Update.Msg
view model =
  Html.div [ Attr.class "view-index" ]
    [ Html.div
      [ Attr.class "editor-wrapprt" ]
      [ Html.h3 [] [ Html.text "Editor" ]
      , Editor.view model.script ]
    , Html.div
      [ Attr.class "canvas-wrapprt" ]
      [ Html.h3 [] [ Html.text "Canvas" ]
      , Canvas.view model.script ]
    ]
