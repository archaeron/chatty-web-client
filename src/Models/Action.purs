module Models.Action where

data Action
	= SendMessage String
	| SetEditText String
	| SelectChannel Models.Channel.Channel
	| SelectInputType Models.Input.InputType
	| DoNothing
