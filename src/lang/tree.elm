module Lang.Tree exposing (Tree, extractTree)

import Json.Decode as D

type alias Tree =
  { type_ : String
  , statements : List Statement
  }

extractTree : D.Value -> Tree
extractTree value =
  { type = ""
    , statements =
    [ TextStatement "test"
    ]
  }

-- extractStatements : 

type Statement =
  TextStatement String
  -- | BlockStatement

-- extractStatement : D.Value -> Statement
-- extractStatement parsed =
--   TextStatement parsed.

-- type alias BlockStatement =
--   { typ : String
--   , block : Block
--   }

-- type alias Block =
--   WhileBlock
--   | IfBlock
--   | IfElseBlock
--   | SwitchBlock

-- type alias 