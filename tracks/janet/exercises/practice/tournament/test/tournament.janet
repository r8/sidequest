(import test :as t)
(import ../tournament :as sol)

(t/deftest "just the header if no input"
  (t/assert-equal ["Team                           | MP |  W |  D |  L |  P"] (sol/tally [])))

(t/deftest "a win is three points, a loss is zero points"
  (t/assert-equal ["Team                           | MP |  W |  D |  L |  P"
                   "Allegoric Alaskans             |  1 |  1 |  0 |  0 |  3"
                   "Blithering Badgers             |  1 |  0 |  0 |  1 |  0"]
                  (sol/tally ["Allegoric Alaskans;Blithering Badgers;win"])))

(t/deftest "a win can also be expressed as a loss"
  (t/assert-equal ["Team                           | MP |  W |  D |  L |  P"
                   "Allegoric Alaskans             |  1 |  1 |  0 |  0 |  3"
                   "Blithering Badgers             |  1 |  0 |  0 |  1 |  0"]
                  (sol/tally ["Blithering Badgers;Allegoric Alaskans;loss"])))

(t/deftest "a different team can win"
  (t/assert-equal ["Team                           | MP |  W |  D |  L |  P"
                   "Blithering Badgers             |  1 |  1 |  0 |  0 |  3"
                   "Allegoric Alaskans             |  1 |  0 |  0 |  1 |  0"]
                  (sol/tally ["Blithering Badgers;Allegoric Alaskans;win"])))

(t/deftest "a draw is one point each"
  (t/assert-equal ["Team                           | MP |  W |  D |  L |  P"
                   "Allegoric Alaskans             |  1 |  0 |  1 |  0 |  1"
                   "Blithering Badgers             |  1 |  0 |  1 |  0 |  1"]
                  (sol/tally ["Allegoric Alaskans;Blithering Badgers;draw"])))

(t/deftest "There can be more than one match"
  (t/assert-equal ["Team                           | MP |  W |  D |  L |  P"
                   "Allegoric Alaskans             |  2 |  2 |  0 |  0 |  6"
                   "Blithering Badgers             |  2 |  0 |  0 |  2 |  0"]
                  (sol/tally ["Allegoric Alaskans;Blithering Badgers;win"
                              "Allegoric Alaskans;Blithering Badgers;win"])))

(t/deftest "There can be more than one winner"
  (t/assert-equal ["Team                           | MP |  W |  D |  L |  P"
                   "Allegoric Alaskans             |  2 |  1 |  0 |  1 |  3"
                   "Blithering Badgers             |  2 |  1 |  0 |  1 |  3"]
                  (sol/tally ["Allegoric Alaskans;Blithering Badgers;loss"
                              "Allegoric Alaskans;Blithering Badgers;win"])))

(t/deftest "There can be more than two teams"
  (t/assert-equal ["Team                           | MP |  W |  D |  L |  P"
                   "Allegoric Alaskans             |  2 |  2 |  0 |  0 |  6"
                   "Blithering Badgers             |  2 |  1 |  0 |  1 |  3"
                   "Courageous Californians        |  2 |  0 |  0 |  2 |  0"]
                  (sol/tally ["Allegoric Alaskans;Blithering Badgers;win"
                              "Blithering Badgers;Courageous Californians;win"
                              "Courageous Californians;Allegoric Alaskans;loss"])))

(t/deftest "typical input"
  (t/assert-equal ["Team                           | MP |  W |  D |  L |  P"
                   "Devastating Donkeys            |  3 |  2 |  1 |  0 |  7"
                   "Allegoric Alaskans             |  3 |  2 |  0 |  1 |  6"
                   "Blithering Badgers             |  3 |  1 |  0 |  2 |  3"
                   "Courageous Californians        |  3 |  0 |  1 |  2 |  1"]
                  (sol/tally ["Allegoric Alaskans;Blithering Badgers;win"
                              "Devastating Donkeys;Courageous Californians;draw"
                              "Devastating Donkeys;Allegoric Alaskans;win"
                              "Courageous Californians;Blithering Badgers;loss"
                              "Blithering Badgers;Devastating Donkeys;loss"
                              "Allegoric Alaskans;Courageous Californians;win"])))

(t/deftest "incomplete competition (not all pairs have played)"
  (t/assert-equal ["Team                           | MP |  W |  D |  L |  P"
                   "Allegoric Alaskans             |  3 |  2 |  0 |  1 |  6"
                   "Blithering Badgers             |  2 |  1 |  1 |  0 |  4"
                   "Courageous Californians        |  2 |  0 |  1 |  1 |  1"
                   "Devastating Donkeys            |  1 |  0 |  0 |  1 |  0"]
                  (sol/tally ["Allegoric Alaskans;Blithering Badgers;loss"
                              "Devastating Donkeys;Allegoric Alaskans;loss"
                              "Courageous Californians;Blithering Badgers;draw"
                              "Allegoric Alaskans;Courageous Californians;win"])))

(t/deftest "ties broken alphabetically"
  (t/assert-equal ["Team                           | MP |  W |  D |  L |  P"
                   "Allegoric Alaskans             |  3 |  2 |  1 |  0 |  7"
                   "Courageous Californians        |  3 |  2 |  1 |  0 |  7"
                   "Blithering Badgers             |  3 |  0 |  1 |  2 |  1"
                   "Devastating Donkeys            |  3 |  0 |  1 |  2 |  1"]
                  (sol/tally ["Courageous Californians;Devastating Donkeys;win"
                              "Allegoric Alaskans;Blithering Badgers;win"
                              "Devastating Donkeys;Allegoric Alaskans;loss"
                              "Courageous Californians;Blithering Badgers;win"
                              "Blithering Badgers;Devastating Donkeys;draw"
                              "Allegoric Alaskans;Courageous Californians;draw"])))

(t/deftest "ensure points sorted numerically"
  (t/assert-equal ["Team                           | MP |  W |  D |  L |  P"
                   "Devastating Donkeys            |  5 |  4 |  0 |  1 | 12"
                   "Blithering Badgers             |  5 |  1 |  0 |  4 |  3"]
                  (sol/tally ["Devastating Donkeys;Blithering Badgers;win"
                              "Devastating Donkeys;Blithering Badgers;win"
                              "Devastating Donkeys;Blithering Badgers;win"
                              "Devastating Donkeys;Blithering Badgers;win"
                              "Blithering Badgers;Devastating Donkeys;win"])))

(t/run)
