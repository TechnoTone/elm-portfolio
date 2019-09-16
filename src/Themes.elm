module Themes exposing (Theme(..), ThemeInfo, getColour, getTheme)

import Element exposing (Color, rgb, rgb255)
import List.Extra exposing (find)


type Theme
    = Default


type alias ThemeInfo =
    { colours : List ThemeColour }


type alias ThemeColour =
    { name : String
    , colour : Color
    }


getTheme : Theme -> ThemeInfo
getTheme name =
    case name of
        Default ->
            ThemeInfo
                [ newThemeColour "black" (rgb255 0 0 0)
                , newThemeColour "gradient1" (rgb255 0 0 0)
                , newThemeColour "gradient2" (rgb255 255 30 0)
                ]


getColour : ThemeInfo -> String -> Color
getColour theme name =
    theme.colours
        |> find (.name >> (==) name)
        |> Maybe.map .colour
        |> Maybe.withDefault (rgb255 0 0 0)


newThemeColour : String -> Color -> ThemeColour
newThemeColour name colour =
    { name = name, colour = colour }
