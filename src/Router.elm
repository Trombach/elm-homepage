module Router exposing (..)

import Url
import Url.Parser as UP exposing ((</>), Parser, int, map, oneOf, s, string, top)



-- ROUTING


type Route
    = Home
    | TimeLine
    | About
    | NotFound


routeParser : Parser (Route -> a) a
routeParser =
    oneOf
        [ map Home top
        , map TimeLine (s "timeline")
        , map About (s "about")
        ]


toRoute : Url.Url -> Route
toRoute url =
    Maybe.withDefault NotFound (UP.parse routeParser url)
