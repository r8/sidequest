(import test :as t)
(import ../bottle-song :as sol)

(t/deftest "first generic verse"
  (t/assert-equal ["Ten green bottles hanging on the wall,"
                   "Ten green bottles hanging on the wall,"
                   "And if one green bottle should accidentally fall,"
                   "There'll be nine green bottles hanging on the wall."]
                  (sol/recite 10 1)))

(t/deftest "last generic verse"
  (t/assert-equal ["Three green bottles hanging on the wall,"
                   "Three green bottles hanging on the wall,"
                   "And if one green bottle should accidentally fall,"
                   "There'll be two green bottles hanging on the wall."]
                  (sol/recite 3 1)))

(t/deftest "verse with 2 bottles"
  (t/assert-equal ["Two green bottles hanging on the wall,"
                   "Two green bottles hanging on the wall,"
                   "And if one green bottle should accidentally fall,"
                   "There'll be one green bottle hanging on the wall."]
                  (sol/recite 2 1)))

(t/deftest "verse with 1 bottle"
  (t/assert-equal ["One green bottle hanging on the wall,"
                   "One green bottle hanging on the wall,"
                   "And if one green bottle should accidentally fall,"
                   "There'll be no green bottles hanging on the wall."]
                  (sol/recite 1 1)))

(t/deftest "first two verses"
  (t/assert-equal ["Ten green bottles hanging on the wall,"
                   "Ten green bottles hanging on the wall,"
                   "And if one green bottle should accidentally fall,"
                   "There'll be nine green bottles hanging on the wall."
                   ""
                   "Nine green bottles hanging on the wall,"
                   "Nine green bottles hanging on the wall,"
                   "And if one green bottle should accidentally fall,"
                   "There'll be eight green bottles hanging on the wall."]
                  (sol/recite 10 2)))

(t/deftest "last three verses"
  (t/assert-equal ["Three green bottles hanging on the wall,"
                   "Three green bottles hanging on the wall,"
                   "And if one green bottle should accidentally fall,"
                   "There'll be two green bottles hanging on the wall."
                   ""
                   "Two green bottles hanging on the wall,"
                   "Two green bottles hanging on the wall,"
                   "And if one green bottle should accidentally fall,"
                   "There'll be one green bottle hanging on the wall."
                   ""
                   "One green bottle hanging on the wall,"
                   "One green bottle hanging on the wall,"
                   "And if one green bottle should accidentally fall,"
                   "There'll be no green bottles hanging on the wall."]
                  (sol/recite 3 3)))

(t/deftest "all verses"
  (t/assert-equal ["Ten green bottles hanging on the wall,"
                   "Ten green bottles hanging on the wall,"
                   "And if one green bottle should accidentally fall,"
                   "There'll be nine green bottles hanging on the wall."
                   ""
                   "Nine green bottles hanging on the wall,"
                   "Nine green bottles hanging on the wall,"
                   "And if one green bottle should accidentally fall,"
                   "There'll be eight green bottles hanging on the wall."
                   ""
                   "Eight green bottles hanging on the wall,"
                   "Eight green bottles hanging on the wall,"
                   "And if one green bottle should accidentally fall,"
                   "There'll be seven green bottles hanging on the wall."
                   ""
                   "Seven green bottles hanging on the wall,"
                   "Seven green bottles hanging on the wall,"
                   "And if one green bottle should accidentally fall,"
                   "There'll be six green bottles hanging on the wall."
                   ""
                   "Six green bottles hanging on the wall,"
                   "Six green bottles hanging on the wall,"
                   "And if one green bottle should accidentally fall,"
                   "There'll be five green bottles hanging on the wall."
                   ""
                   "Five green bottles hanging on the wall,"
                   "Five green bottles hanging on the wall,"
                   "And if one green bottle should accidentally fall,"
                   "There'll be four green bottles hanging on the wall."
                   ""
                   "Four green bottles hanging on the wall,"
                   "Four green bottles hanging on the wall,"
                   "And if one green bottle should accidentally fall,"
                   "There'll be three green bottles hanging on the wall."
                   ""
                   "Three green bottles hanging on the wall,"
                   "Three green bottles hanging on the wall,"
                   "And if one green bottle should accidentally fall,"
                   "There'll be two green bottles hanging on the wall."
                   ""
                   "Two green bottles hanging on the wall,"
                   "Two green bottles hanging on the wall,"
                   "And if one green bottle should accidentally fall,"
                   "There'll be one green bottle hanging on the wall."
                   ""
                   "One green bottle hanging on the wall,"
                   "One green bottle hanging on the wall,"
                   "And if one green bottle should accidentally fall,"
                   "There'll be no green bottles hanging on the wall."]
                  (sol/recite 10 10)))

(t/run)
