module Main exposing (Model, Msg(..), init, main, update, view)

import Browser
import Element exposing (Element, alignRight, centerY, el, fill, htmlAttribute, padding, rgb, rgb255, row, spacing, text, width)
import Element.Background as Background
import Element.Border as Border
import Element.Events exposing (onMouseEnter, onMouseLeave)
import Element.Font as Font
import Games.Columns exposing (..)
import Html exposing (Html)
import Html.Attributes as HtmlAttrs
import Themes exposing (ThemeInfo, getTheme)


type alias Model =
    { currentPage : Page
    , currentTheme : ThemeInfo Msg
    , mouseIsHoveringOnButton : Bool
    }


init : Model
init =
    { currentPage = Home
    , currentTheme = getTheme Themes.Default
    , mouseIsHoveringOnButton = False
    }


type Page
    = Home


type Msg
    = ShowPage Page
    | MouseEntered
    | MouseExited


update : Msg -> Model -> Model
update msg model =
    case msg of
        ShowPage pageToShow ->
            { model | currentPage = pageToShow }

        MouseEntered ->
            { model | mouseIsHoveringOnButton = True }

        MouseExited ->
            { model | mouseIsHoveringOnButton = False }


view : Model -> Html.Html Msg
view model =
    Element.layout
        [ model.currentTheme.pageBackground
        ]
        (case model.currentPage of
            Home ->
                viewHomePage model
        )


viewHomePage : Model -> Element Msg
viewHomePage model =
    el
        [ model.currentTheme.pageBackground
        , Font.color (rgb255 255 255 255)
        , Border.rounded
            (if model.mouseIsHoveringOnButton then
                20

             else
                0
            )
        , padding 30
        , onMouseEnter MouseEntered
        , onMouseLeave MouseExited
        , htmlAttribute (HtmlAttrs.style "transition" "border-radius 0.2s ease-in")
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


main =
    Browser.sandbox
        { init = init
        , update = update
        , view = view
        }
