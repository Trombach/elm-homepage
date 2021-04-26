module Main exposing (main)

import Bootstrap.Navbar as Navbar
import Browser
import Browser.Navigation as Nav
import Html exposing (..)
import Html.Attributes exposing (href)
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
    , navbarState : Navbar.State
    }


init : () -> Url.Url -> Nav.Key -> ( Model, Cmd Msg )
init flags url key =
    ( Model key Router.Home navbarState, Cmd.none )


navbarState : Navbar.State
navbarState =
    Tuple.first (Navbar.initialState NavbarMsg)



-- UPDATE


type Msg
    = LinkClicked Browser.UrlRequest
    | UrlChanged Url.Url
    | NavbarMsg Navbar.State


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

        NavbarMsg state ->
            ( { model | navbarState = state }, Cmd.none )



-- SUBSCRIPTIONS


subscriptions : Model -> Sub Msg
subscriptions model =
    Navbar.subscriptions model.navbarState NavbarMsg



-- VIEW


view : Model -> Browser.Document Msg
view model =
    { title = "My Hompage"
    , body =
        [ viewNavBar model
        , case model.route of
            Router.Home ->
                viewHomePage

            Router.TimeLine ->
                div [] []

            Router.About ->
                div [] []

            Router.NotFound ->
                div [] []
        ]
    }



-- VIEW NAV BAR


viewNavBar : Model -> Html Msg
viewNavBar model =
    Navbar.config NavbarMsg
        |> Navbar.withAnimation
        |> Navbar.brand [ href "#" ] [ text "Me" ]
        |> Navbar.items
            [ Navbar.itemLink [ href "home" ] [ text "Home" ] ]
        |> Navbar.view model.navbarState



-- VIEW HOME PAGE


viewHomePage : Html Msg
viewHomePage =
    div [] []
