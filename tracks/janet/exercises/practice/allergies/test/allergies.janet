(import test :as t)
(import ../allergies :as sol)

(t/deftest "not allergic to anything"
  (t/assert-false (sol/allergic-to? :eggs 0)))

(t/deftest "allergic only to eggs"
  (t/assert-true (sol/allergic-to? :eggs 1)))

(t/deftest "allergic to eggs and something else"
  (t/assert-true (sol/allergic-to? :eggs 3)))

(t/deftest "allergic to something, but not eggs"
  (t/assert-false (sol/allergic-to? :eggs 2)))

(t/deftest "allergic to everything"
  (t/assert-true (sol/allergic-to? :eggs 255)))

(t/deftest "testing for peanuts allergy > not allergic to anything"
  (t/assert-false (sol/allergic-to? :peanuts 0)))

(t/deftest "allergic only to peanuts"
  (t/assert-true (sol/allergic-to? :peanuts 2)))

(t/deftest "allergic to peanuts and something else"
  (t/assert-true (sol/allergic-to? :peanuts 7)))

(t/deftest "allergic to something, but not peanuts"
  (t/assert-false (sol/allergic-to? :peanuts 5)))

(t/deftest "testing for peanuts allergy > allergic to everything"
  (t/assert-true (sol/allergic-to? :peanuts 255)))

(t/deftest "testing for shellfish allergy > not allergic to anything"
  (t/assert-false (sol/allergic-to? :shellfish 0)))

(t/deftest "allergic only to shellfish"
  (t/assert-true (sol/allergic-to? :shellfish 4)))

(t/deftest "allergic to shellfish and something else"
  (t/assert-true (sol/allergic-to? :shellfish 14)))

(t/deftest "allergic to something, but not shellfish"
  (t/assert-false (sol/allergic-to? :shellfish 10)))

(t/deftest "testing for shellfish allergy > allergic to everything"
  (t/assert-true (sol/allergic-to? :shellfish 255)))

(t/deftest "testing for strawberries allergy > not allergic to anything"
  (t/assert-false (sol/allergic-to? :strawberries 0)))

(t/deftest "allergic only to strawberries"
  (t/assert-true (sol/allergic-to? :strawberries 8)))

(t/deftest "allergic to strawberries and something else"
  (t/assert-true (sol/allergic-to? :strawberries 28)))

(t/deftest "allergic to something, but not strawberries"
  (t/assert-false (sol/allergic-to? :strawberries 20)))

(t/deftest "testing for strawberries allergy > allergic to everything"
  (t/assert-true (sol/allergic-to? :strawberries 255)))

(t/deftest "testing for tomatoes allergy > not allergic to anything"
  (t/assert-false (sol/allergic-to? :tomatoes 0)))

(t/deftest "allergic only to tomatoes"
  (t/assert-true (sol/allergic-to? :tomatoes 16)))

(t/deftest "allergic to tomatoes and something else"
  (t/assert-true (sol/allergic-to? :tomatoes 56)))

(t/deftest "allergic to something, but not tomatoes"
  (t/assert-false (sol/allergic-to? :tomatoes 40)))

(t/deftest "testing for tomatoes allergy > allergic to everything"
  (t/assert-true (sol/allergic-to? :tomatoes 255)))

(t/deftest "testing for chocolate allergy > not allergic to anything"
  (t/assert-false (sol/allergic-to? :chocolate 0)))

(t/deftest "allergic only to chocolate"
  (t/assert-true (sol/allergic-to? :chocolate 32)))

(t/deftest "allergic to chocolate and something else"
  (t/assert-true (sol/allergic-to? :chocolate 112)))

(t/deftest "allergic to something, but not chocolate"
  (t/assert-false (sol/allergic-to? :chocolate 80)))

(t/deftest "testing for chocolate allergy > allergic to everything"
  (t/assert-true (sol/allergic-to? :chocolate 255)))

(t/deftest "testing for pollen allergy > not allergic to anything"
  (t/assert-false (sol/allergic-to? :pollen 0)))

(t/deftest "allergic only to pollen"
  (t/assert-true (sol/allergic-to? :pollen 64)))

(t/deftest "allergic to pollen and something else"
  (t/assert-true (sol/allergic-to? :pollen 224)))

(t/deftest "allergic to something, but not pollen"
  (t/assert-false (sol/allergic-to? :pollen 160)))

(t/deftest "testing for pollen allergy > allergic to everything"
  (t/assert-true (sol/allergic-to? :pollen 255)))

(t/deftest "testing for cats allergy > not allergic to anything"
  (t/assert-false (sol/allergic-to? :cats 0)))

(t/deftest "allergic only to cats"
  (t/assert-true (sol/allergic-to? :cats 128)))

(t/deftest "allergic to cats and something else"
  (t/assert-true (sol/allergic-to? :cats 192)))

(t/deftest "allergic to something, but not cats"
  (t/assert-false (sol/allergic-to? :cats 64)))

(t/deftest "testing for cats allergy > allergic to everything"
  (t/assert-true (sol/allergic-to? :cats 255)))

(t/deftest "no allergies"
  (t/assert-equal [] (sol/list 0)))

(t/deftest "just eggs"
  (t/assert-equal [:eggs] (sol/list 1)))

(t/deftest "just peanuts"
  (t/assert-equal [:peanuts] (sol/list 2)))

(t/deftest "just strawberries"
  (t/assert-equal [:strawberries] (sol/list 8)))

(t/deftest "eggs and peanuts"
  (t/assert-equal [:eggs :peanuts] (sol/list 3)))

(t/deftest "more than eggs but not peanuts"
  (t/assert-equal [:eggs :shellfish] (sol/list 5)))

(t/deftest "lots of stuff"
  (t/assert-equal [:strawberries :tomatoes :chocolate :pollen :cats] (sol/list 248)))

(t/deftest "everything"
  (t/assert-equal [:eggs :peanuts :shellfish :strawberries :tomatoes :chocolate :pollen :cats] (sol/list 255)))

(t/deftest "no allergen score parts"
  (t/assert-equal [:eggs :shellfish :strawberries :tomatoes :chocolate :pollen :cats] (sol/list 509)))

(t/deftest "no allergen score parts without highest valid score"
  (t/assert-equal [:eggs] (sol/list 257)))

(t/run)
