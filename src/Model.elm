module Model exposing (Model, Page(..), defaultLanguage, new, setError, setLang, setMenu, setMessage, setPage, setScore, toggleMenu, setThankYouCount)


type Page
    = Main
    | Help
    | SetScore


type alias Language =
    String


type alias Model =
    { score : Int
    , lang : Language
    , message : String
    , error : Bool
    , menu : Bool
    , page : Page
    , thankYouCount : Maybe Int
    }


defaultLanguage : String
defaultLanguage =
    "de"


new : Model
new =
    { score = 0, lang = defaultLanguage, message = "", error = False, menu = False, page = Main, thankYouCount = Nothing }


setScore : Model -> Int -> Model
setScore m s =
    { score = s, lang = m.lang, message = m.message, error = m.error, menu = m.menu, page = m.page, thankYouCount = m.thankYouCount }


setLang : Model -> Language -> Model
setLang m l =
    { score = m.score, lang = l, message = m.message, error = m.error, menu = m.menu, page = m.page, thankYouCount = m.thankYouCount }


setMessage : Model -> String -> Model
setMessage m msg =
    { score = m.score, lang = m.lang, message = msg, error = m.error, menu = m.menu, page = m.page, thankYouCount = m.thankYouCount }


setError : Model -> Bool -> Model
setError m e =
    { score = m.score, lang = m.lang, message = m.message, error = e, menu = m.menu, page = m.page, thankYouCount = m.thankYouCount }


setMenu : Model -> Bool -> Model
setMenu m me =
    { score = m.score, lang = m.lang, message = m.message, error = m.error, menu = me, page = m.page, thankYouCount = m.thankYouCount }


toggleMenu : Model -> Model
toggleMenu m =
    setMenu m (not m.menu)


setPage : Model -> Page -> Model
setPage m p =
    { score = m.score, lang = m.lang, message = m.message, error = m.error, menu = m.menu, page = p, thankYouCount = m.thankYouCount }

setThankYouCount : Model -> Maybe Int -> Model
setThankYouCount m c =
    { score = m.score, lang = m.lang, message = m.message, error = m.error, menu = m.menu, page = m.page, thankYouCount = c }

