module Text exposing (package)

import Dict


type alias Package =
    { title : String
    , score : String
    }


dePackage : Package
dePackage =
    { title = "Klira"
    , score = "Deine Punkte"
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
