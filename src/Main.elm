module Main exposing (main)

import Browser
import Html exposing (Html, input, button, div, text)
import Html.Events exposing (onClick)

main =
  Browser.sandbox { init = 0, update = update, view = view }

type Msg = Increment | Decrement

update msg model =
  case msg of
    Increment ->
      model + 1

    Decrement ->
      model - 1

view model =
  div []
    [ input [ onClick Decrement ] [ text "-" ]
    , div [] [ text (String.fromInt model) ]
    , button [ onClick Increment ] [ text "+" ]
    ]

{-
import Browser
import Html exposing (Html, div, h1, text)
import Html.Attributes exposing (style)

main : Program () Model Msg
main =
    Browser.sandbox { init = init, update = update, view = view }

type alias Model =
    {}

init : Model
init =
    {}

type Msg
    = NoOp

update : Msg -> Model -> Model
update msg model =
    case msg of
        NoOp ->
            model

view : Model -> Html Msg
view model =
    div [ style "text-align" "center" ]
        [ h1 [] [ text "Hello, Elm!" ]
        ]
-}
