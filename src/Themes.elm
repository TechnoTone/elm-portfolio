module Themes exposing (Theme(..), ThemeInfo, getTheme)

import Colors exposing (..)
import Element exposing (Color, rgb, rgb255)
import Element.Background as Background
import List.Extra exposing (find)


type Theme
    = Default
    | BlueTheme
    | RedStripe


type alias ThemeInfo decorative msg =
    { label : String
    , pageBackground : Element.Attr decorative msg
    , buttonBackground : Element.Attr decorative msg
    , buttonText : ColorOptions
    }


type alias ColorOptions =
    { normal : Color
    , hovered : Color
    , selected : Color
    , disabled : Color
    }


getColorOptions : Color -> Color -> Color -> Color -> ColorOptions
getColorOptions c1 c2 c3 c4 =
    { normal = c1
    , hovered = c2
    , selected = c3
    , disabled = c4
    }


getTheme : Theme -> ThemeInfo decorative msg
getTheme theme =
    case theme of
        Default ->
            { label = "Default"
            , pageBackground = Background.color lightGrey
            , buttonBackground = Background.color darkGrey
            , buttonText = getColorOptions lightGrey white white black
            }

        BlueTheme ->
            { label = "Blue"
            , pageBackground = Background.color darkBlue
            , buttonBackground = Background.color lightBlue
            , buttonText = getColorOptions darkGrey white white black
            }

        RedStripe ->
            let
                bgColours =
                    [ rgb255 255 50 0
                    , rgb255 40 10 0
                    , rgb255 120 30 0
                    , rgb255 40 10 0
                    ]
            in
            { label = "RedStripe"
            , pageBackground = Background.gradient { angle = 2.8, steps = bgColours }
            , buttonBackground = Background.color (rgb255 200 100 100)
            , buttonText = getColorOptions (rgb255 255 100 100) white white black
            }



-- type alias ThemeColour =
--     { name : String
--     , colour : Color
--     }
-- getColour : ThemeInfo msg -> String -> Color
-- getColour theme name =
--     theme.colours
--         |> find (.name >> (==) name)
--         |> Maybe.map .colour
--         |> Maybe.withDefault (rgb255 0 0 0)
-- newThemeColour : String -> Color -> ThemeColour
-- newThemeColour name colour =
--     { name = name, colour = colour }
