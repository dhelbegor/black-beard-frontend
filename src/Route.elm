module Route exposing (..)

import Url
import Url.Parser exposing (Parser, parse, int, map, oneOf, s, top)

import Types exposing (Route(..))


route: Parser (Route -> a) a
route =
    oneOf
    [ map Home <| top
    , map Contact <| s "contact"
    ]

fromUrl: Url.Url -> Route
fromUrl url =
    Maybe.withDefault NotFound (parse route url)
