require ../lib/test.fs
require ../allergies.fs

test" testing for eggs allergy > not allergic to anything"  s" eggs" 0 allergic-to? assert-false ;test
test" testing for eggs allergy > allergic only to eggs"  s" eggs" 1 allergic-to? assert-true ;test
test" testing for eggs allergy > allergic to eggs and something else"  s" eggs" 3 allergic-to? assert-true ;test
test" testing for eggs allergy > allergic to something, but not eggs"  s" eggs" 2 allergic-to? assert-false ;test
test" testing for eggs allergy > allergic to everything"  s" eggs" 255 allergic-to? assert-true ;test
test" testing for peanuts allergy > not allergic to anything"  s" peanuts" 0 allergic-to? assert-false ;test
test" testing for peanuts allergy > allergic only to peanuts"  s" peanuts" 2 allergic-to? assert-true ;test
test" testing for peanuts allergy > allergic to peanuts and something else"  s" peanuts" 7 allergic-to? assert-true ;test
test" testing for peanuts allergy > allergic to something, but not peanuts"  s" peanuts" 5 allergic-to? assert-false ;test
test" testing for peanuts allergy > allergic to everything"  s" peanuts" 255 allergic-to? assert-true ;test
test" testing for shellfish allergy > not allergic to anything"  s" shellfish" 0 allergic-to? assert-false ;test
test" testing for shellfish allergy > allergic only to shellfish"  s" shellfish" 4 allergic-to? assert-true ;test
test" testing for shellfish allergy > allergic to shellfish and something else"  s" shellfish" 14 allergic-to? assert-true ;test
test" testing for shellfish allergy > allergic to something, but not shellfish"  s" shellfish" 10 allergic-to? assert-false ;test
test" testing for shellfish allergy > allergic to everything"  s" shellfish" 255 allergic-to? assert-true ;test
test" testing for strawberries allergy > not allergic to anything"  s" strawberries" 0 allergic-to? assert-false ;test
test" testing for strawberries allergy > allergic only to strawberries"  s" strawberries" 8 allergic-to? assert-true ;test
test" testing for strawberries allergy > allergic to strawberries and something else"  s" strawberries" 28 allergic-to? assert-true ;test
test" testing for strawberries allergy > allergic to something, but not strawberries"  s" strawberries" 20 allergic-to? assert-false ;test
test" testing for strawberries allergy > allergic to everything"  s" strawberries" 255 allergic-to? assert-true ;test
test" testing for tomatoes allergy > not allergic to anything"  s" tomatoes" 0 allergic-to? assert-false ;test
test" testing for tomatoes allergy > allergic only to tomatoes"  s" tomatoes" 16 allergic-to? assert-true ;test
test" testing for tomatoes allergy > allergic to tomatoes and something else"  s" tomatoes" 56 allergic-to? assert-true ;test
test" testing for tomatoes allergy > allergic to something, but not tomatoes"  s" tomatoes" 40 allergic-to? assert-false ;test
test" testing for tomatoes allergy > allergic to everything"  s" tomatoes" 255 allergic-to? assert-true ;test
test" testing for chocolate allergy > not allergic to anything"  s" chocolate" 0 allergic-to? assert-false ;test
test" testing for chocolate allergy > allergic only to chocolate"  s" chocolate" 32 allergic-to? assert-true ;test
test" testing for chocolate allergy > allergic to chocolate and something else"  s" chocolate" 112 allergic-to? assert-true ;test
test" testing for chocolate allergy > allergic to something, but not chocolate"  s" chocolate" 80 allergic-to? assert-false ;test
test" testing for chocolate allergy > allergic to everything"  s" chocolate" 255 allergic-to? assert-true ;test
test" testing for pollen allergy > not allergic to anything"  s" pollen" 0 allergic-to? assert-false ;test
test" testing for pollen allergy > allergic only to pollen"  s" pollen" 64 allergic-to? assert-true ;test
test" testing for pollen allergy > allergic to pollen and something else"  s" pollen" 224 allergic-to? assert-true ;test
test" testing for pollen allergy > allergic to something, but not pollen"  s" pollen" 160 allergic-to? assert-false ;test
test" testing for pollen allergy > allergic to everything"  s" pollen" 255 allergic-to? assert-true ;test
test" testing for cats allergy > not allergic to anything"  s" cats" 0 allergic-to? assert-false ;test
test" testing for cats allergy > allergic only to cats"  s" cats" 128 allergic-to? assert-true ;test
test" testing for cats allergy > allergic to cats and something else"  s" cats" 192 allergic-to? assert-true ;test
test" testing for cats allergy > allergic to something, but not cats"  s" cats" 64 allergic-to? assert-false ;test
test" testing for cats allergy > allergic to everything"  s" cats" 255 allergic-to? assert-true ;test
test" list when: > no allergies"  0 allergies s" " assert-str= ;test
test" list when: > just eggs"  1 allergies s" eggs" assert-str= ;test
test" list when: > just peanuts"  2 allergies s" peanuts" assert-str= ;test
test" list when: > just strawberries"  8 allergies s" strawberries" assert-str= ;test
test" list when: > eggs and peanuts"  3 allergies s" eggs peanuts" assert-str= ;test
test" list when: > more than eggs but not peanuts"  5 allergies s" eggs shellfish" assert-str= ;test
test" list when: > lots of stuff"  248 allergies s" strawberries tomatoes chocolate pollen cats" assert-str= ;test
test" list when: > everything"  255 allergies s" eggs peanuts shellfish strawberries tomatoes chocolate pollen cats" assert-str= ;test
test" list when: > no allergen score parts"  509 allergies s" eggs shellfish strawberries tomatoes chocolate pollen cats" assert-str= ;test
test" list when: > no allergen score parts without highest valid score"  257 allergies s" eggs" assert-str= ;test

end-tests
