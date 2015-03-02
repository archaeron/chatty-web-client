module Views.Channel where

import Data.Array

import qualified Thermite.Events as T
import qualified Thermite.Html as H
import qualified Thermite.Html.Attributes as A
import qualified Thermite.Html.Elements as E
import qualified Thermite.Types as T

import Models.Action
import Models.Channel

channelView :: T.Context Models.State.State Unit Models.Action.Action -> Channel -> Thermite.Types.Html Models.Action.Action
channelView ctx channel@{ name: name } =
	E.li [ A.className "channel" ]
		[ E.span
			[ A.className "channel-name"
			, T.onClick ctx \_ -> SelectChannel channel
			]
			[ H.text name ]
		]

channelsView :: T.Context Models.State.State Unit Models.Action.Action -> [Channel] -> Thermite.Types.Html Models.Action.Action
channelsView ctx channels =
	E.div [ A.className "channels" ]
		[ E.h2' [ H.text "Channels" ]
		, E.ul [ A.className "channels-list" ] ((channelView ctx) <$> channels)
		]
