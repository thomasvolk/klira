module Text exposing (package)

import Dict


type alias Package =
    { title : String
    , score : String
    }


dePackage =
    { title = "Klira"
    , score = "Deine Punkte"
    }


defaultPackage =
    dePackage


packages =
    Dict.fromList
        [ ( "de", dePackage )
        ]


package lang =
    case Dict.get lang packages of
        Just p ->
            p

        Nothing ->
            defaultPackage
