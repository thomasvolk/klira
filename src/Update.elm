module Update exposing (..)

import Model exposing (Page)
import Http
import ThankYou


type Msg
    = Increment
    | SendScore
    | ReceiveScore Int
    | ReceiveLanguage String
    | ReceiveThankYou (Result Http.Error ThankYou.ThankYou)
    | ThankYouNumber Int
    | ToggleMenu
    | OpenPage Page
    | ResetScore String

