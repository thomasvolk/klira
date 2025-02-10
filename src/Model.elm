module Model exposing (Model, defaultLanguage, new, setLang, setMessage, setScore, setError)


type alias Language =
    String


type alias Model =
    { score : Int
    , lang : Language
    , message : String
    , error : Bool
    }


defaultLanguage : String
defaultLanguage =
    "de"


new : Model
new = { score = 0, lang = defaultLanguage, message = "" , error = False }


setScore : Model -> Int -> Model
setScore m s =
    { score = s, lang = m.lang, message = m.message, error = m.error }


setLang : Model -> Language -> Model
setLang m l =
    { score = m.score, lang = l, message = m.message, error = m.error }


setMessage : Model -> String -> Model
setMessage m msg =
    { score = m.score, lang = m.lang, message = msg, error = m.error }


setError : Model -> Bool -> Model
setError m e = 
    { score = m.score, lang = m.lang, message = m.message, error = e }
