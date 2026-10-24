(def- ordinals ["first" "second" "third" "fourth" "fifth" "sixth"
                "seventh" "eighth" "ninth" "tenth" "eleventh" "twelfth"])

(def- gifts ["a Partridge in a Pear Tree" "two Turtle Doves" "three French Hens"
             "four Calling Birds" "five Gold Rings" "six Geese-a-Laying"
             "seven Swans-a-Swimming" "eight Maids-a-Milking" "nine Ladies Dancing"
             "ten Lords-a-Leaping" "eleven Pipers Piping" "twelve Drummers Drumming"])

(defn- verse [n]
  (def given (reverse (array/slice gifts 0 n)))
  (when (> n 1)
    (update given (- n 1) |(string "and " $)))
  (string "On the " (ordinals (- n 1)) " day of Christmas my true love gave to me: "
          (string/join given ", ") "."))

(defn recite
  "(recite start-verse end-verse) -> an array of verses start-verse through end-verse, one string per verse"
  [start-verse end-verse]
  (map verse (range start-verse (+ end-verse 1))))
