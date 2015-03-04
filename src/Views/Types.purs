module Views.Types where

import Thermite.Types

type AppContext = Context Models.State.State Unit Models.Action.Action

type AppHtml = Html Models.Action.Action
