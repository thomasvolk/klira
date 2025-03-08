module ThankYou exposing (ThankYou, numberGenerator)

import Random


type alias ThankYou =
    { kind : String
    , content : String
    }


count : number
count =
    6


generator : Random.Generator Int
generator =
    Random.int 1 count


numberGenerator : (Int -> msg) -> Cmd msg
numberGenerator m =
    Random.generate m generator
