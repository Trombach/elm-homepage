module Router exposing (..)

import Url
import Url.Builder as UB
import Url.Parser as UP exposing ((</>), Parser, map, oneOf, s, top)



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


toUrlString : Route -> String
toUrlString route =
    case route of
        Home ->
            UB.relative [ "/" ] []

        TimeLine ->
            UB.relative [ "timeline" ] []

        About ->
            UB.relative [ "about" ] []

        NotFound ->
            UB.relative [ "notFound" ] []
