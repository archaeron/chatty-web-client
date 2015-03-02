module Helpers.Html where

import qualified Thermite.Events as T

foreign import getKeyCode
	"function getKeyCode(e) {\
	\  return e.keyCode;\
	\}" :: T.KeyboardEvent -> Number

foreign import getValue
	"function getValue(e) {\
	\  return e.target.value;\
	\}" :: forall event. event -> String
