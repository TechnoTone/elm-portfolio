module Types exposing (Msg(..), Route(..))

import Animation
import Browser
import Url


type Route
    = Home
    | Games
    | P3
    | P4
    | P5


type Msg
    = UrlRequested Browser.UrlRequest
    | UrlChanged Url.Url
    | ShowPage Route
    | NextTheme
    | NoOp
