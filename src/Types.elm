module Types exposing (Msg(..), Page(..))

import Animation
import Browser
import Url


type Page
    = About
    | Games
    | P3
    | P4
    | P5


type Msg
    = UrlRequested Browser.UrlRequest
    | UrlChanged Url.Url
    | ShowPage Page
    | NextTheme
    | NoOp

type Route
    = Home
    | Test
