module Games.Columns exposing (Model, Msg(..), update, view)

import Html exposing (Html, button, div, text)


type Msg
    = NoOp


type alias Model =
    { x : String }


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        NoOp ->
            ( model, Cmd.none )


view : Model -> Html Msg
view model =
    div []
        [ div [] [ text "Columns" ]
        ]
