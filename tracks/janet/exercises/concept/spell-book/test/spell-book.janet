(import test :as t)
(import ../spell-book :as sol)

(t/deftest "1. a two-word spell name"
  (t/assert-equal 'frost-nova (sol/spell-name ["frost" "nova"])))

(t/deftest "1. a one-word spell name"
  (t/assert-equal 'fireball (sol/spell-name @["fireball"])))

(t/deftest "1. the name is a symbol"
  (t/assert-true (symbol? (sol/spell-name ["summon" "lesser" "toad"]))))

(t/deftest "2. a spell"
  (t/assert-true (sol/spell? '(fireball 3))))

(t/deftest "2. a spell without arguments"
  (t/assert-true (sol/spell? '(blink))))

(t/deftest "2. brackets are not a spell"
  (t/assert-false (sol/spell? '[fireball 3])))

(t/deftest "2. a spell's name must be a symbol"
  (t/assert-false (sol/spell? '(:fireball 3)))
  (t/assert-false (sol/spell? '("fireball" 3))))

(t/deftest "2. other values are not spells"
  (t/assert-false (sol/spell? 'fireball))
  (t/assert-false (sol/spell? @['fireball 3]))
  (t/assert-false (sol/spell? '())))

(t/deftest "3. writing a spell"
  (t/assert-true (deep= '(fireball 3) (sol/write-spell 'fireball 3))))

(t/deftest "3. a written spell is a spell"
  (t/assert-true (sol/spell? (sol/write-spell 'frost-nova 2))))

(t/deftest "3. the power is a value, not a name"
  (def power 9)
  (t/assert-equal 9 ((sol/write-spell 'blink power) 1)))

(t/deftest "4. chaining two spells"
  (t/assert-true (deep= '(do (fireball 3) (frost-nova 2)) (sol/chain ['(fireball 3) '(frost-nova 2)]))))

(t/deftest "4. chaining one spell"
  (t/assert-true (deep= '(do (blink)) (sol/chain @['(blink)]))))

(t/deftest "4. chaining no spells"
  (t/assert-true (deep= '(do) (sol/chain []))))

(t/deftest "4. the chain is a spell itself"
  (t/assert-true (sol/spell? (sol/chain ['(fireball 1)]))))

(t/deftest "5. a potion made by multiplying"
  (t/assert-equal 24 (sol/brew '* [2 3 4])))

(t/deftest "5. a potion made by adding"
  (t/assert-equal 10 (sol/brew '+ @[1 2 3 4])))

(t/deftest "5. a potion made by subtracting"
  (t/assert-equal 5 (sol/brew '- [20 10 5])))

(t/deftest "5. a potion of a single ingredient"
  (t/assert-equal 7 (sol/brew 'max [7])))

(t/run)
