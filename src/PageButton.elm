module PageButton exposing (Style(..), view)

import Element exposing (Element, alignRight, centerY, el, fill, htmlAttribute, mouseOver, padding, rgb, rgb255, row, spacing, text, width)
import Element.Background as Background
import Element.Border as Border
import Element.Events exposing (onMouseEnter, onMouseLeave)
import Element.Font as Font
import Element.Input as Input
import Html exposing (Html)
import Html.Attributes as HtmlAttrs
import Themes exposing (Theme, getTheme)


type Style
    = Normal
    | Selected


view : Theme -> String -> Style -> msg -> Element msg
view theme label style msg =
    let
        color =
            if style == Selected then
                rgb255 255 255 255

            else
                rgb255 255 100 100
    in
    Input.button
        [ (getTheme theme).pageBackground
        , Font.color color
        , mouseOver
            [ Font.color (rgb255 255 255 255)
            ]
        , htmlAttribute (HtmlAttrs.style "transition" "padding 30 ease-in")
        , padding 30
        ]
        { onPress = Just msg
        , label = text label
        }
