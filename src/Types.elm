module Types exposing (..)
import Http
import Browser
import Browser.Navigation as Nav
import Url
import RemoteData exposing (RemoteData)


type alias Model =
    {key: Nav.Key
    , url: Url.Url
    , models: RemoteData String (List Model3D)
    , route: Route
    }

type Msg
    = GotModel (Result String (List Model3D))
    | LinkClicked Browser.UrlRequest
    | UrlChanged Url.Url

type Route
    = Home
    | Contact
    | NotFound

type alias Model3D =
    { name: String
    , description: String
    , images: List Image
    }

type alias Image =
    {url: String}


