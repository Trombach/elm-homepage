module Pages.Home_ exposing (view)

import Element exposing (..)
import Element.Background as Background
import Element.Region
import Html
import Page exposing (Page)
import Request exposing (Request)
import Shared
import UI
import View exposing (View)


view : View msg
view =
    { title = "Homepage"
    , body = [ Element.layout [] <| UI.layout viewHomePage ]
    }


viewHomePage : Element msg
viewHomePage =
    row
        [ width fill
        ]
        []
