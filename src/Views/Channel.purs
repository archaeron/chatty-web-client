module Views.Channel where

import Data.Array

import qualified Thermite.Events as T
import qualified Thermite.Html as H
import qualified Thermite.Html.Attributes as A
import qualified Thermite.Html.Elements as E
import qualified Thermite.Types as T

import Models.Action
import Models.Channel
import Views.Types

channelView :: AppContext -> Channel -> AppHtml
channelView ctx channel =
	E.li [ A.className "channel" ]
		[ E.span
			[ A.className "channel-name"
			, T.onClick ctx (const $ SelectChannel channel)
			]
			[ H.text channel.name ]
		]

channelsView :: AppContext -> [Channel] -> AppHtml
channelsView ctx channels =
	E.div [ A.className "channels" ]
		[ E.h2' [ H.text "Channels" ]
		, E.ul [ A.className "channels-list" ] ((channelView ctx) <$> channels)
		]
