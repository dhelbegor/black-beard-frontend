module Serializer.Decode exposing (..)

import Json.Decode as Json exposing (Decoder)
import Types exposing (Image, Model3D)


modelDecoder : Decoder Model3D
modelDecoder =
    Json.map4 Model3D
        (Json.field "id" Json.int)
        (Json.field "name" Json.string)
        (Json.field "description" Json.string)
        (Json.field "images" (Json.list imageDecoder))


imageDecoder : Decoder Image
imageDecoder =
    Json.map Image
        (Json.field "url" Json.string)
