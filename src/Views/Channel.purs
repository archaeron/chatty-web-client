module Views.Channel where

import Data.Array

import qualified Thermite.Html as H
import qualified Thermite.Html.Attributes as A
import qualified Thermite.Html.Elements as E

import Models.Channel

channelView :: Channel -> Thermite.Types.Html Models.Action.Action
channelView { name: name } =
	E.li [ A.className "channel" ]
		[ E.span [ A.className "channel-name" ] [ H.text name ]
		]

channelsView :: [Channel] -> Thermite.Types.Html Models.Action.Action
channelsView channels =
	E.div [ A.className "channels" ]
		[ E.ul [ A.className "channels-list" ] (channelView <$> channels)
		]
