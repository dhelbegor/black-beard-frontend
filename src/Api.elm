module Api exposing (baseUrl, getModels)


baseUrl : String
baseUrl =
    "http://127.0.0.1:8000"


getModels : String
getModels =
    String.concat [ baseUrl, "/api/", "models/" ]
