module Pages.About exposing (view)

import Element exposing (Element)
import UI
import View exposing (View)


view : View msg
view =
    { title = "About"
    , body = [ Element.layout [] <| UI.layout viewTimeLine ]
    }


viewTimeLine : Element msg
viewTimeLine =
    Element.none
