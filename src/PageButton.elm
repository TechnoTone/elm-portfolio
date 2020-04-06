module PageButton exposing (PageButton, Style(..), getPageButton, getStyle, onAnimation, press, view)

import Animation
import Element exposing (Element, alignRight, centerY, el, fill, focused, htmlAttribute, mouseOver, padding, rgb, rgb255, row, text, width)
import Element.Background as Background
import Element.Border as Border
import Element.Events exposing (onMouseEnter, onMouseLeave)
import Element.Font as Font
import Element.Input as Input
import Html exposing (Html)
import Html.Attributes as HtmlAttrs
import Themes exposing (Theme, getTheme)
import Types exposing (Msg(..), Route(..))


type Style
    = Normal
    | Selected


type alias PageButton =
    { label : String
    , page : Route
    , style : Style
    , animationState : Animation.State
    }


getStyle : Bool -> Style
getStyle b =
    if b then
        Selected

    else
        Normal


getPageButton : PageButton
getPageButton =
    { label = ""
    , page = Home
    , style = Normal
    , animationState =
        Animation.style
            [ Animation.shadow
                { offsetX = 0
                , offsetY = 0
                , size = 0
                , blur = 0
                , color = { red = 0, blue = 0, green = 0, alpha = 0 }
                }
            ]
    }


view : Theme -> Route -> PageButton -> Element Msg
view theme page pageButton =
    let
        themeInfo =
            getTheme theme

        ( color, shadow ) =
            if pageButton.style == Selected then
                ( themeInfo.buttonText.selected
                , Border.innerShadow innerShadow
                )

            else
                ( themeInfo.buttonText.normal
                , Border.shadow outerShadow
                )
    in
    Element.el
        (Animation.render pageButton.animationState |> List.map Element.htmlAttribute)
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
            { onPress = Just <| ShowPage pageButton.page
            , label = text pageButton.label
            }
        )


innerShadow =
    { offset = ( 2, 2 )
    , blur = 5
    , size = 4
    , color = Element.rgba 0 0 0 0.4
    }


outerShadow =
    { offset = ( 1, 2 )
    , blur = 5
    , size = 2
    , color = Element.rgba 0 0 0 0.3
    }


onAnimation : (Animation.State -> Animation.State) -> PageButton -> PageButton
onAnimation animationFn btn =
    { btn | animationState = animationFn btn.animationState }


press : Route -> PageButton -> PageButton
press pageToShow button =
    if button.page == pageToShow then
        { button
            | style = Selected
            , animationState =
                Animation.interrupt
                    [ Animation.set
                        [ Animation.shadow
                            { offsetX = 0
                            , offsetY = 0
                            , size = 0
                            , blur = 15
                            , color = rgba 0 0 0 1
                            }
                        ]
                    , Animation.to
                        [ Animation.shadow
                            { offsetX = 0
                            , offsetY = 0
                            , size = 20
                            , blur = 30
                            , color = rgba 0 0 0 0.0
                            }
                        ]
                    ]
                    button.animationState
        }

    else
        { button | style = Normal }


rgba r g b a =
    { red = r, blue = b, green = g, alpha = a }
