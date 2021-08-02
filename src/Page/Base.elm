module Page.Base exposing (..)

import Browser
import Html exposing (..)
import Html.Attributes exposing (..)

import Types exposing (Msg(..))


link: String -> String -> Html Msg
link path name =
    a [class "text-white", href path] [text name]

viewNav: Html Msg
viewNav =
    nav [class "bg-gray-800 flex items-center justify-between h-16"]
        [div [class "flex"]
            [h4 [] [text "logo"]
            , link "/" "The Black Beard 3D"
            ]
            , link "/contact/" "Contato"
        ]

viewFooter: Html Msg
viewFooter =
    footer [class "fixed bottom-0 inset-x-0 bg-gray-800 p-4"] [text "footer"]

view: Html Msg -> Html Msg
view content =
    div [class "h-screen bg-gray-200"] 
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
