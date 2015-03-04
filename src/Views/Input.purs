module Views.Input where

import qualified Thermite.Events as T
import qualified Thermite.Html as H
import qualified Thermite.Html.Attributes as A
import qualified Thermite.Html.Elements as E
import qualified Thermite.Types as T

import Helpers.Html
import Models.Action
import Models.Input
import Models.State
import Views.Types

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
				, A.placeholder "enter a text message"
				, T.onKeyUp ctx handleKeyPress
				, T.onChange ctx handleChangeEvent
				, A.value st.editText
				]
				[ ]
		CodeInput ->
			E.textarea
				[ A.className "code-input-field"
				, A.placeholder "enter a code message"
				, T.onKeyUp ctx handleKeyPress
				, T.onChange ctx handleChangeEvent
				, A.value st.editText
				]
				[ ]
		FormulaInput ->
			E.textarea
				[ A.className "formula-input-field"
				, A.placeholder "enter a formula message"
				, T.onKeyUp ctx handleKeyPress
				, T.onChange ctx handleChangeEvent
				, A.value st.editText
				]
				[ ]
		FileInput ->
			H.text "FileInput"

inputTypeSelectTabHeadClass :: InputType -> InputType -> String
inputTypeSelectTabHeadClass inputType selectedInputType =
	if inputType == selectedInputType then
		"selected input-type-select-tab"
	else
		"input-type-select-tab"

inputTypeSelectTabHead :: AppContext -> String -> InputType -> InputType -> AppHtml
inputTypeSelectTabHead ctx text inputType selectedInputType =
	E.span
		[ T.onClick ctx (const $ SelectInputType inputType)
		, A.className $ inputTypeSelectTabHeadClass inputType selectedInputType
		]
		[ H.text text ]

inputTypeSelector :: AppContext -> InputType -> AppHtml
inputTypeSelector ctx selectedInputType =
	E.div [ A.className "input-types-select-tabs" ]
		[ inputTypeSelectTabHead ctx "Text" TextInput selectedInputType
		, inputTypeSelectTabHead ctx "Code" CodeInput selectedInputType
		, inputTypeSelectTabHead ctx "Formula" FormulaInput selectedInputType
		, inputTypeSelectTabHead ctx "File" FileInput selectedInputType
		]

messageInput :: AppContext -> State -> AppHtml
messageInput ctx st =
	E.div [ A.className "input-field-container" ]
		[ inputTypeSelector ctx st.selectedInputType
		, inputField ctx st
		]
