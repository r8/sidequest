(import test :as t)
(import ../name-badges :as sol)

(t/deftest "1. the main line of a badge"
  (t/assert-equal "Ada Lovelace (ENGINEERING)" (sol/badge "Ada Lovelace" "engineering")))

(t/deftest "1. a department already in capitals"
  (t/assert-equal "Grace Hopper (NAVY)" (sol/badge "Grace Hopper" "NAVY")))

(t/deftest "1. a department of several words"
  (t/assert-equal "Mary Somerville (RARE BOOKS)" (sol/badge "Mary Somerville" "Rare Books")))

(t/deftest "2. initials of a short name"
  (t/assert-equal "G.H." (sol/initials "Grace Hopper")))

(t/deftest "2. initials of a longer name"
  (t/assert-equal "K.J." (sol/initials "Katherine Johnson")))

(t/deftest "2. initials of one-letter names"
  (t/assert-equal "X.Y." (sol/initials "X Y")))

(t/deftest "3. the surname"
  (t/assert-equal "Johnson" (sol/surname "Katherine Johnson")))

(t/deftest "3. a surname of several words"
  (t/assert-equal "van Gogh" (sol/surname "Vincent van Gogh")))

(t/deftest "3. a one-letter surname"
  (t/assert-equal "Y" (sol/surname "X Y")))

(t/deftest "4. a short name is padded"
  (t/assert-equal "| Ada Lovelace         |" (sol/name-tag "Ada Lovelace")))

(t/deftest "4. a name of exactly twenty characters"
  (t/assert-equal "| Maria Gaetana Agnesi |" (sol/name-tag "Maria Gaetana Agnesi")))

(t/deftest "4. a long name is cut off"
  (t/assert-equal "| Sofia Vasilyevna Kov |" (sol/name-tag "Sofia Vasilyevna Kovalevskaya")))

(t/deftest "5. a doctor"
  (t/assert-equal true (sol/doctor? "Dr. Mae Jemison")))

(t/deftest "5. not a doctor"
  (t/assert-equal false (sol/doctor? "Ada Lovelace")))

(t/deftest "5. a name that only contains the title is not a doctor"
  (t/assert-equal false (sol/doctor? "Ann Dr. Smith")))

(t/deftest "5. the title needs its full stop and space"
  (t/assert-equal false (sol/doctor? "Drew Barrymore")))

(t/run)
