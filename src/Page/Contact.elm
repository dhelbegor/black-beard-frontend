module Page.Contact exposing (viewContact)

import Browser
import Html exposing (..)
import Html.Attributes exposing (..)

import Types exposing (Msg(..))
import Page.Base exposing (base, pageBuilder)


viewContact: Browser.Document Msg
viewContact =
    pageBuilder "Contact"
    (base <|
        section [class "bg-gray-200"] [
            div [class "py-2 px-14"] [text "Contacs Page."]
        ]
    )  
