module View exposing (..)
import Browser
import Browser.Navigation as Nav
import Json.Decode as Json exposing (Decoder)
import Http
import Array
import Url
import Url.Parser exposing (Parser, parse, int, map, oneOf, s, top)

import Html exposing (..)
import Html.Attributes exposing (..)
import Route exposing (..)
import Types exposing (Model, Msg(..), Route(..))
import Api exposing (..)
import Serializer.Decode exposing (..)
import Helpers exposing (imageRenderer)
import RemoteData exposing (RemoteData)
import Page.Home exposing (viewHome)
import Page.Contact exposing (viewContact)
import Page.NotFound exposing (viewNotFound)


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        LinkClicked urlRequest ->
            case urlRequest of
                Browser.Internal url ->
                    (model, Nav.pushUrl model.key (Url.toString url))
                Browser.External ref ->
                    (model, Nav.load ref)

        UrlChanged url ->
            ({model | route = fromUrl url}, Cmd.none)
        
        GotModel resp ->
            ({ model | models = RemoteData.fromResult resp }, Cmd.none)


view : Model -> Browser.Document Msg
view model =
    case model.route of
        Home ->
            viewHome model

        Contact ->
            viewContact

        NotFound ->
            viewNotFound

