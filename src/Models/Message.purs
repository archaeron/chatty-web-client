module Models.Message where

import Models.User

type BaseMessage m = { from :: User, to :: User | m }

type TextMessage = BaseMessage (text :: String)

type CodeMessage = BaseMessage (language :: String, text :: String)

type FormulaMessage = BaseMessage ()

type FileUpload = BaseMessage ()

data Message
	= TextMessage TextMessage
	| CodeMessage CodeMessage
	| FormulaMessage FormulaMessage
	| FileUpload FileUpload
