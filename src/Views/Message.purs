module Views.Message where

import Data.Array

import qualified Thermite.Html as H
import qualified Thermite.Html.Attributes as A
import qualified Thermite.Html.Elements as E

import Models.Channel
import Models.Message
import Views.Types

messageTypeView :: MessageType -> AppHtml
messageTypeView message =
	case message of
		TextMessage { text: text } ->
			E.span [ A.className "message-text" ] [ H.text text ]
		CodeMessage { language: language, text: text } ->
			E.pre [ A.className "message-code" ] [ H.text text ]
		otherwise ->
			E.span [ A.className "message" ] []

messageView :: Message -> AppHtml
messageView { from: from, to: to, message: message } =
	E.li
		[ A.className "message" ]
		[ E.span [ A.className "from" ] [ H.text from.name ]
		, E.span [ A.className "message-content" ] [ messageTypeView message ]
		]

messagesView :: [Message] -> Channel -> AppHtml
messagesView messages selectedChannel =
	E.div
		[ A.className "messages" ]
		[ E.h2' [ H.text (unChannel selectedChannel).name ]
		, E.ul [ A.className "messages-list" ] (messageView <$> messages)
		]
