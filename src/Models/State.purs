module Models.State where

import Models.Channel
import Models.Message
import Models.User

type State =
	{ messages :: [ Message ]
	, editText :: String
	, user :: User
	, channels :: [ Channel ]
	, selectedChannel :: Channel
	}
