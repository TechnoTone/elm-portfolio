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
import Types exposing (Msg(..), Page(..))
import Url


type alias Model =
    { currentPage : Page
    , currentTheme : Theme
    , pageButtons : List PageButton
    }


initPageButtons : List PageButton
initPageButtons =
    [ { getPageButton | label = "About", page = About }
    , { getPageButton | label = "Games", page = Games }
    , { getPageButton | label = "P3", page = P3 }
    , { getPageButton | label = "P4", page = P4 }
    , { getPageButton | label = "P5", page = P5 }
    ]


init : () -> Url.Url -> Nav.Key -> ( Model, Cmd Msg )
init flags url key =
    (    { currentPage = About
    , currentTheme = Themes.Default
    , pageButtons = initPageButtons
    }, Cmd.none)


rgba r g b a =
    { red = r, blue = b, green = g, alpha = a }


update : Msg -> Model -> (Model, Cmd Msg)
update msg model =
    case msg of
        ShowPage page ->
            ({ model
                | pageButtons =
                    model.pageButtons
                        |> List.map (PageButton.press page)
                , currentPage = page
            },Cmd.none)

        NextTheme ->
            ({ model
                | currentTheme =
                    case model.currentTheme of
                        Themes.Default ->
                            Themes.BlueTheme

                        Themes.BlueTheme ->
                            Themes.RedStripe

                        Themes.RedStripe ->
                            Themes.Default
            },Cmd.none)

        Types.NoOp ->
            (model,Cmd.none)

        UrlRequested urlRequest ->
            (model,Cmd.none)


        UrlChanged url ->
            (model,Cmd.none)



view : Model -> Browser.Document Msg
view model =
    { title = "title"
    , body =
       [
        Element.layoutWith
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
            (List.map (PageButton.view model.currentTheme model.currentPage) model.pageButtons)
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


