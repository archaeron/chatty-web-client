module Main where

import Debug.Trace

import Data.Maybe
import Data.Array

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

type State =
	{ messages :: [Message]
	, editText :: String
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

messageView message =
	case message of
		TextMessage { from: from, to: to, text: text } ->
			E.div [A.className "message"] [ H.text text ]
		otherwise ->
			E.div [A.className "message"] []

messagesView messages =
	E.div [A.className "messages"] (messageView <$> messages)

foreign import getKeyCode
	"function getKeyCode(e) {\
	\  return e.keyCode;\
	\}" :: T.KeyboardEvent -> Number

foreign import getValue
	"function getValue(e) {\
	\  return e.target.value;\
	\}" :: forall event. event -> String

handleKeyPress :: T.KeyboardEvent -> Action
handleKeyPress e =
	case getKeyCode e of
		13 -> SendMessage $ getValue e
		27 -> SetEditText ""
		_  -> DoNothing

handleChangeEvent :: T.FormEvent -> Action
handleChangeEvent e = SetEditText (getValue e)

inputField st ctx =
	E.div [A.className "input-field-container"]
		[ E.input
			[ A.className "input-field"
			, A.placeholder "placeholder"
			, T.onKeyUp ctx handleKeyPress
			, T.onChange ctx handleChangeEvent
			, A.value st.editText
			]
			[]
		]

testUser1 :: User
testUser1 = { name: "Harry", email: "harry@potter.com" }
testUser2 = { name: "Ron", email: "ron@potter.com" }
testMessages :: [Message]
testMessages =
	[ TextMessage { from: testUser1, to: testUser2, text: "Hi Ron" }
	]

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
performAction _ (SendMessage sendMessage) =
	T.modifyState \st ->
		{ messages: ((TextMessage { from: testUser1, to: testUser2, text: sendMessage }) : st.messages)
		, editText: ""
		}
performAction _ (SetEditText setEditText) =
	T.modifyState \st -> st { editText = setEditText }
performAction _ DoNothing = T.modifyState id

initialState :: State
initialState =
	{ messages: testMessages
	, editText: ""
	}

main = do
	let cl = T.createClass spec
	T.render cl unit
