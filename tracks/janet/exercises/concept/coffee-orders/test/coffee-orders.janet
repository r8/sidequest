(import test :as t)
(import ../coffee-orders :as sol)

(t/deftest "1. a small drink"
  (t/assert-equal 3 (sol/price :small)))

(t/deftest "1. a medium drink"
  (t/assert-equal 4 (sol/price :medium)))

(t/deftest "1. a large drink"
  (t/assert-equal 5 (sol/price :large)))

(t/deftest "1. a drink without a size is medium"
  (t/assert-equal 4 (sol/price)))

(t/deftest "2. no extras"
  (t/assert-equal 5 (sol/price-with-extras :large)))

(t/deftest "2. one extra"
  (t/assert-equal 4.5 (sol/price-with-extras :medium "caramel")))

(t/deftest "2. two extras"
  (t/assert-equal 4 (sol/price-with-extras :small "vanilla" "cinnamon")))

(t/deftest "2. the same extra twice counts twice"
  (t/assert-equal 6 (sol/price-with-extras :medium "shot" "shot" "shot" "shot")))

(t/deftest "3. a slip with a size and milk"
  (t/assert-equal "large oat latte" (sol/describe-order "latte" :milk "oat" :size :large)))

(t/deftest "3. a slip without size or milk"
  (t/assert-equal "medium mocha" (sol/describe-order "mocha")))

(t/deftest "3. a slip with only a size"
  (t/assert-equal "small espresso" (sol/describe-order "espresso" :size :small)))

(t/deftest "3. a slip with only milk"
  (t/assert-equal "medium soy flat white" (sol/describe-order "flat white" :milk "soy")))

(t/deftest "4. no promotion"
  (t/assert-equal 8 (sol/charge 8)))

(t/deftest "4. a promotion that takes one off"
  (t/assert-equal 7 (sol/charge 8 (fn [amount] (- amount 1)))))

(t/deftest "4. a half-price promotion"
  (t/assert-equal 2.5 (sol/charge 5 (fn [amount] (/ amount 2)))))

(t/deftest "4. a promotion that makes everything free"
  (t/assert-equal 0 (sol/charge 12 (fn [amount] 0))))

(t/run)
