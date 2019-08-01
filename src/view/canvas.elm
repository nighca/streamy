module View.Canvas exposing (view)

import Html as Html
import Html.Attributes as Attr

import Update as Update
import Lang.Tree as Tree

view : Maybe Tree.Main -> Html.Html Update.Msg
view maybeMain =
  case maybeMain of
    Nothing ->
      Html.p [] [ Html.text "no result" ]
    Just (Tree.Main statements) ->
      Html.p
        [ Attr.class "view-canvas" ]
        [ Html.text (String.fromInt (List.length statements)) ]
