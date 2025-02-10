module Model exposing (Model, setLang, setMessage, setScore)


type alias Language =
    String


type alias Model =
    { score : Int
    , lang : Language
    , message : String
    }


setScore : Model -> Int -> Model
setScore m s =
    { score = s, lang = m.lang, message = m.message }


setLang : Model -> Language -> Model
setLang m l =
    { score = m.score, lang = l, message = m.message }


setMessage : Model -> String -> Model
setMessage m msg =
    { score = m.score, lang = m.lang, message = msg }
