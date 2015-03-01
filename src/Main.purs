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
	}

data Action
	= SendMessage

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

inputField ctx =
	E.div [A.className "input-field-container"]
		[ E.input [A.className "input-field"] []
		, E.button [ T.onClick ctx (const SendMessage) ] [ H.text "Send Message" ]
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
				[ inputField ctx
				]
			]
		]
	where
		container = E.div [ A.className "container" ]
		header = E.div [ A.className "header" ]
		body = E.div [ A.className "body" ]

performAction :: T.PerformAction Unit Action (T.Action _ State)
performAction _ SendMessage =
	T.modifyState \st -> { messages: ((TextMessage { from: testUser1, to: testUser2, text: "Hi You" }) : st.messages) }

initialState :: State
initialState =
	{ messages: testMessages
	}

main = do
	let cl = T.createClass spec
	T.render cl unit
