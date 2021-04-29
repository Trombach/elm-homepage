module Main exposing (main)

import Browser
import Browser.Navigation as Nav
import Element exposing (Element, el, fill, height, layout, px, rgb, row, spacing, text, width)
import Element.Background as Background
import Router
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


backgroundColor : Element.Color
backgroundColor =
    rgb 0.16 0.38 1


highlightColor : Element.Color
highlightColor =
    rgb 0.27 0.54 1



-- VIEW


view : Model -> Browser.Document Msg
view model =
    { title = "My Hompage"
    , body =
        [ layout [] viewNavBar

        -- , layout []
        --     (case model.route of
        --         Router.Home ->
        --             viewHomePage
        --         Router.TimeLine ->
        --             el [] (text "Time Line")
        --         Router.About ->
        --             el [] (text "About")
        --         Router.NotFound ->
        --             el [] (text "Page Not Found")
        --     )
        ]
    }



-- VIEW NAV BAR


viewNavBar : Element Msg
viewNavBar =
    row
        [ Element.explain Debug.todo
        , width fill
        , height (px 100)
        , spacing 50
        , Background.color backgroundColor
        ]
        [ text "Navbar"
        , text "Home"
        , text "Time Line"
        , text "About"
        ]



-- VIEW HOME PAGE


viewHomePage : Element Msg
viewHomePage =
    el [] (text "Home")
