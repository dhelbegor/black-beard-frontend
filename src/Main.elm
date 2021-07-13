module Main exposing (..)
import Browser
import Browser.Navigation as Nav
import Types exposing (..)
import View exposing (view, update)
import Http
import Api exposing (getModels)
import Json.Decode as Json
import Url
import Serializer.Decode exposing (modelDecoder)


main : Program () Model Msg
main =
    Browser.application
        { init = init
        , update = update
        , view = view
        , subscriptions = \_ -> Sub.none
        , onUrlRequest = LinkClicked
        , onUrlChange = UrlChanged
        }

init : () -> Url.Url -> Nav.Key -> ( Model, Cmd Msg )
init flags url key =
    ({ key = key, url = url, models = [], errors = [] }
    , Http.get {
        url = getModels
        , expect = Http.expectJson GotModel (Json.field "results" (Json.list modelDecoder))
    })

