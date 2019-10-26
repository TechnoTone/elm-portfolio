module Colors exposing (Adjustment(..), adjust, black, blue, darkBlue, darkGrey, green, grey, lightBlue, lightGrey, red, rgbAdjust, white)

import Element exposing (Color, fromRgb, fromRgb255, rgb255, toRgb)


black : Color
black =
    grey 0


darkGrey : Color
darkGrey =
    grey 90


lightGrey : Color
lightGrey =
    grey 150


white : Color
white =
    grey 255


grey : Int -> Color
grey i =
    rgb255 i i i


red : Int -> Color
red i =
    rgb255 i 0 0


green : Int -> Color
green i =
    rgb255 0 i 0


darkBlue : Color
darkBlue =
    adjust darkGrey <| B 140


lightBlue : Color
lightBlue =
    adjust lightGrey <| B 2


blue : Int -> Color
blue i =
    rgb255 0 0 i


type Adjustment
    = Intensity Float
    | RGBA Float Float Float Float
    | RGB Float Float Float
    | R Float
    | G Float
    | B Float
    | A Float
    | Rset Float
    | Gset Float
    | Bset Float
    | Aset Float


adjust : Color -> Adjustment -> Color
adjust c adj =
    let
        rgbValues =
            toRgb c
    in
    case adj of
        Intensity x ->
            rgbAdjust c x x x x

        RGBA r g b a ->
            rgbAdjust c r g b a

        RGB r g b ->
            rgbAdjust c r g b 1

        R x ->
            rgbAdjust c x 1 1 1

        G x ->
            rgbAdjust c 1 x 1 1

        B x ->
            rgbAdjust c 1 1 x 1

        A x ->
            rgbAdjust c 1 1 1 x

        Rset x ->
            fromRgb
                { rgbValues | red = x }

        Gset x ->
            fromRgb
                { rgbValues | green = x }

        Bset x ->
            fromRgb
                { rgbValues | blue = x }

        Aset x ->
            fromRgb
                { rgbValues | alpha = x }


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
