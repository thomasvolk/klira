module ThankYou exposing (..)

import Random

count = 3

generator = Random.int 1 count

numberGenerator m = Random.generate m generator


