module Themes exposing (Theme(..), ThemeInfo, getTheme)

import Element exposing (Color, rgb, rgb255)
import Element.Background as Background
import List.Extra exposing (find)


type Theme
    = Default


type alias ThemeInfo msg =
    { pageBackground : Element.Attribute msg
    }


getTheme : Theme -> ThemeInfo msg
getTheme name =
    case name of
        Default ->
            let
                bgColours =
                    [ rgb255 255 50 0
                    , rgb255 120 30 0
                    , rgb255 40 10 0
                    ]
            in
            ThemeInfo
                (Background.gradient { angle = 2.8, steps = bgColours })



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
