module Main where

import Debug.Trace

import Data.Maybe

import qualified Thermite as T
import qualified Thermite.Html as H
import qualified Thermite.Html.Elements as E
import qualified Thermite.Types as T
import qualified Thermite.Events as T
import qualified Thermite.Html.Attributes as A
import qualified Thermite.Action as T

import Models.Group
import Models.Channel
import Models.User
import Models.Message
import Helpers.Html
import Views.Message

type State =
	{ messages :: [ Message ]
	, editText :: String
	, user :: User
	}

data Action
	= SendMessage String
	| SetEditText String
	| DoNothing

spec :: T.Spec (T.Action _ State) State Unit Action
spec = T.Spec
	{ displayName : Just "chatty"
	, render: render
	, performAction: performAction
	, initialState: initialState
	, componentWillMount: Nothing
	}

handleKeyPress :: T.KeyboardEvent -> Action
handleKeyPress e =
	case getKeyCode e of
		13 -> SendMessage $ getValue e
		27 -> SetEditText ""
		_  -> DoNothing

handleChangeEvent :: T.FormEvent -> Action
handleChangeEvent e = SetEditText (getValue e)

inputField st ctx =
	E.div [ A.className "input-field-container" ]
		[ E.input
			[ A.className "input-field"
			, A.placeholder "enter a message here"
			, T.onKeyUp ctx handleKeyPress
			, T.onChange ctx handleChangeEvent
			, A.value st.editText
			]
			[]
		]

testUser2 :: User
testUser2 = { name: "Ron", email: "ron@potter.com" }

render :: T.Render State Unit Action
render ctx st _ =
	container
		[ header []
		, body
			[ messagesView st.messages
			, E.p'
				[ inputField st ctx
				]
			]
		]
	where
		container = E.div [ A.className "container" ]
		header = E.div [ A.className "header" ]
		body = E.div [ A.className "body" ]

performAction :: T.PerformAction Unit Action (T.Action _ State)
performAction _ action =
	case action of
		SendMessage sendMessage ->
			T.modifyState \st ->
				{ messages: ({ from: st.user, to: testUser2, message: (TextMessage { text: sendMessage }) } : st.messages)
				, editText: ""
				, user: st.user
				}
		SetEditText setEditText ->
			T.modifyState \st ->
				st { editText = setEditText }
		DoNothing ->
			T.modifyState id

initialState :: State
initialState =
	{ messages: []
	, editText: ""
	, user:
		{ name: "Harry"
		, email: "harry@potter.com"
		}
	}

main = do
	let cl = T.createClass spec
	T.render cl unit
