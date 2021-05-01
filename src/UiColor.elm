module UiColor exposing (UiColor(..), color, darker)

import Element exposing (rgb, rgb255, rgba)



-- COLOR DEF


type UiColor
    = Primary
    | PrimaryLight
    | PrimaryDark
    | Grey
    | White


darker : Element.Color -> Element.Color
darker col =
    let
        rgbColor =
            Element.toRgb col
    in
    rgba (rgbColor.red * 1.1) (rgbColor.green * 1.1) (rgbColor.blue * 1.1) rgbColor.alpha


color : UiColor -> Element.Color
color uiColor =
    case uiColor of
        Primary ->
            rgb255 25 34 124

        PrimaryLight ->
            rgb255 82 74 172

        PrimaryDark ->
            rgb255 0 0 79

        Grey ->
            rgb255 207 207 207

        White ->
            rgb 1 1 1
