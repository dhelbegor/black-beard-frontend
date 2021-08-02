module Page.Home exposing (viewHome)

import Browser
import Html exposing (..)
import Html.Attributes exposing (..)

import RemoteData exposing (RemoteData(..))

import Page.Base exposing (base, pageBuilder)
import Types exposing (Model, Model3D, Image, Msg(..), Route(..))
import Helpers exposing (imageRenderer)


viewHome: Model -> Browser.Document Msg
viewHome model =
    pageBuilder ""
    (base <|
        section [class "bg-gray-200"] [
            div [class "py-2 px-14"] [responseProcess model.models]
        ]
    )  

responseProcess: RemoteData String (List Model3D) -> Html Msg
responseProcess modelList =
    case modelList of
        NotAsked ->
            div [] [text "nothing to show."]
        
        Loading ->
            div [] [text "loading..."]
        
        Failure err ->
            div []
                [ text "Something went wrong 😨"
                , text err
                ]
        Success models ->
            div [class "grid grid-cols-1 md:grid-cols-3 lg:grid-cols-4 gap-4"] (models |> List.map (\model -> viewModels model))

viewModels: Model3D -> Html Msg
viewModels model =
    div [class "max-w-sm rounded overflow-hidden shadow-lg"] [
        div [] [viewImage model.images]
        , div [class "px-6 py-4"] [
            div [class "font-bold text-xl mb-2"] [text model.name]
            , p [class "text-gray-700 text-base"] [text model.description]
        ] 
    ]

viewImage: List Image -> Html Msg
viewImage images =
    -- get the first image from a list of images using List.Head.
    case List.head images of
        Just image ->
            img [class "w-full", src (imageRenderer image.url)] []
        Nothing ->
            img [src ""] []
