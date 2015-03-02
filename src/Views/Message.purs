module Views.Message where

import Data.Array

import qualified Thermite.Html as H
import qualified Thermite.Html.Attributes as A
import qualified Thermite.Html.Elements as E

import Models.Message

messageTypeView message =
	case message of
		TextMessage { text: text } ->
			E.span [ A.className "message-text" ] [ H.text text ]
		otherwise ->
			E.span [ A.className "message" ] []

messageView {from: from, to: to, message: message } =
	E.li [ A.className "message" ]
		[ E.span [ A.className "from" ] [ H.text from.name ]
		, E.span [ A.className "to" ] [ H.text to.name ]
		, E.span [ A.className "message-content" ] [ messageTypeView message ]
		]

messagesView messages =
	E.ul [ A.className "messages" ] (messageView <$> messages)
