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
import PageButton exposing (ButtonModel, init)
import Themes exposing (Theme, getTheme)


type alias Model =
    { pageButtons : PageButtonsModel
    , currentPage : Page
    , currentTheme : Theme
    }


type alias PageButtonsModel =
    { home : ButtonModel
    }


init : Model
init =
    { pageButtons = { home = PageButton.init }
    , currentPage = Home
    , currentTheme = Themes.Default
    }


type Page
    = Home
    | Games


type Msg
    = ShowPage Page
    | NoOp


update : Msg -> Model -> Model
update msg model =
    case msg of
        ShowPage pageToShow ->
            { model | currentPage = pageToShow }

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
        ]
        (viewHomePage model)


viewHomePage model =
    Element.row []
        [ PageButton.view
            model.currentTheme
            model.pageButtons.home
            (ShowPage Home)
        ]


noFocus : Element.FocusStyle
noFocus =
    { borderColor = Nothing
    , backgroundColor = Nothing
    , shadow = Nothing
    }


main =
    Browser.sandbox
        { init = init
        , update = update
        , view = view
        }
