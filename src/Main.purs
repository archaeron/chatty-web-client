module Main where

import Data.Maybe

import qualified Thermite as T
import qualified Thermite.Html as H
import qualified Thermite.Html.Elements as E
import qualified Thermite.Types as T
import qualified Thermite.Events as T
import qualified Thermite.Html.Attributes as A
import qualified Thermite.Action as T

import Models.Action
import Models.Channel
import Models.Group
import Models.Input
import Models.User
import Models.Message
import Models.State
import Views.Channel
import Views.Input
import Views.Message


spec :: T.Spec (T.Action _ State) State Unit Action
spec = T.Spec
	{ displayName : Just "chatty"
	, render: render
	, performAction: performAction
	, initialState: initialState
	, componentWillMount: Nothing
	}

testUser2 :: User
testUser2 = { name: "Ron", email: "ron@potter.com" }

render :: T.Render State Unit Action
render ctx st _ =
	container
		[ header [ E.h1' [ H.text "Chatty" ] ]
		, channelsView ctx st.channels
		, messagesView st.selectedChannel st.messages
		, messageInput ctx st
		]
	where
		container = E.div [ A.className "container" ]
		header = E.div [ A.className "header" ]

performAction :: T.PerformAction Unit Action (T.Action _ State)
performAction _ action =
	case action of
		SendMessage sendMessage ->
			T.modifyState \st ->
				st { messages =
						st.messages <> [ { from: st.user, to: testUser2, message: TextMessage { text: sendMessage } } ]
					, editText = ""
				}
		SetEditText setEditText ->
			T.modifyState \st ->
				st { editText = setEditText }
		SelectChannel channel ->
			T.modifyState \st ->
				st { selectedChannel = channel }
		DoNothing ->
			T.modifyState id

initialState :: State
initialState =
	{ messages: [ ]
	, editText: ""
	, user:
		{ name: "Harry"
		, email: "harry@potter.com"
		}
	, channels: [ { name: "Haskell" }, { name: "Purescript" } ]
	, selectedChannel: { name: "Haskell" }
	, selectedInputType: TextInput
	}

main = do
	let cl = T.createClass spec
	T.render cl unit
