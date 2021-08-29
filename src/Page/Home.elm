module Page.Home exposing (viewHome)

import Browser
import Helpers exposing (imageRenderer)
import Html exposing (..)
import Html.Attributes exposing (..)
import Page.Base exposing (base, pageBuilder)
import RemoteData exposing (RemoteData(..))
import Svg
import Svg.Attributes as ST
import Types exposing (Image, Model, Model3D, Msg(..), Route(..))


viewHome : Model -> Browser.Document Msg
viewHome model =
    pageBuilder ""
        (base <|
            section [ class "container mx-auto mb-auto bg-gray-200" ]
                [ div [ class "py-5 px-10 content-center" ]
                    [ responseProcess model.models
                    ]
                ]
        )


responseProcess : RemoteData String (List Model3D) -> Html Msg
responseProcess modelList =
    case modelList of
        NotAsked ->
            div [] [ text "nothing to show." ]

        Loading ->
            div [] [ text "loading..." ]

        Failure err ->
            div []
                [ text (String.concat [ "Something went wrong 😨 ", err ])
                ]

        Success models ->
            div
                [ class "grid grid-cols-1 md:grid-cols-3 lg:grid-cols-4 gap-6"
                ]
                (models |> List.map (\model -> viewModels model))


viewModels : Model3D -> Html Msg
viewModels model =
    div [ class "max-w-sm rounded overflow-hidden shadow-lg transform transition duration-500 hover:scale-110" ]
        [ div [] [ viewImage model.images ]
        , div [ class "px-6 py-4" ]
            [ a [ href (String.fromInt model.id), class "font-bold text-xl mb-2" ] [ text model.name ]
            , p [ class "text-gray-700 text-base" ]
                [ text model.description ]
            ]
        ]


viewImage : List Image -> Html Msg
viewImage images =
    -- get the first image from a list of images using List.Head.
    case List.head images of
        Just image ->
            img [ class "w-full", src (imageRenderer image.url) ] []

        Nothing ->
            img [ src "" ] []
