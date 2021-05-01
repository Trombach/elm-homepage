module UI exposing (layout)

import Element exposing (..)
import Element.Background as Background
import Element.Border as Border
import Element.Font as Font
import Element.Region
import Gen.Route exposing (Route(..), toHref)
import UiColor exposing (..)



-- LAYOUT


layout : Element msg -> Element msg
layout children =
    column
        [ height fill
        , width fill
        ]
        [ viewNavBar
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


viewNavBar : Element msg
viewNavBar =
    row
        [ Element.Region.navigation
        , width fill
        , height (px 100)
        , spacing 50
        , Background.color <| color Primary
        ]
        [ image [] { src = "", description = "" }
        , navbarLink "Home" Home_
        , navbarLink "Time Line" Timeline
        , navbarLink "About" About
        ]


navbarLink : String -> Route -> Element msg
navbarLink name route =
    link
        [ Font.color <| color White
        , Border.rounded 5
        , padding 15
        , mouseOver [ Background.color <| color PrimaryLight ]
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
