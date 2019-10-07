module Main exposing (Model, Msg(..), init, main, update, view)

import Browser
import Colors
import Element exposing (Element, alignRight, centerY, el, fill, htmlAttribute, padding, rgb, rgb255, row, spacing, text, width)
import Element.Background as Background
import Element.Border as Border
import Element.Events exposing (onMouseEnter, onMouseLeave)
import Element.Font as Font
import Element.Input as Input
import Games.Columns exposing (..)
import Html exposing (Html)
import Html.Attributes as HtmlAttrs
import PageButton
import Themes exposing (Theme, getTheme)


type alias Model =
    { currentPage : Page
    , currentTheme : Theme
    }


init : Model
init =
    { currentPage = About
    , currentTheme = Themes.Default
    }


type Page
    = About
    | Games
    | P3
    | P4
    | P5


type Msg
    = ShowPage Page
    | NextTheme
    | NoOp


update : Msg -> Model -> Model
update msg model =
    case msg of
        ShowPage pageToShow ->
            { model | currentPage = pageToShow }

        NextTheme ->
            { model
                | currentTheme =
                    case model.currentTheme of
                        Themes.Default ->
                            Themes.RedStripe

                        Themes.RedStripe ->
                            Themes.Default
            }

        NoOp ->
            model


view : Model -> Html.Html Msg
view model =
    Element.layoutWith
        { options =
            [ Element.focusStyle noFocus
            ]
        }
        [ (getTheme model.currentTheme).pageBackground
        , padding 10
        ]
        (header model)


header : Model -> Element Msg
header model =
    Element.row
        [ Element.width fill
        , spacing 10
        ]
        [ pageButton model "About" About
        , pageButton model "Games" Games
        , pageButton model "Page 3" P3
        , pageButton model "Page 4" P4
        , pageButton model "Page 5" P5
        , themeSelectButton model
        ]


pageButton : Model -> String -> Page -> Element Msg
pageButton model label page =
    PageButton.view
        model.currentTheme
        label
        (if model.currentPage == page then
            PageButton.Selected

         else
            PageButton.Normal
        )
        (ShowPage page)


themeSelectButton : Model -> Element Msg
themeSelectButton model =
    let
        theme =
            getTheme model.currentTheme
    in
    Input.button
        [ Element.alignRight
        , Element.alignTop
        , Element.mouseOver
            [ Font.color theme.buttonText.hovered
            , Border.shadow outerShadow
            ]
        , theme.buttonBackground
        , Font.color theme.buttonText.normal
        , padding 10
        ]
        { onPress = Just NextTheme
        , label = text ("Theme : " ++ theme.name)
        }


outerShadow =
    { offset = ( 1, 2 )
    , blur = 5
    , size = 2
    , color = Element.rgba 0 0 0 0.3
    }


main =
    Browser.sandbox
        { init = init
        , update = update
        , view = view
        }


noFocus : Element.FocusStyle
noFocus =
    { borderColor = Nothing
    , backgroundColor = Nothing
    , shadow = Nothing
    }
