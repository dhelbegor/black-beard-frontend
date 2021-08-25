module Route exposing (..)

import Types exposing (Route(..))
import Url
import Url.Parser exposing (Parser, int, map, oneOf, parse, s, top)


route : Parser (Route -> a) a
route =
    oneOf
        [ map Home <| top
        , map Contact <| s "contact"
        ]


fromUrl : Url.Url -> Route
fromUrl url =
    Maybe.withDefault NotFound (parse route url)
