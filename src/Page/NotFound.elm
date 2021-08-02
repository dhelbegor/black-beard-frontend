module Page.NotFound exposing (viewNotFound)

import Browser
import Html exposing (..)
import Html.Attributes exposing (..)

import Types exposing (Msg(..))
import Page.Base exposing (base, pageBuilder)


viewNotFound: Browser.Document Msg
viewNotFound =
    pageBuilder "Not Found"
    (base <|
        section [class "bg-gray-200"] [
            div [class "py-2 px-14"] [text "Page Not Found."]
        ]
    )  
