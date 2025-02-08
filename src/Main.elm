port module Main exposing (main)

import Browser
import Html exposing (Html, button, div, input, text)
import Html.Events exposing (onClick)


main =
    Browser.element { init = init, update = update, view = view, subscriptions = subscriptions }


type alias Model =
    { score : Int }


init : () -> ( Model, Cmd Msg )
init _ =
    ( { score = 1 }, Cmd.none )


type Msg
    = Increment
    | SendScore
    | ReceiveScore Int


port scoreOut : Int -> Cmd msg


port scoreIn : (Int -> msg) -> Sub msg


subscriptions : Model -> Sub Msg
subscriptions _ =
    scoreIn ReceiveScore


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        Increment ->
            let
                newScore =
                    model.score + 1
            in
            ( { score = newScore }, scoreOut newScore )

        SendScore ->
            ( { score = model.score }, scoreOut model.score )

        ReceiveScore score ->
            ( { score = score }, Cmd.none )


view model =
    div []
        [ div [] [ text (String.fromInt model.score) ]
        , button [ onClick Increment ] [ text "+" ]
        ]
