module Page.Base exposing (..)

import Browser
import Html exposing (..)
import Html.Attributes exposing (..)
import Svg
import Svg.Attributes as ST

import Types exposing (Msg(..))


viewNav: Html Msg
viewNav =
    nav [class "bg-gray-800  h-16 flex items-center"]
        [div [class "container mx-auto flex justify-between"] [
            div [class "flex"] [
                a [class "font-semibold text-xl text-white", href "/"] [text "The Black Beard 3D"]
            ]
        ]]

viewFooter: Html Msg
viewFooter =
    footer [class "py-2 px-10 h-16 w-full bottom-0 z-10 bg-gray-800 flex items-center"] [
        div [class "container mx-auto flex justify-center text-white"] [
            div [class "flex items-center"] [
                div [class "mr-1"] [text "made with"]
                , Svg.svg [ST.xmlBase "http://www.w3.org/2000/svg"
                , ST.class "h-5 w-5"
                , ST.viewBox "0 0 20 20"
                , ST.fill "red"] [
                    Svg.path [ST.fillRule "evenodd"
                    ,ST.d "M3.172 5.172a4 4 0 015.656 0L10 6.343l1.172-1.171a4 4 0 115.656 5.656L10 17.657l-6.828-6.829a4 4 0 010-5.656z"
                    , ST.clipRule "evenodd"] [] ]
                , span [class "ml-1"] [text " by"]
                ,a [class "ml-1", href "https://github.com/dhelbegor", target "_blank"] [text "dhelbegor"]
            ]
        ]
    ]

view: Html Msg -> Html Msg
view content =
    div [class "h-screen flex flex-col bg-gray-200"] 
    [viewNav
    , content
    , viewFooter
    ]

base: Html Msg -> List (Html Msg)
base content =
    [view content]

parsePageTitle: String -> String
parsePageTitle title =
    let siteTitle = "The Black Beard 3D"
    in
        case String.isEmpty title of
            False ->
                String.concat [title, " - ", siteTitle]

            True ->
                siteTitle

pageBuilder: String -> List(Html Msg) -> Browser.Document Msg
pageBuilder title body =
    {title=parsePageTitle title
    , body=body
    }
