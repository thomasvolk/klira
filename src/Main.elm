port module Main exposing (main)

import Browser
import Html exposing (a, button, div, input, span, text, p)
import Html.Attributes exposing (class, href, style, type_, value)
import Html.Events exposing (onClick, onInput)
import Http
import Json.Decode as JD
import Model exposing (Model, Page(..), setError, setLang, setMenu, setMessage, setPage, setScore, toggleMenu, setThankYouCount)
import String
import Text
import ThankYou
import Model exposing (setThankYouCount)


type Msg
    = Increment
    | SendScore
    | ReceiveScore Int
    | ReceiveLanguage String
    | ReceiveThankYou (Result Http.Error ThankYou.ThankYou)
    | ReceiveThankYouConfig (Result Http.Error ThankYou.Config)
    | ThankYouNumber Int
    | ToggleMenu
    | OpenPage Page
    | ResetScore String


main : Program () Model Msg
main =
    Browser.element { init = init, update = update, view = view, subscriptions = subscriptions }


init : () -> ( Model, Cmd Msg )
init _ =
    ( Model.new, Cmd.none )


port scoreOut : Int -> Cmd msg


port scoreIn : (Int -> msg) -> Sub msg


port languageIn : (String -> msg) -> Sub msg


toLanguage : String -> String
toLanguage lang =
    if String.length lang < 2 then
        Model.defaultLanguage

    else
        String.slice 0 2 lang


subscriptions : Model -> Sub Msg
subscriptions _ =
    Sub.batch
        [ scoreIn ReceiveScore
        , languageIn ReceiveLanguage
        ]


getThankYouNumber : Int -> Cmd Msg
getThankYouNumber count =
    ThankYou.choose count ThankYouNumber


thankYouDecoder : JD.Decoder ThankYou.ThankYou
thankYouDecoder =
    JD.map2 ThankYou.ThankYou
        (JD.field "kind" JD.string)
        (JD.field "content" JD.string)


getThankYou : String -> Int -> Cmd Msg
getThankYou lang n =
    Http.get
        { url = "resources/" ++ "thankyou/" ++ lang ++ "/" ++ String.fromInt n ++ ".json"
        , expect = Http.expectJson ReceiveThankYou thankYouDecoder
        }


thankYouConfigDecoder : JD.Decoder ThankYou.Config
thankYouConfigDecoder =
    JD.map ThankYou.Config
        (JD.field "count" JD.int)


getThankYouConfig : String -> Cmd Msg
getThankYouConfig lang = 
    Http.get
        { url = "resources/" ++ "thankyou/" ++ lang ++ "/0.config.json"
        , expect = Http.expectJson ReceiveThankYouConfig thankYouConfigDecoder
        }


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        ToggleMenu ->
            ( toggleMenu model, Cmd.none )

        Increment ->
            let
                newScore =
                    model.score + 1
            in
            let nextCmd = case model.thankYouCount of
                            Just count ->
                              [ getThankYouNumber count ]
                            Nothing ->
                              [ getThankYouConfig  model.lang ]
            in
            ( setScore model newScore
            , Cmd.batch ([ scoreOut newScore ]  ++ nextCmd)
            )

        ThankYouNumber n ->
            ( model, getThankYou model.lang n )

        SendScore ->
            ( model, scoreOut model.score )

        ReceiveScore score ->
            ( setScore model score, scoreOut score )

        ReceiveLanguage lang ->
            ( setLang model (toLanguage lang), Cmd.none )

        ReceiveThankYou result ->
            case result of
                Ok thankYou ->
                    ( setMessage model thankYou.content, Cmd.none )

                Err _ ->
                    ( setError model True, Cmd.none )

        ReceiveThankYouConfig config ->
            case config of
                Ok cfg ->
                    ( setThankYouCount model (Just cfg.count), getThankYouNumber cfg.count )

                Err _ ->
                    ( setError model True, Cmd.none )

        OpenPage p ->
            ( setMenu (setPage model p) False, Cmd.none )

        ResetScore s ->
            case String.toInt s of
                Just i ->
                    ( setScore model i, scoreOut i )

                Nothing ->
                    ( setScore model 0, Cmd.none )


mainPage : Model -> Text.Package -> Html.Html Msg
mainPage model t =
    let
        navLinksAttr =
            if model.menu then
                []

            else
                [ style "display" "none" ]
    in
    div []
        [ div [ class "section" ]
            [ div [ class "header" ]
                [ div [ class "menu" ]
                    [ div [] [ button [ class "menu-button", onClick ToggleMenu ] [ text "☰" ] ]
                    ]
                ]
            , div []
                [ text "Klira"
                ]
            ]
        , div (navLinksAttr ++ [ class "nav-links" ])
            [ a [ href "#", onClick (OpenPage SetScore) ] [ text t.reset ]
            , a [ href "#", onClick (OpenPage Help) ] [ text t.help ]
            ]
        , div [ class "section" ]
            [ div []
                [ span []
                    [ text t.score
                    , text ": "
                    ]
                , span []
                    [ text (String.fromInt model.score)
                    ]
                ]
            ]
        , div [ class "section" ]
            [ div []
                [ span []
                    [ button [ class "plus-button", onClick Increment ] [ text "+" ]
                    ]
                ]
            ]
        , div [ class "section" ]
            [ div [ class "message" ]
                [ text model.message
                ]
            ]
        ]


dialog : Model -> String -> (Model -> Html.Html Msg) -> Html.Html Msg
dialog model title f =
    div []
        [ div [ class "section" ]
            [ div [ class "header" ]
                [ div [ class "menu" ]
                    [ div [] [ button [ class "menu-button", onClick (OpenPage Main) ] [ text "X" ] ]
                    ]
                ]
            , div []
                [ text title
                ]
            ]
        , div [ class "section" ]
            [ f model ]
        ]


setScorePage : Text.Package -> Model -> Html.Html Msg
setScorePage t model =
    div []
        [ div [ class "section" ]
            [ text t.setScore
            , text ":"
            ]
        , div [ class "section" ]
            [ input [ type_ "number", value (String.fromInt model.score), onInput ResetScore ] []
            ]
        ]


helpPage : Text.Package -> Model -> Html.Html Msg
helpPage t _ =
    let hs = String.split "\n" t.helpText |> List.map (\s -> p [] [ text s ] )
    in
    div [] hs


view : Model -> Html.Html Msg
view model =
    let
        t =
            Text.package model.lang
    in
    case model.page of
        Main ->
            mainPage model t

        Help ->
            dialog model t.help (helpPage t)

        SetScore ->
            dialog model t.reset (setScorePage t)
