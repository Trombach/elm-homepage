module Pages.About exposing (page)

import Element exposing (Element)
import Page exposing (Page)
import Request exposing (Request)
import Shared exposing (Msg)
import UI
import View exposing (View)


page : Shared.Model -> Request -> Page
page model req =
    Page.static { view = view req }


view : Request -> View msg
view req =
    { title = "About"
    , body = [ UI.layout req viewTimeLine |> Element.layout [] ]
    }


viewTimeLine : Element msg
viewTimeLine =
    Element.none
