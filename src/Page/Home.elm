module Page.Home exposing (viewHome)

import Browser
import Html exposing (..)
import Html.Attributes exposing (..)
import RemoteData exposing (RemoteData(..))
import Svg
import Svg.Attributes as ST
import Page.Base exposing (base, pageBuilder)
import Types exposing (Model, Model3D, Image, Msg(..), Route(..))
import Helpers exposing (imageRenderer)


viewHome: Model -> Browser.Document Msg
viewHome model =
    pageBuilder ""
    (base <|
        section [class "container mx-auto bg-gray-200"] [
            div [class "py-5 px-10 h-auto mb-20 content-center"] [
                responseProcess model.models
                , div [class "py-10 text-2xl text-center"] [
                    div [class "flex flex-col items-center my-12"] [
                        div [class "flex text-gray-700"] [
                            div [class "h-8 w-8 mr-1 flex justify-center items-center rounded-full bg-gray-200 cursor-pointer"] [
                                Svg.svg [
                                    ST.width "100%"
                                    ,ST.height "100%"
                                    , ST.fill "none"
                                    , ST.viewBox "0 0 24 24"
                                    , ST.stroke "currentColor"
                                    , ST.strokeWidth "2"
                                    , ST.strokeLinecap "round"
                                    , ST.strokeLinejoin "round"
                                    , ST.class "feather feather-chevron-left w-6 h-6"
                                    , ST.xmlBase "http://www.w3.org/2000/svg"] [ Svg.polyline [ST.points "5 18 9 12 15 6"] []]
                            ]
                            , div [class "flex h-8 font-medium rounded-full bg-gray-200"] [
                                div [class "w-8 md:flex justify-center items-center hidden  cursor-pointer leading-5 transition duration-150 ease-in  rounded-full"] [ text "1"]
                                ,div [class "w-8 md:flex justify-center items-center hidden  cursor-pointer leading-5 transition duration-150 ease-in  rounded-full"] [ text "2"]
                                ,div [class "w-8 md:flex justify-center items-center hidden  cursor-pointer leading-5 transition duration-150 ease-in  rounded-full text-white bg-green-600"] [ text "3"]
                                ,div [class "w-8 md:flex justify-center items-center hidden  cursor-pointer leading-5 transition duration-150 ease-in  rounded-full"] [ text "4"]
                                ,div [class "w-8 md:flex justify-center items-center hidden  cursor-pointer leading-5 transition duration-150 ease-in  rounded-full"] [ text "5"]
                            ]
                        ]

                    ]
                    ]
            ]
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
                [ text (String.concat ["Something went wrong 😨 ", err])
                ]
        Success models ->
            div [class "grid grid-cols-1 md:grid-cols-3 lg:grid-cols-4 gap-6"] (models |> List.map (\model -> viewModels model))

viewModels: Model3D -> Html Msg
viewModels model =
    div [class "max-w-sm rounded overflow-hidden shadow-lg transform transition duration-500 hover:scale-110"] [
        div [] [viewImage model.images]
        , div [class "px-6 py-4"] [
            a [href (String.fromInt model.id), class "font-bold text-xl mb-2"] [text model.name]
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
