module Models.Action where

data Action
	= SendMessage String
	| SetEditText String
	| SelectChannel Models.Channel.Channel
	| SelectMessageType
	| DoNothing
