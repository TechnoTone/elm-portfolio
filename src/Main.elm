module Main exposing (Model, Msg(..), init, main, update, view)

import Browser
import Element exposing (Element, alignRight, centerY, el, fill, padding, rgb, rgb255, row, spacing, text, width)
import Element.Background as Background
import Element.Border as Border
import Element.Font as Font
import Games.Columns exposing (..)
import Html exposing (Html)
import Themes exposing (ThemeInfo, getColour, getTheme)


main =
    Browser.sandbox { init = init, update = update, view = view }


type alias Model =
    { currentPage : Page
    , currentTheme : ThemeInfo
    }


init : Model
init =
    { currentPage = Home
    , currentTheme = getTheme Themes.Default
    }


type Page
    = Home


type Msg
    = ShowPage Page


update : Msg -> Model -> Model
update msg model =
    case msg of
        ShowPage pageToShow ->
            { model | currentPage = pageToShow }


view : Model -> Html.Html Msg
view model =
    let
        ( c1, c2 ) =
            myGradientColours model
    in
    Element.layout
        [ myGradient 0.95 c1 c2
        ]
        (case model.currentPage of
            Home ->
                viewHomePage model
        )


myGradient : Float -> Element.Color -> Element.Color -> Element.Attribute msg
myGradient angle c1 c2 =
    Background.gradient { angle = 2 * pi * angle, steps = [ c1, c2 ] }


myGradientColours : Model -> ( Element.Color, Element.Color )
myGradientColours model =
    ( getColour model.currentTheme "gradient1"
    , getColour model.currentTheme "gradient2"
    )


viewHomePage : Model -> Element msg
viewHomePage model =
    let
        ( c1, c2 ) =
            myGradientColours model
    in
    el
        [ myGradient 0.95 c1 c2
        , Font.color (rgb255 255 255 255)
        , Border.rounded 0
        , padding 30
        ]
        (text "TONY HUNT")


myRowOfStuff : Element msg
myRowOfStuff =
    row [ width fill, centerY, spacing 30 ]
        [ myElement
        , myElement
        , el [ alignRight ] myElement
        ]


myElement : Element msg
myElement =
    el
        [ Background.color (rgb255 240 0 245)
        , Font.color (rgb255 255 255 255)
        , Border.rounded 3
        , padding 30
        ]
        (text "stylish!")
