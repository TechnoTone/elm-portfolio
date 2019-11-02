module Types exposing (Msg(..), Page(..))

import Animation


type Page
    = About
    | Games
    | P3
    | P4
    | P5


type Msg
    = ShowPage Page
    | NextTheme
    | NoOp
