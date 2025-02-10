port module Main exposing (main)

import Browser
import Html exposing (button, div, text)
import Html.Events exposing (onClick)
import String
import Http
import Json.Decode as JD
import Text
import ThankYou


main : Program () Model Msg
main =
    Browser.element { init = init, update = update, view = view, subscriptions = subscriptions }


type alias Model =
    {   score : Int
      , lang : String
      , message : String
    }


defaultLanguage : String
defaultLanguage = "de"


init : () -> ( Model, Cmd Msg )
init _ =
    ( { score = 0, lang = defaultLanguage, message = "" }, Cmd.none )


type Msg
    = Increment
    | SendScore
    | ReceiveScore Int
    | ReceiveLanguage String
    | ReceiveThankYou (Result Http.Error ThankYou.ThankYou)
    | ThankYouNumber Int


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

getThankYouNumber : Cmd Msg
getThankYouNumber =
  ThankYou.numberGenerator ThankYouNumber


thankYouDecoder : JD.Decoder ThankYou.ThankYou
thankYouDecoder =
    JD.map2 ThankYou.ThankYou
      (JD.field "kind" JD.string)
      (JD.field "content" JD.string)


getThankYou : String -> Int -> Cmd Msg
getThankYou lang n =
      Http.get
        { url = "resources/" ++ lang ++ "/thankyou/" ++ (String.fromInt n) ++ ".json"
        , expect = Http.expectJson ReceiveThankYou thankYouDecoder
        }

update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        Increment ->
            let
                newScore =
                    model.score + 1
            in
            ( 
                { score = newScore, lang = model.lang, message = model.message }
              , Cmd.batch [ scoreOut newScore, getThankYouNumber ]
            )

        ThankYouNumber n ->
            ( model, getThankYou model.lang n)

        SendScore ->
            ( model, scoreOut model.score )

        ReceiveScore score ->
            ( { score = score, lang = model.lang, message = model.message }, Cmd.none )

        ReceiveLanguage lang ->
            ( { score = model.score, lang = toLanguage(lang), message = model.message }, Cmd.none )

        ReceiveThankYou result ->
            case result of
              Ok thankYou ->
                ( { score = model.score, lang = model.lang, message = thankYou.content }, Cmd.none )
              Err _ -> 
                ( model, Cmd.none )

view : Model -> Html.Html Msg
view model =
    let t = Text.package model.lang in
    div []
        [   div [] [
              text (t.score)
            , text (": ")
            , text (String.fromInt model.score)
            , button [ onClick Increment ] [ text "+" ]
            ]
          , div [] [
              text (model.message)
            ]
        ]
