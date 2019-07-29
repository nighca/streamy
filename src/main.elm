import Browser

import Model as Model
import Update as Update
import View.Main as View

main =
  Browser.sandbox { init = Model.init, update = Update.update, view = View.view }
