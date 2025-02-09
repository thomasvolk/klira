port module Main exposing (main)

import Browser
import Html exposing (Html, button, div, input, text)
import Html.Events exposing (onClick)
import String exposing (length, slice)
import Text


main =
    Browser.element { init = init, update = update, view = view, subscriptions = subscriptions }


type alias Model =
    {   score : Int
      , lang : String }


defaultLanguage = "de"


init : () -> ( Model, Cmd Msg )
init _ =
    ( { score = 0, lang = defaultLanguage }, Cmd.none )


type Msg
    = Increment
    | SendScore
    | ReceiveScore Int
    | ReceiveLanguage String


port scoreOut : Int -> Cmd msg


port scoreIn : (Int -> msg) -> Sub msg


port languageIn : (String -> msg) -> Sub msg


toLanguage : String -> String
toLanguage lang =
  if String.length lang < 2 then
    defaultLanguage 
  else
    String.slice 0 2 lang



subscriptions : Model -> Sub Msg
subscriptions _ =
  Sub.batch [
      scoreIn ReceiveScore
    , languageIn ReceiveLanguage 
  ]

update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        Increment ->
            let
                newScore =
                    model.score + 1
            in
            ( { score = newScore, lang = model.lang }, scoreOut newScore )

        SendScore ->
            ( model, scoreOut model.score )

        ReceiveScore score ->
            ( { score = score, lang = model.lang }, Cmd.none )

        ReceiveLanguage lang ->
            ( { score = model.score, lang = toLanguage(lang) }, Cmd.none )


view model =
    let t = Text.package model.lang in
    div []
        [ div [] [
            text (t.score)
          , text (": ")
          , text (String.fromInt model.score)
          , button [ onClick Increment ] [ text "+" ]
        ]
      ]
