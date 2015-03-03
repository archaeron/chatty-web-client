module Views.Input where

import qualified Thermite.Events as T
import qualified Thermite.Html as H
import qualified Thermite.Html.Attributes as A
import qualified Thermite.Html.Elements as E
import qualified Thermite.Types as T

import Helpers.Html
import Models.Action
import Models.Input

handleKeyPress :: T.KeyboardEvent -> Action
handleKeyPress e =
	case getKeyCode e of
		13 ->
			let value = getValue e
			in
				case value of
					"" -> DoNothing
					otherwise -> SendMessage $ value
		27 -> SetEditText ""
		_  -> DoNothing

handleChangeEvent :: T.FormEvent -> Models.Action.Action
handleChangeEvent e = SetEditText (getValue e)

inputField ctx st =
	case st.selectedInputType of
		TextInput ->
			E.textarea
				[ A.className "text-input-field"
				, A.placeholder "enter a message"
				, T.onKeyUp ctx handleKeyPress
				, T.onChange ctx handleChangeEvent
				, A.value st.editText
				]
				[ ]
		CodeInput ->
			H.text "CodeInput"
		FormulaInput ->
			H.text "FormulaInput"
		FileInput ->
			H.text "FileInput"

inputTypeSelector :: T.Context Models.State.State Unit Models.Action.Action -> InputType -> Thermite.Types.Html Models.Action.Action
inputTypeSelector ctx textInput =
	E.div [ ]
		[ E.span [ T.onClick ctx (const $ SelectInputType TextInput) ] [ H.text "Text" ]
		, E.span [ T.onClick ctx (const $ SelectInputType CodeInput) ] [ H.text "Code" ]
		, E.span [ T.onClick ctx (const $ SelectInputType FormulaInput) ] [ H.text "Formula" ]
		, E.span [ T.onClick ctx (const $ SelectInputType FileInput) ] [ H.text "File" ]
		]

messageInput ctx st =
	E.div [ A.className "input-field-container" ]
		[ inputTypeSelector ctx st.selectedInputType
		, inputField ctx st
		]
