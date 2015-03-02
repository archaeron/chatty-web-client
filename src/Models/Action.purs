module Models.Action where

data Action
	= SendMessage String
	| SetEditText String
	| SelectChannel Models.Channel.Channel
	| DoNothing
