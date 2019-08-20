module Games.View exposing (view)

import Games.Columns as Columns exposing (Model)
import Html exposing (Html, button, div, text)


type Msg
    = NoOp


type alias Model =
    { columnsModel : Columns.Model
    }


view : Model -> Html Msg
view model =
    div []
        [ div [] [ text "Games" ]
        ]
