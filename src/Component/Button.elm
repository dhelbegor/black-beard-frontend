module Components.Button exposing (btn, btnWarn, btnConfirm)

import Html exposing (Html, text, div, h1, img, button)
import Html.Attributes exposing (class)
import Html.Events exposing (onClick)

import Types exposing (..)

base: String -> String -> Msg -> Html Msg
base color name action =
    button [class ("bg-transparent hover:bg-" ++ color ++ "-500 text-" ++ color ++ "-700 " ++ "font-semibold hover:text-white py-2 px-4 border border-blue-500 hover:border-transparent rounded")
    , onClick action] [ 
        text name
    ]

btn: String -> Msg -> Html Msg
btn name action =
    base "blue" name action


btnConfirm: String -> Msg -> Html Msg
btnConfirm name action =
    base "green" name action


btnWarn: String -> Msg -> Html Msg
btnWarn name action =
    base "red" name action
