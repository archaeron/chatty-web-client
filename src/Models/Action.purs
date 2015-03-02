module Models.Action where

data Action
	= SendMessage String
	| SetEditText String
	| DoNothing
