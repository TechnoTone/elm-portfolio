module Main exposing (Model, Msg(..), init, main, update, view)

import Browser
import Games.Columns exposing (..)
import Html exposing (Html, button, div, text)
import Html.Events exposing (onClick)


main =
    Browser.sandbox { init = init, update = update, view = view }


type alias Model =
    { currentPage : Page }


init : Model
init =
    { currentPage = Home }


type Page
    = Home


type Msg
    = ShowPage Page


update : Msg -> Model -> Model
update msg model =
    case msg of
        ShowPage pageToShow ->
            { model | currentPage = pageToShow }


view : Model -> Html Msg
view model =
    div []
        [ div [] [ text "Home page" ]
        ]
