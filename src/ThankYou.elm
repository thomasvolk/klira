module ThankYou exposing (ThankYou, Config, choose)

import Random


type alias ThankYou =
    { kind : String
    , content : String
    }

type alias Config =
  { count: Int
  }


generator : Int -> Random.Generator Int
generator count =
    Random.int 1 count


choose : Int -> (Int -> msg) -> Cmd msg
choose count m =
    Random.generate m (generator count)
