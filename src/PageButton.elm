module PageButton exposing (Style(..), view)

import Element exposing (Element, alignRight, centerY, el, fill, focused, htmlAttribute, mouseOver, padding, rgb, rgb255, row, text, width)
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
        themeInfo =
            getTheme theme

        color =
            if style == Selected then
                themeInfo.buttonText.selected

            else
                themeInfo.buttonText.normal

        shadow =
            if style == Selected then
                Border.innerShadow innerShadow

            else
                Border.shadow outerShadow
    in
    Element.el
        []
        (Input.button
            [ themeInfo.buttonBackground
            , shadow
            , Font.color color
            , mouseOver
                [ Font.color themeInfo.buttonText.hovered
                ]
            , htmlAttribute (HtmlAttrs.style "transition" "padding 30 ease-in")
            , padding 30
            ]
            { onPress = Just msg
            , label = text label
            }
        )


innerShadow =
    { offset = ( 2, 2 )
    , blur = 5
    , size = 4
    , color = Element.rgba 0 0 0 0.2
    }


outerShadow =
    { offset = ( 1, 2 )
    , blur = 5
    , size = 2
    , color = Element.rgba 0 0 0 0.3
    }
