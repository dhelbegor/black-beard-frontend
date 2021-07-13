module Helpers exposing (imageRenderer)

import Api exposing (baseUrl)

-- create a full url image with the base url
-- dropLeft was needed to remove an extra / from the url.
imageRenderer: String -> String
imageRenderer imgUrl =
    String.concat [baseUrl, (String.dropLeft 1 imgUrl)]
