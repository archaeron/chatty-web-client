module Views.Message where

import Data.Array

import qualified Thermite.Html as H
import qualified Thermite.Html.Attributes as A
import qualified Thermite.Html.Elements as E

import Models.Channel
import Models.Message

messageTypeView :: MessageType -> Thermite.Types.Html _
messageTypeView message =
	case message of
		TextMessage { text: text } ->
			E.span [ A.className "message-text" ] [ H.text text ]
		otherwise ->
			E.span [ A.className "message" ] []

messageView :: Message -> Thermite.Types.Html _
messageView { from: from, to: to, message: message } =
	E.li [ A.className "message" ]
		[ E.span [ A.className "from" ] [ H.text from.name ]
		, E.span [ A.className "message-content" ] [ messageTypeView message ]
		]

messagesView :: Channel -> [Message] -> Thermite.Types.Html _
messagesView selectedChannel messages =
	E.div
		[ A.className "messages" ]
		[ E.ul [ A.className "messages-list" ] (messageView <$> messages)
		]
