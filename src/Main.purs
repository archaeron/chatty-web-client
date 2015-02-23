module Main where

import Debug.Trace

import Data.Maybe

import qualified Thermite as T
import qualified Thermite.Html as H
import qualified Thermite.Html.Elements as E
import qualified Thermite.Types as T
import qualified Thermite.Events as T
import qualified Thermite.Html.Attributes as A
import qualified Thermite.Action as T

import Models.Group
import Models.Channel

type State =
	{ counter :: Number
	}

data Action
	= Increment
	| Decrement

spec :: T.Spec (T.Action _ State) State Unit Action
spec = T.Spec
	{ displayName : Just "chatty"
	, render: render
	, performAction: performAction
	, initialState: initialState
	, componentWillMount: Nothing
	}

render :: T.Render State Unit Action
render ctx st _ =
	container
		[
			header [],
			body
				[
					E.p'
						[
							E.p' [ H.text (show st.counter) ],
							E.button [ T.onClick ctx (const Increment)] [ H.text "Increment" ],
							E.button [ T.onClick ctx (const Decrement)] [ H.text "Decrement" ]
						]
				]
		]
	where
		container = E.div [ A.className "container" ]
		header = E.div [ A.className "header" ]
		body = E.div [ A.className "body" ]

performAction :: T.PerformAction Unit Action (T.Action _ State)
performAction _ Increment = T.modifyState \st -> { counter: st.counter + 1 }
performAction _ Decrement = T.modifyState \st -> { counter: st.counter - 1 }

initialState :: State
initialState =
	{ counter: 0
	}

main = do
	let cl = T.createClass spec
	T.render cl unit
