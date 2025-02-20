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
