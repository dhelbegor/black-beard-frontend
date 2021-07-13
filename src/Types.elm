module Types exposing (..)
import Http
import Browser
import Browser.Navigation as Nav
import Url


type alias Model =
    {key: Nav.Key
    , url: Url.Url
    , models: List Model3D
    , errors: List Http.Error
    }

type Msg
    = GotModel (Result Http.Error (List Model3D))
    | LinkClicked Browser.UrlRequest
    | UrlChanged Url.Url

type Route
    = Home
    | Contact

type alias Model3D =
    { name: String
    , description: String
    , images: List Image
    }

type alias Image =
    {url: String}
