module Page.Home exposing (viewHome)

import Browser
import Helpers exposing (imageRenderer)
import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (onClick)
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
                    [ case model.selectedModel of
                        Just model3d ->
                            viewModal model3d

                        Nothing ->
                            text ""
                    , responseProcess model.models
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
            [ button [ onClick <| SelectModel model, class "font-bold text-xl mb-2" ] [ text model.name ]
            , p [ class "text-gray-700 text-base" ]
                [ text model.description ]
            ]
        ]


viewModal : Model3D -> Html Msg
viewModal model =
    div [ class "fixed z-10 inset-0 overflow-y-auto" ]
        [ div [ class "flex items-center justify-center mx-auto min-h-screen pt-4 px-4 pb-20 text-center sm:block sm:p-0" ]
            [ div [ class "modal-content  py-4 text-left px-8 flex items-center justify-center" ]
                [ div [ class "fixed inset-0 bg-gray-500 bg-opacity-75 transition-opacity" ] []
                , span [ class "hidden sm:inline-block sm:align-middle sm:h-screen" ] []
                , div [ class "flex align-bottom bg-white rounded-lg text-left overflow-hidden shadow-xl transform transition-all sm:my-8 sm:align-middle sm:max-w-lg sm:w-full" ]
                    [ div [ class "bg-white px-4 pt-5 pb-4 sm:p-6 sm:pb-4" ]
                        [ div [ class "flex gap-2" ]
                            [ div [ class "flex" ] [ viewImage model.images ]
                            , div [ class "flex" ] [ text "aaaaaaaaaaaaaaaaaaaabbbbbbbbbbbbbbbbbbbbb" ]
                            ]
                        , div [ class "px-2 py-3 sm:px-6 sm:flex sm:flex-row-reverse" ]
                            [ button [ class "mt-3 w-full inline-flex justify-center rounded-md border border-gray-300 shadow-sm px-4 py-2 bg-white text-base font-medium text-gray-700 hover:bg-blue-400 focus:outline-none focus:ring-2 focus:ring-offset-2 focus:ring-indigo-500 sm:mt-0 sm:ml-3 sm:w-auto sm:text-sm" ] [ text "Enviar" ]
                            , button [ onClick CloseModal, class "w-full inline-flex justify-center rounded-md border border-transparent shadow-sm px-4 py-2 bg-red-600 text-base font-medium text-white hover:bg-red-700 focus:outline-none focus:ring-2 focus:ring-offset-2 focus:ring-red-500 sm:ml-3 sm:w-auto sm:text-sm" ] [ text "Fechar" ]
                            ]
                        ]
                    ]
                ]
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
