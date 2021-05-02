module UI exposing (layout)

import Element exposing (..)
import Element.Background as Background
import Element.Border as Border
import Element.Font as Font
import Element.Region
import Gen.Route exposing (Route(..), toHref)
import Request exposing (Request)
import Shared exposing (..)
import UiColor exposing (..)



-- LAYOUT


layout : Request -> Element msg -> Element msg
layout req children =
    column
        [ height fill
        , width fill
        ]
        [ viewNavBar req.route
        , el
            [ width fill
            , height fill
            , padding 50
            , Background.color <| color Grey
            ]
            children
        , viewFooter
        ]



-- VIEW ELEMENTS


viewNavBar : Route -> Element msg
viewNavBar activeRoute =
    row
        [ Element.Region.navigation
        , width fill
        , height (px 100)
        , spacing 50
        , color Primary |> Background.color
        ]
        [ image [] { src = "", description = "" }
        , navbarLink "Home" Home_ activeRoute
        , navbarLink "Time Line" Timeline activeRoute
        , navbarLink "About" About activeRoute
        ]


navbarLink : String -> Route -> Route -> Element msg
navbarLink name route activeRoute =
    link
        [ Font.color <| color White
        , Border.rounded 5
        , padding 15
        , mouseOver [ Background.color <| color PrimaryLight ]
        , Border.width 1
        , if route == activeRoute then
            Border.color <| color White

          else
            Border.color <| color Primary
        ]
        { url = toHref route, label = text name }



-- VIEW FOOTER


viewFooter : Element msg
viewFooter =
    row
        [ Element.Region.footer
        , width fill
        , height (px 50)
        , Background.color <| color PrimaryDark
        ]
        []
