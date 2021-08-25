module Helpers exposing (expectJson, imageRenderer)

import Api exposing (baseUrl)
import Http
import Json.Decode as Json



-- create a full url image with the base url
-- dropLeft was needed to remove an extra / from the url.


imageRenderer : String -> String
imageRenderer imgUrl =
    String.concat [ baseUrl, imgUrl ]


expectJson : (Result String a -> msg) -> Json.Decoder a -> Http.Expect msg
expectJson toMsg decoder =
    Http.expectStringResponse toMsg <|
        \response ->
            case response of
                Http.BadUrl_ _ ->
                    Err "Bad Url."

                Http.Timeout_ ->
                    Err "Timeout."

                Http.NetworkError_ ->
                    Err "NetWork error."

                Http.BadStatus_ _ error ->
                    case Json.decodeString (Json.field "error" Json.string) error of
                        Ok errorMsg ->
                            Err errorMsg

                        Err _ ->
                            Err "Server Error."

                Http.GoodStatus_ _ data ->
                    case Json.decodeString decoder data of
                        Ok value ->
                            Ok value

                        Err err ->
                            Err <| String.concat [ "Error: ", Json.errorToString err ]
