module View exposing (..)
import Browser
import Browser.Navigation as Nav
import Html exposing (..)
import Html.Attributes exposing (..)

import Types exposing (Model, Model3D, Image, Msg(..))
import Api exposing (..)
import Json.Decode as Json exposing (Decoder)
import Serializer.Decode exposing (..)
import Helpers exposing (imageRenderer)
import Http
import Array
import Url

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
            ({model | url = url}, Cmd.none)
        
        GotModel (Ok models) ->
            ({ model | models = models }, Cmd.none)
        
        GotModel (Err errors) ->
            ({ model | errors = errors :: model.errors}, Cmd.none)


view : Model -> Browser.Document Msg
view model =
    {title = "The Black Beard 3D"
    , body = [
        div [] [itemView model]
        , linkView "/home" "Home"
    ]
    }

itemView: Model -> Html Msg
itemView model =
    case List.isEmpty model.errors of
        False -> 
            div [] [text (Debug.toString model.errors)]
            
        True -> 
            case List.isEmpty model.models of
                False ->
                    div [class "container"] [
                        div [class "md:grid-cols-2 lg:grid-cols-4 gap-2 md:gap-4"] [
                            h1 [class "text-gray-700 lg:text-center"] [ text "" ]
                        ]
                        ,div [] (List.map modelView model.models)
                    ]
                True ->
                    div [class "text-center"] [text "Nothing to show."]


modelView: Model3D -> Html Msg
modelView model =
    div [] [
        p [] [text model.name]
        , p [] [text model.description]
        , div [] [imageView model.images]
    ]

imageView: List Image -> Html Msg
imageView item =
    case List.head item of
        Just image ->
            img [src (imageRenderer image.url)] []

        Nothing ->
            img [src ""] []

linkView: String -> String -> Html Msg
linkView path name =
    a [href path] [text name]

