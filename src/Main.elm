module Main exposing (..)

import Api exposing (getModels)
import Browser
import Browser.Navigation as Nav
import Helpers exposing (expectJson)
import Http
import Json.Decode as Json
import RemoteData exposing (RemoteData)
import Route exposing (fromUrl)
import Serializer.Decode exposing (modelDecoder)
import Types exposing (..)
import Url
import View exposing (update, view)


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


initialModel : Url.Url -> Nav.Key -> Model
initialModel url key =
    { key = key
    , url = url
    , models = RemoteData.Loading
    , route = fromUrl url
    , selectedModel = Nothing
    }


init : () -> Url.Url -> Nav.Key -> ( Model, Cmd Msg )
init flags url key =
    ( initialModel url key
    , Http.get
        { url = getModels
        , expect = expectJson GotModel (Json.field "results" (Json.list modelDecoder))
        }
    )
