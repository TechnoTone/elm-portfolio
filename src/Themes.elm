module Themes exposing (Theme(..), ThemeInfo, getTheme)

import Colors
import Element exposing (Color, rgb, rgb255)
import Element.Background as Background
import List.Extra exposing (find)


type Theme
    = Default
    | RedStripe


type alias ThemeInfo decorative msg =
    { name : String
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
getTheme name =
    case name of
        Default ->
            { name = "Default"
            , pageBackground = Background.color Colors.lightGrey
            , buttonBackground = Background.color Colors.darkGrey
            , buttonText = getColorOptions Colors.lightGrey Colors.white Colors.white Colors.black
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
            { name = "RedStripe"
            , pageBackground = Background.gradient { angle = 2.8, steps = bgColours }
            , buttonBackground = Background.color (rgb255 200 100 100)
            , buttonText = getColorOptions (rgb255 255 100 100) Colors.white Colors.white Colors.black
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
