module Main exposing (Model, Msg(..), init, main, update, view)

import Browser
import Element exposing (Element, alignRight, centerY, el, fill, htmlAttribute, padding, rgb, rgb255, row, spacing, text, width)
import Element.Background as Background
import Element.Border as Border
import Element.Events exposing (onMouseEnter, onMouseLeave)
import Element.Font as Font
import Element.Input as Input
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
    | Games


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
    Element.layoutWith
        { options =
            [ Element.focusStyle noFocus
            ]
        }
        [ model.currentTheme.pageBackground
        ]
        (viewHomePage model)


viewHomePage : Model -> Element Msg
viewHomePage model =
    Element.row []
        [ Input.button
            [ model.currentTheme.pageBackground
            , Font.color
                (if model.mouseIsHoveringOnButton || model.currentPage == Home then
                    rgb255 255 255 255

                 else
                    rgb255 255 100 100
                )
            , padding
                (if model.currentPage == Home then
                    30

                 else
                    20
                )
            , onMouseEnter MouseEntered
            , onMouseLeave MouseExited
            , htmlAttribute (HtmlAttrs.style "transition" "padding 30 ease-in")
            ]
            { onPress = Just (ShowPage Home)
            , label = text "TONY HUNT"
            }
        , Input.button
            [ model.currentTheme.pageBackground
            , Font.color
                (if model.mouseIsHoveringOnButton || model.currentPage == Games then
                    rgb255 255 255 255

                 else
                    rgb255 255 100 100
                )
            , padding
                (if model.currentPage == Home then
                    30

                 else
                    20
                )
            , onMouseEnter MouseEntered
            , onMouseLeave MouseExited
            , htmlAttribute (HtmlAttrs.style "transition" "padding 30 ease-in")
            ]
            { onPress = Just (ShowPage Games)
            , label = text "GAMES"
            }
        ]


noFocus : Element.FocusStyle
noFocus =
    { borderColor = Nothing
    , backgroundColor = Nothing
    , shadow = Nothing
    }


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
