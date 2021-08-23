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
        section [class "container mx-auto bg-gray-200"] [
            div [class "py-5 px-10 h-auto mb-auto content-center"] [text "Page Not Found."]
        ]
    )  
