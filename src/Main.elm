module Main exposing (main)

import Browser
import Html exposing (Html, input, button, div, text)
import Html.Events exposing (onClick)

main =
  Browser.sandbox { init = init, update = update, view = view }

type alias Model =
  { score : Int }
    
init : Model
init = 
  { score = 1 }

type Msg = Increment | Decrement

update msg model =
  case msg of
    Increment ->
      { score = model.score + 1 }

    Decrement ->
      { score = model.score - 1 }

view model =
  div []
    [ button [ onClick Decrement ] [ text "-" ]
    , div [] [ text (String.fromInt model.score) ]
    , button [ onClick Increment ] [ text "+" ]
    ]

