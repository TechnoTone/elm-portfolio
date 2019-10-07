module Colors exposing (Adjustment(..), adjust, black, darkGrey, grey, lightGrey, rgbAdjust, rgbAdjust2, white)

import Element exposing (Color, fromRgb, fromRgb255, rgb255, toRgb)


black : Color
black =
    grey 0


darkGrey : Color
darkGrey =
    grey 70


lightGrey : Color
lightGrey =
    grey 150


white : Color
white =
    grey 255


grey : Int -> Color
grey i =
    rgb255 i i i


type Adjustment
    = Intensity Float
    | R Float
    | G Float
    | B Float
    | RGB Float Float Float
    | RGBA Float Float Float Float
    | A Float


adjust : Color -> Adjustment -> Color
adjust c a =
    let
        rgbValues =
            toRgb c
    in
    case a of
        Intensity i ->
            fromRgb
                { red = rgbValues.red * i
                , green = rgbValues.green * i
                , blue = rgbValues.blue * i
                , alpha = rgbValues.alpha
                }

        _ ->
            c


rgbAdjust : Color -> Float -> Float -> Float -> Float -> Color
rgbAdjust c r g b a =
    let
        rgbValues =
            toRgb c
    in
    fromRgb
        { red = rgbValues.red * r
        , green = rgbValues.green * g
        , blue = rgbValues.blue * b
        , alpha = rgbValues.alpha * a
        }


rgbAdjust2 c { red, green, blue, alpha } =
    let
        rgbValues =
            toRgb c
    in
    fromRgb
        { red = rgbValues.red * red
        , green = rgbValues.green * green
        , blue = rgbValues.blue * blue
        , alpha = rgbValues.alpha * alpha
        }
