module PageButton exposing (ButtonModel, init, view)

import Element exposing (Element, alignRight, centerY, el, fill, htmlAttribute, mouseOver, padding, rgb, rgb255, row, spacing, text, width)
import Element.Background as Background
import Element.Border as Border
import Element.Events exposing (onMouseEnter, onMouseLeave)
import Element.Font as Font
import Element.Input as Input
import Html exposing (Html)
import Html.Attributes as HtmlAttrs
import Themes exposing (Theme, getTheme)


type alias ButtonModel =
    { label : String
    , selected : Bool
    }


init : ButtonModel
init =
    { label = "Button"
    , selected = False
    }


view : Theme -> ButtonModel -> msg -> Element msg
view theme model msg =
    Input.button
        [ (getTheme theme).pageBackground
        , Font.color
            (if model.selected then
                rgb255 255 255 255

             else
                rgb255 255 100 100
            )
        , mouseOver
            [ Font.color (rgb255 255 255 255)
            ]
        , htmlAttribute (HtmlAttrs.style "transition" "padding 30 ease-in")
        , padding 30
        ]
        { onPress = Just msg
        , label = text model.label
        }
