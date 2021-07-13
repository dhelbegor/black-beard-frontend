module Component.Base exposing (..)
import Html exposing (Html, div, text, a)
import Html.Attributes exposing (href)
import Types exposing (Msg(..))
{-|
    This page will expose the base template for every page
    in this file will be
    Nav navigation bar
    Body body that will get a Html Msg and return a Html Msg
    Footer
-}

nav: List String -> Html Msg
nav paths =
    div [] (List.map renderPath paths)


renderPath: String -> Html Msg
renderPath path =
    a [ href path ] [ text path ]
