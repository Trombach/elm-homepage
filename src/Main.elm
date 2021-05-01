module Main exposing (main)

import Browser
import Browser.Navigation as Nav
import Element exposing (..)
import Element.Background as Background
import Element.Border as Border
import Element.Font as Font
import Element.Region
import Router exposing (Route(..))
import Time exposing (..)
import Url



-- MAIN


main : Program () Model Msg
main =
    Browser.application
        { init = init
        , view = view
        , update = update
        , subscriptions = subscriptions
        , onUrlChange = UrlChanged
        , onUrlRequest = LinkClicked
        }



-- MODEL


type alias Model =
    { key : Nav.Key
    , route : Router.Route
    }


init : () -> Url.Url -> Nav.Key -> ( Model, Cmd Msg )
init flags url key =
    ( Model key Router.Home, Cmd.none )



-- UPDATE


type Msg
    = LinkClicked Browser.UrlRequest
    | UrlChanged Url.Url


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        LinkClicked urlRequest ->
            case urlRequest of
                Browser.Internal url ->
                    ( model, Nav.pushUrl model.key (Url.toString url) )

                Browser.External href ->
                    ( model, Nav.load href )

        UrlChanged url ->
            ( { model | route = Router.toRoute url }, Cmd.none )



-- SUBSCRIPTIONS


subscriptions : Model -> Sub Msg
subscriptions _ =
    Sub.none



-- COLOR DEF


primaryColor : Element.Color
primaryColor =
    rgb255 25 34 124


primaryColorLight : Element.Color
primaryColorLight =
    rgb255 82 74 172


primaryColorDark : Element.Color
primaryColorDark =
    rgb255 0 0 79



-- VIEW


view : Model -> Browser.Document Msg
view model =
    let
        title : String
        title =
            case model.route of
                Router.Home ->
                    "Home"

                Router.TimeLine ->
                    "Time Line"

                Router.About ->
                    "About"

                Router.NotFound ->
                    "Not Found"
    in
    { title = title
    , body =
        [ layout [] <|
            column
                [ height fill
                , width fill
                ]
                [ viewNavBar
                , el [ width fill, height fill, padding 50 ] (decideRoute model.route)
                , viewFooter
                ]
        ]
    }


decideRoute : Route -> Element Msg
decideRoute route =
    case route of
        Router.Home ->
            viewHomePage

        Router.TimeLine ->
            viewTimeLine

        Router.About ->
            el [] (text "About")

        Router.NotFound ->
            el [] (text "NotFound")



-- VIEW FOOTER


viewFooter : Element Msg
viewFooter =
    row
        [ Element.Region.footer
        , width fill
        , height (px 50)
        , Background.color primaryColor
        ]
        []



-- VIEW NAV BAR


viewNavBar : Element Msg
viewNavBar =
    row
        [ Element.Region.navigation
        , width fill
        , height (px 100)
        , spacing 50
        , Background.color primaryColor
        ]
        [ image [] { src = "", description = "" }
        , navbarLink "Home" Router.Home
        , navbarLink "Time Line" Router.TimeLine
        , navbarLink "About" Router.About
        ]


navbarLink : String -> Router.Route -> Element Msg
navbarLink name route =
    link [ Font.color (rgb 1 1 1) ] { url = Router.toUrlString route, label = text name }



-- VIEW HOME PAGE


viewHomePage : Element Msg
viewHomePage =
    row
        [ width fill
        ]
        []



-- VIEW TIME LINE


type alias Year =
    Int


type MonthYear
    = Past Month Year
    | Current


viewTimeLine : Element Msg
viewTimeLine =
    column [ centerX, spacing 50 ]
        [ timeLineElement (Past Apr 2021) Current "eResearch Engagement Specialist"
        , timeLineElement (Past Aug 2019) (Past Apr 2021) "Full-Stack Developer"
        ]


timeLineElement : MonthYear -> MonthYear -> String -> Element Msg
timeLineElement from to title =
    row
        [ Border.color primaryColorLight
        , Background.color (rgb 0.9 0.9 0.9)
        , Border.width 5
        , Border.rounded 10
        , width fill
        , padding 5
        ]
        [ timeLineDate from to
        , el [ width <| fillPortion 5 ] (text title)
        ]


timeLineDate : MonthYear -> MonthYear -> Element Msg
timeLineDate from to =
    column [ width <| fillPortion 1 ]
        [ el [ centerX ] (renderDate from)
        , el [ centerX ] (text "-")
        , el [ centerX ] (renderDate to)
        ]


renderDate : MonthYear -> Element Msg
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
