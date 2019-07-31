module Lang.Tree exposing (..)

import Json.Decode as D

type alias Error = String

type alias Node =
  { type_ : String
  , value : Maybe String
  , children : Maybe Children
  }

type alias Tree = Node

type Children = Children (List Node)

decodeNode : D.Decoder Node
decodeNode =
  D.map3 Node
    (D.field "type" D.string)
    (D.maybe (D.field "value" D.string))
    (D.maybe (D.field "children" (D.map Children (D.list (D.lazy (\_ -> decodeNode))))))

decodeTree = decodeNode

extractTree : D.Value -> Result Error Tree
extractTree value =
  Result.mapError
    (D.errorToString)
    (D.decodeValue decodeTree value)

getChildrenNodes : Maybe Children -> List Node
getChildrenNodes maybeChildren =
  case maybeChildren of
    Nothing ->
      []
    Just children ->
      case children of
        Children nodes ->
          nodes
