module View.Canvas exposing (view)

import Html as Html
import Html.Attributes as Attr

import Update as Update
import Lang.Tree as Tree

view : Maybe Tree.Tree -> Html.Html Update.Msg
view maybeTree =
  case maybeTree of
    Nothing ->
      Html.p [] [ Html.text "no result" ]
    Just tree ->
      Html.p
        [ Attr.class "view-canvas" ]
        [ Html.text
          ( String.fromInt
            (List.length tree.statements)
          )
        ]
