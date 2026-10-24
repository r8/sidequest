(import test :as t)
(import ../weather-report :as sol)

(t/deftest "1. below zero is freezing"
  (t/assert-equal :freezing (sol/classify -5)))

(t/deftest "1. zero is cold"
  (t/assert-equal :cold (sol/classify 0)))

(t/deftest "1. fourteen degrees is mild"
  (t/assert-equal :mild (sol/classify 14)))

(t/deftest "1. twenty degrees is hot"
  (t/assert-equal :hot (sol/classify 20)))

(t/deftest "2. advice for a sunny day"
  (t/assert-equal "Bring sunglasses" (sol/advice :sunny)))

(t/deftest "2. advice for a rainy day"
  (t/assert-equal "Bring an umbrella" (sol/advice :rainy)))

(t/deftest "2. advice for a snowy day"
  (t/assert-equal "Wear boots" (sol/advice :snowy)))

(t/deftest "2. advice for a stormy day"
  (t/assert-equal "Stay in harbour" (sol/advice :stormy)))

(t/deftest "2. advice for a cloudy day"
  (t/assert-equal "Enjoy your day" (sol/advice :cloudy)))

(t/deftest "3. a word in lower case"
  (t/assert-equal :cloudy (sol/parse-sky "cloudy")))

(t/deftest "3. a capitalised word"
  (t/assert-equal :sunny (sol/parse-sky "Sunny")))

(t/deftest "3. a word in capitals with spaces around it"
  (t/assert-equal :stormy (sol/parse-sky "  STORMY ")))

(t/deftest "4. rain is wet"
  (t/assert-equal true (sol/wet? :rainy)))

(t/deftest "4. snow is wet"
  (t/assert-equal true (sol/wet? :snowy)))

(t/deftest "4. a storm is wet"
  (t/assert-equal true (sol/wet? :stormy)))

(t/deftest "4. sunshine is not wet"
  (t/assert-equal false (sol/wet? :sunny)))

(t/deftest "4. clouds are not wet"
  (t/assert-equal false (sol/wet? :cloudy)))

(t/deftest "5. a mild sunny day"
  (t/assert-equal "mild and sunny" (sol/report 14 :sunny)))

(t/deftest "5. a freezing snowy day"
  (t/assert-equal "freezing and snowy" (sol/report -3 :snowy)))

(t/deftest "5. a hot stormy day"
  (t/assert-equal "hot and stormy" (sol/report 31 :stormy)))

(t/run)
