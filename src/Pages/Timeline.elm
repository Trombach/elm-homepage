module Pages.Timeline exposing (view)

import Element exposing (..)
import Element.Background as Background
import Element.Border as Border
import Page exposing (Page)
import Request exposing (Request)
import Shared
import Time exposing (..)
import UI
import UiColor exposing (..)
import View exposing (View)


view : View msg
view =
    { title = "Timeline"
    , body = [ Element.layout [] <| UI.layout viewTimeLine ]
    }



-- VIEW TIME LINE


type alias Year =
    Int


type MonthYear
    = Past Month Year
    | Current


viewTimeLine : Element msg
viewTimeLine =
    column [ centerX, spacing 50 ]
        [ timeLineElement (Past Apr 2021) Current "eResearch Engagement Specialist"
        , timeLineElement (Past Aug 2019) (Past Apr 2021) "Full-Stack Developer"
        ]


timeLineElement : MonthYear -> MonthYear -> String -> Element msg
timeLineElement from to title =
    row
        [ Background.color <| color White
        , Border.width 0
        , Border.rounded 10
        , width fill
        , padding 10
        ]
        [ timeLineDate from to
        , el [ width <| fillPortion 5 ] (text title)
        ]


timeLineDate : MonthYear -> MonthYear -> Element msg
timeLineDate from to =
    column [ width <| fillPortion 1 ]
        [ el [ centerX ] (renderDate from)
        , el [ centerX ] (text "-")
        , el [ centerX ] (renderDate to)
        ]


renderDate : MonthYear -> Element msg
renderDate date =
    case date of
        Past month year ->
            text (String.join " " [ toMonth month, String.fromInt year ])

        Current ->
            text "Current"


toMonth : Month -> String
toMonth month =
    case month of
        Jan ->
            "January"

        Feb ->
            "February"

        Mar ->
            "March"

        Apr ->
            "April"

        May ->
            "May"

        Jun ->
            "June"

        Jul ->
            "July"

        Aug ->
            "August"

        Sep ->
            "September"

        Oct ->
            "October"

        Nov ->
            "November"

        Dec ->
            "December"
