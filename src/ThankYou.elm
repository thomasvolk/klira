module ThankYou exposing (..)

import Random


type alias ThankYou =
    { kind : String
    , content : String
    }


count =
    3


generator =
    Random.int 1 count


numberGenerator m =
    Random.generate m generator
