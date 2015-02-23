module Models.Message where

type TextMessage =
	{
	}

type CodeMessage =
	{
	}

type FormulaMessage =
	{
	}

type FileUpload =
	{
	}

data Message
	= TextMessage TextMessage
	| CodeMessage CodeMessage
	| FormulaMessage FormulaMessage
	| FileUpload FileUpload
