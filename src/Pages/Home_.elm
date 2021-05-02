module Pages.Home_ exposing (page)

import Element exposing (..)
import Page exposing (Page)
import Request exposing (Request)
import Shared
import UI
import View exposing (View)


page : Shared.Model -> Request -> Page
page _ req =
    Page.static { view = view req }


view : Request -> View Never
view req =
    { title = "Homepage"
    , body = [ UI.layout req viewHomePage |> Element.layout [] ]
    }


viewHomePage : Element Never
viewHomePage =
    row
        [ width fill
        ]
        []
