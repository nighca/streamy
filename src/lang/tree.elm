module Lang.Tree exposing (..)

import Json.Decode as D
import Result.Extra as ResultExtra

type alias Error = String

type alias Node =
  { type_ : String
  , value : Maybe String
  , children : Maybe Children
  }

type Children = Children (List Node)

decodeNode : D.Decoder Node
decodeNode =
  D.map3 Node
    (D.field "type" D.string)
    (D.maybe (D.field "value" D.string))
    (D.maybe (D.field "children" (D.map Children (D.list (D.lazy (\_ -> decodeNode))))))

getValue : Node -> Result Error Text
getValue node =
  case node.value of
    Nothing -> Err "invalid value"
    Just str -> Ok str

getChildNodes : Node -> List Node
getChildNodes node =
  case node.children of
    Nothing ->
      []
    Just children ->
      case children of
        Children nodes ->
          nodes

getChildNode : Int -> Node -> Result Error Node
getChildNode index node =
  getAt index (getChildNodes node)

type alias Text = String

type Statement = TextStatement Text
  | WhileStatement String Statements
  | IfStatement String Statements
  | IfElseStatement String Statements Statements
  | SwitchStatement String CaseStatements

type alias Statements = List Statement

type alias CaseStatements = List CaseStatement

type CaseStatement = CaseStatement String Statements

type Main = Main Statements

extractStatement : Node -> Result Error Statement
extractStatement node =
  let
    childNodes = getChildNodes node
    statementsResults = List.map extractStatements childNodes
  in
    case node.type_ of
      "textStatement" ->
        Result.map
          TextStatement
          (getValue node)
      "whileStatement" ->
        let
          textResult = getValue node
          statementsResult = getResultAt 0 statementsResults
        in
          Result.map2 WhileStatement textResult statementsResult
      "ifStatement" ->
        let
          textResult = getValue node
          statementsResult = getResultAt 0 statementsResults
        in
          Result.map2 IfStatement textResult statementsResult
      "ifElseStatement" ->
        let
          textResult = getValue node
          truthyStatementsResult = getResultAt 0 statementsResults
          falsyStatementsResult = getResultAt 1 statementsResults
        in
          Result.map3
            IfElseStatement
            textResult
            truthyStatementsResult
            falsyStatementsResult
      "switchStatement" ->
        let
          textResult = getValue node
          caseStatementResults = List.map extractCaseStatement childNodes
          caseStatementsResult = ResultExtra.combine caseStatementResults
        in
          Result.map2
            SwitchStatement
            textResult
            caseStatementsResult
      _ -> Err "invalid statement node"

extractStatements : Node -> Result Error Statements
extractStatements node =
  case node.type_ of
    "statements" ->
      ResultExtra.combine
        (List.map extractStatement (getChildNodes node))
    _ -> Err "invalid statements node"

extractCaseStatement : Node -> Result Error CaseStatement
extractCaseStatement node =
  case node.type_ of
    "caseStatement" ->
      let
        textResult = getValue node
        statementsResult =
          Result.andThen
            extractStatements
            (getChildNode 0 node)
      in
        Result.map2
          CaseStatement
          textResult
          statementsResult
    _ -> Err "invalid caseStatement node"

extractMain : Node -> Result Error Main
extractMain node =
  case node.type_ of
    "main" ->
      let
        childNodes = getChildNodes node
        statementsResults = List.map extractStatements childNodes
        statementsResult = getResultAt 0 statementsResults
      in
        Result.map
          Main
          statementsResult
    _ -> Err "invalid main node"

extractMainFromJSONValue : D.Value -> Result Error Main
extractMainFromJSONValue value =
  let
    nodeResult =
      Result.mapError
        (\err -> "decode value failed: " ++ (D.errorToString err))
        (D.decodeValue decodeNode value)
  in
    Result.andThen extractMain nodeResult

getAt : Int -> List a -> Result Error a
getAt index list =
  case List.head (List.drop index list) of
    Nothing ->
      Err ("invalid member at index " ++ String.fromInt(index))
    Just item ->
      Ok item

getResultAt : Int -> List (Result Error a) -> Result Error a
getResultAt index list =
  case getAt index list of
    Ok result -> result
    Err error -> Err error
