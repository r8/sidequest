(import test :as t)
(import ../alphametics :as sol)

(t/deftest "puzzle with three letters"
  (t/assert-equal {"I" 1 "B" 9 "L" 0} (sol/solve "I + BB == ILL")))

(t/deftest "solution must have unique value for each letter"
  (t/assert-equal nil (sol/solve "A == B")))

(t/deftest "leading zero solution is invalid"
  (t/assert-equal nil (sol/solve "ACA + DD == BD")))

(t/deftest "puzzle with two digits final carry"
  (t/assert-equal {"A" 9 "B" 1 "C" 0} (sol/solve "A + A + A + A + A + A + A + A + A + A + A + B == BCC")))

(t/deftest "puzzle with four letters"
  (t/assert-equal {"A" 9 "S" 2 "M" 1 "O" 0} (sol/solve "AS + A == MOM")))

(t/deftest "puzzle with six letters"
  (t/assert-equal {"N" 7 "O" 4 "T" 9 "L" 1 "A" 0 "E" 2} (sol/solve "NO + NO + TOO == LATE")))

(t/deftest "puzzle with seven letters"
  (t/assert-equal {"E" 4 "G" 2 "H" 5 "I" 0 "L" 1 "S" 9 "T" 7} (sol/solve "HE + SEES + THE == LIGHT")))

(t/deftest "puzzle with eight letters"
  (t/assert-equal {"S" 9 "E" 5 "N" 6 "D" 7 "M" 1 "O" 0 "R" 8 "Y" 2} (sol/solve "SEND + MORE == MONEY")))

(t/deftest "puzzle with ten letters"
  (t/assert-equal {"A" 5 "D" 3 "E" 4 "F" 7 "G" 8 "N" 0 "O" 2 "R" 1 "S" 6 "T" 9} (sol/solve "AND + A + STRONG + OFFENSE + AS + A + GOOD == DEFENSE")))

(t/deftest "puzzle with ten letters and 199 addends"
  (t/assert-equal {"A" 1 "E" 0 "F" 5 "H" 8 "I" 7 "L" 2 "O" 6 "R" 3 "S" 4 "T" 9} (sol/solve "THIS + A + FIRE + THEREFORE + FOR + ALL + HISTORIES + I + TELL + A + TALE + THAT + FALSIFIES + ITS + TITLE + TIS + A + LIE + THE + TALE + OF + THE + LAST + FIRE + HORSES + LATE + AFTER + THE + FIRST + FATHERS + FORESEE + THE + HORRORS + THE + LAST + FREE + TROLL + TERRIFIES + THE + HORSES + OF + FIRE + THE + TROLL + RESTS + AT + THE + HOLE + OF + LOSSES + IT + IS + THERE + THAT + SHE + STORES + ROLES + OF + LEATHERS + AFTER + SHE + SATISFIES + HER + HATE + OFF + THOSE + FEARS + A + TASTE + RISES + AS + SHE + HEARS + THE + LEAST + FAR + HORSE + THOSE + FAST + HORSES + THAT + FIRST + HEAR + THE + TROLL + FLEE + OFF + TO + THE + FOREST + THE + HORSES + THAT + ALERTS + RAISE + THE + STARES + OF + THE + OTHERS + AS + THE + TROLL + ASSAILS + AT + THE + TOTAL + SHIFT + HER + TEETH + TEAR + HOOF + OFF + TORSO + AS + THE + LAST + HORSE + FORFEITS + ITS + LIFE + THE + FIRST + FATHERS + HEAR + OF + THE + HORRORS + THEIR + FEARS + THAT + THE + FIRES + FOR + THEIR + FEASTS + ARREST + AS + THE + FIRST + FATHERS + RESETTLE + THE + LAST + OF + THE + FIRE + HORSES + THE + LAST + TROLL + HARASSES + THE + FOREST + HEART + FREE + AT + LAST + OF + THE + LAST + TROLL + ALL + OFFER + THEIR + FIRE + HEAT + TO + THE + ASSISTERS + FAR + OFF + THE + TROLL + FASTS + ITS + LIFE + SHORTER + AS + STARS + RISE + THE + HORSES + REST + SAFE + AFTER + ALL + SHARE + HOT + FISH + AS + THEIR + AFFILIATES + TAILOR + A + ROOFS + FOR + THEIR + SAFE == FORTRESSES")))

(t/run)
