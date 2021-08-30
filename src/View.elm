module View exposing (..)

import Api exposing (..)
import Array
import Browser
import Browser.Navigation as Nav
import Helpers exposing (imageRenderer)
import Html exposing (..)
import Html.Attributes exposing (..)
import Http
import Json.Decode as Json exposing (Decoder)
import Page.Contact exposing (viewContact)
import Page.Home exposing (viewHome)
import Page.NotFound exposing (viewNotFound)
import RemoteData exposing (RemoteData)
import Route exposing (..)
import Serializer.Decode exposing (..)
import Types exposing (Model, Msg(..), Route(..))
import Url
import Url.Parser exposing (Parser, int, map, oneOf, parse, s, top)


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        SelectModel model3d ->
            ( { model | selectedModel = Just model3d }, Cmd.none )

        CloseModal ->
            ( { model | selectedModel = Nothing }, Cmd.none )

        LinkClicked urlRequest ->
            case urlRequest of
                Browser.Internal url ->
                    ( model, Nav.pushUrl model.key (Url.toString url) )

                Browser.External ref ->
                    ( model, Nav.load ref )

        UrlChanged url ->
            ( { model | route = fromUrl url }, Cmd.none )

        GotModel resp ->
            ( { model | models = RemoteData.fromResult resp }, Cmd.none )


view : Model -> Browser.Document Msg
view model =
    case model.route of
        Home ->
            viewHome model

        Contact ->
            viewContact

        NotFound ->
            viewNotFound
