module Text exposing (Package, package)

import Dict


type alias Package =
    { title : String
    , score : String
    , reset : String
    , help : String
    , helpText : String
    , setScore : String
    }


dePackage : Package
dePackage =
    { title = "Klira"
    , score = "Deine Punkte"
    , reset = "Punkte setzen"
    , help = "Hilfe"
    , helpText =
        "Die Klira app kann Dich motivieren im Alltag etwas für "
            ++ "Nachhaltigkeit, Klimaschutz und Artenvielfalt zu tun."
            ++ "Immer wenn Du Dich für eine gute Tat entscheidest, "
            ++ "drückst Du den + button und gibst Dir einen Punk."
            ++ "\n"
            ++ "Du kannst selbst entscheiden für was und wie viele "
            ++ "Punkte Du Dir geben magst."
            ++ "\n"
            ++ "Zum Beispiel vegetarisches Essen, öffentliche Verkehrsmittel,"
            ++ "Verpackungen vermeiden, ..."
            ++ "\n"
            ++ "Diese App gibt es nur als Webseite in Deinem Browser. "
            ++ "Auch nur dort werden deine Punkte gespeichert. Falls Du "
            ++ "die App auf einem andren Gerät oder Browser mit Deinen "
            ++ "Punkten öffnen willst, dann schickte/kopiere die URL "
            ++ "aus dem Adressfeld Deines Browsers."
    , setScore = "Hier kannst Du Deine Punkte setzen"
    }


defaultPackage : Package
defaultPackage =
    dePackage


packages : Dict.Dict String Package
packages =
    Dict.fromList
        [ ( "de", dePackage )
        ]


package : String -> Package
package lang =
    case Dict.get lang packages of
        Just p ->
            p

        Nothing ->
            defaultPackage
