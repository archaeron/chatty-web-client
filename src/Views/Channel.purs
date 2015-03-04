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

channelViewSelectClass :: Channel -> Channel -> String
channelViewSelectClass channel selectedChannel =
	if channel == selectedChannel then
		"selected"
	else
		""

channelView :: AppContext -> Channel -> Channel -> AppHtml
channelView ctx selectedChannel channel =
	E.li [ A.className "channel" ]
		[ E.span
			[ A.className ("channel-name " ++ (channelViewSelectClass channel selectedChannel))
			, T.onClick ctx (const $ SelectChannel channel)
			]
			[ H.text (unChannel channel).name ]
		]

channelsView :: AppContext -> [Channel] -> Channel -> AppHtml
channelsView ctx channels selectedChannel =
	E.div [ A.className "channels" ]
		[ E.h2' [ H.text "Channels" ]
		, E.ul [ A.className "channels-list" ] ((channelView ctx selectedChannel) <$> channels)
		]
