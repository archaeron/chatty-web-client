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

messageInput ctx st =
	E.div [ A.className "input-field-container" ]
		[ inputField ctx st ]
