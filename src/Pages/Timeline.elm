module Pages.Timeline exposing (page)

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


page : Shared.Model -> Request -> Page
page model req =
    Page.static { view = view req }


view : Request -> View Never
view req =
    { title = "Timeline"
    , body = [ UI.layout req viewTimeLine |> Element.layout [] ]
    }



-- VIEW TIME LINE


type alias Year =
    Int


type MonthYear
    = Past Month Year
    | Current


viewTimeLine : Element Never
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
        , Border.shadow
            { offset = ( 0, 5 )
            , size = 1
            , blur = 10
            , color = rgb255 190 190 190
            }
        , width fill
        , padding 10
        , mouseOver
            [ Border.shadow
                { offset = ( 0, 5 )
                , size = 10
                , blur = 10
                , color = rgb255 190 190 190
                }
            ]
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
