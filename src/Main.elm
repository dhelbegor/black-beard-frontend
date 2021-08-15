module Main exposing (..)
import Browser
import Browser.Navigation as Nav
import Types exposing (..)
import Types exposing(Route(..))
import View exposing (view, update)
import Http
import Api exposing (getModels)
import Json.Decode as Json
import Url
import Serializer.Decode exposing (modelDecoder)
import Helpers exposing (expectJson)
import Route exposing (fromUrl)
import RemoteData exposing (RemoteData)


main: Program () Model Msg
main =
    Browser.application
        { init = init
        , update = update
        , view = view
        , subscriptions = \_ -> Sub.none
        , onUrlRequest = LinkClicked
        , onUrlChange = UrlChanged
        }

initialModel: Url.Url -> Nav.Key -> Model
initialModel url key =
    {key = key
    , url = url
    , models = RemoteData.Loading
    , route = fromUrl url
    }

init: () -> Url.Url -> Nav.Key -> ( Model, Cmd Msg )
init flags url key =
    ((initialModel url key)
    , Http.get {
        url = getModels
        , expect = expectJson GotModel (Json.field "results" (Json.list modelDecoder))
    })

