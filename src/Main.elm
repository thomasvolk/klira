port module Main exposing (main)

import Browser
import Html exposing (Html, input, button, div, text)
import Html.Events exposing (onClick)

main =
  Browser.element { init = init, update = update, view = view, subscriptions = subscriptions }

type alias Model =
  { score : Int }
    
init : () -> ( Model, Cmd Msg )
init _ = 
  ({ score = 1 }, Cmd.none)

type Msg = Increment | SendScore | ReceiveScore Int

port sendScore : Int -> Cmd msg

port receiveScore : (Int -> msg) -> Sub msg

subscriptions : Model -> Sub Msg
subscriptions _ =
    receiveScore ReceiveScore 

update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
  case msg of
    Increment ->
      let newScore = model.score + 1 in
      ({ score = newScore }, sendScore newScore)
    SendScore ->
      ({ score = model.score }, sendScore model.score)
    ReceiveScore score ->
      ({ score = score }, Cmd.none)


view model =
  div []
    [ div [] [ text (String.fromInt model.score) ]
    , button [ onClick Increment ] [ text "+" ]
    ]

