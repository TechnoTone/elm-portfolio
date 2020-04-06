module Main exposing (Model, init, main, update, view)

import Browser
import Browser.Navigation as Nav
import Colors
import Element exposing (Element, alignRight, centerY, el, fill, htmlAttribute, padding, rgb, rgb255, row, spacing, text, width)
import Element.Background as Background
import Element.Border as Border
import Element.Events exposing (onMouseEnter, onMouseLeave)
import Element.Font as Font
import Element.Input as Input
import Games.Columns
import Html
import Html.Attributes
import PageButton exposing (PageButton, getPageButton)
import Themes exposing (Theme, getTheme)
import Types exposing (..)
import Url
import Url.Parser as Parser exposing ((</>), Parser)


type alias Model =
    { key : Nav.Key
    , currentRoute : Route
    , currentTheme : Theme
    , pageButtons : List PageButton
    }


initPageButtons : List PageButton
initPageButtons =
    [ { getPageButton | label = "About", page = Home }
    , { getPageButton | label = "Games", page = Games }
    , { getPageButton | label = "P3", page = P3 }
    , { getPageButton | label = "P4", page = P4 }
    , { getPageButton | label = "P5", page = P5 }
    ]


init : () -> Url.Url -> Nav.Key -> ( Model, Cmd Msg )
init _ url key =
    withNoCmd <|
        setRoute
            { key = key
            , currentRoute = Home
            , currentTheme = Themes.Default
            , pageButtons = initPageButtons
            }
            (fromUrl url)


withNoCmd : Model -> ( Model, Cmd a )
withNoCmd =
    withCmd Cmd.none


withCmd : Cmd a -> Model -> ( Model, Cmd a )
withCmd cmd model =
    ( model, cmd )


rgba r g b a =
    { red = r, blue = b, green = g, alpha = a }


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        ShowPage page ->
            ( setRoute model page
            , Nav.pushUrl model.key (routeToString page)
            )

        NextTheme ->
            ( { model
                | currentTheme =
                    case model.currentTheme of
                        Themes.Default ->
                            Themes.BlueTheme

                        Themes.BlueTheme ->
                            Themes.RedStripe

                        Themes.RedStripe ->
                            Themes.Default
              }
            , Cmd.none
            )

        Types.NoOp ->
            ( model, Cmd.none )

        UrlRequested (Browser.Internal url) ->
            ( model, Nav.pushUrl model.key (Url.toString url) )

        UrlRequested (Browser.External href) ->
            ( model, Nav.load href )

        UrlChanged url ->
            ( setRoute model <| fromUrl url
            , Cmd.none
            )


setRoute : Model -> Route -> Model
setRoute model route =
    { model
        | pageButtons =
            model.pageButtons
                |> List.map (PageButton.press route)
        , currentRoute = route
    }


view : Model -> Browser.Document Msg
view model =
    { title = "title"
    , body =
        [ Element.layoutWith
            { options =
                [ Element.focusStyle noFocus
                ]
            }
            [ (getTheme model.currentTheme).pageBackground
            , padding 10
            ]
            (Element.column
                [ Element.width fill ]
                [ header model
                , content model
                ]
            )
        ]
    }


header : Model -> Element Msg
header model =
    Element.row
        [ Element.width fill
        , spacing 10
        ]
        (List.append
            (List.map (PageButton.view model.currentTheme model.currentRoute) model.pageButtons)
            [ themeSelectButton model ]
        )


content : Model -> Element Msg
content model =
    Element.el [] (text "content")


themeSelectButton : Model -> Element Msg
themeSelectButton model =
    let
        theme =
            getTheme model.currentTheme
    in
    Input.button
        [ Element.alignRight
        , Element.alignTop
        , Element.mouseOver
            [ Font.color theme.buttonText.hovered
            , Border.shadow outerShadow
            ]
        , theme.buttonBackground
        , Font.color theme.buttonText.normal
        , padding 10
        ]
        { onPress = Just NextTheme
        , label = text ("Theme : " ++ theme.label)
        }


outerShadow =
    { offset = ( 1, 2 )
    , blur = 5
    , size = 2
    , color = Element.rgba 0 0 0 0.3
    }


main : Program () Model Msg
main =
    Browser.application
        { init = init
        , view = view
        , update = update
        , subscriptions = always Sub.none
        , onUrlRequest = UrlRequested
        , onUrlChange = UrlChanged
        }


noFocus : Element.FocusStyle
noFocus =
    { borderColor = Nothing
    , backgroundColor = Nothing
    , shadow = Nothing
    }


routeParser : Parser (Route -> a) a
routeParser =
    Parser.oneOf
        [ Parser.map Games (Parser.s "games")
        , Parser.map P3 (Parser.s "p3")
        , Parser.map P4 (Parser.s "p4")
        , Parser.map P5 (Parser.s "p5")
        ]


fromUrl : Url.Url -> Route
fromUrl url =
    Parser.parse routeParser url
        |> Maybe.withDefault Home


routeToString : Route -> String
routeToString page =
    String.join "/" (routeToPieces page)


routeToPieces : Route -> List String
routeToPieces page =
    case page of
        Home ->
            []

        Games ->
            [ "games" ]

        P3 ->
            [ "p3" ]

        P4 ->
            [ "p4" ]

        P5 ->
            [ "p5" ]
