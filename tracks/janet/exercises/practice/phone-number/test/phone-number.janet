(import test :as t)
(import ../phone-number :as sol)

(t/deftest "cleans the number"
  (t/assert-equal "2234567890" (sol/clean "(223) 456-7890")))

(t/deftest "cleans numbers with dots"
  (t/assert-equal "2234567890" (sol/clean "223.456.7890")))

(t/deftest "cleans numbers with multiple spaces"
  (t/assert-equal "2234567890" (sol/clean "223 456   7890   ")))

(t/deftest "invalid when 9 digits"
  (t/assert-error "must not be fewer than 10 digits" (sol/clean "123456789")))

(t/deftest "invalid when 11 digits does not start with a 1"
  (t/assert-error "11 digits must start with 1" (sol/clean "22234567890")))

(t/deftest "valid when 11 digits and starting with 1"
  (t/assert-equal "2234567890" (sol/clean "12234567890")))

(t/deftest "valid when 11 digits and starting with 1 even with punctuation"
  (t/assert-equal "2234567890" (sol/clean "+1 (223) 456-7890")))

(t/deftest "invalid when more than 11 digits"
  (t/assert-error "must not be greater than 11 digits" (sol/clean "321234567890")))

(t/deftest "invalid with letters"
  (t/assert-error "letters not permitted" (sol/clean "523-abc-7890")))

(t/deftest "invalid with punctuations"
  (t/assert-error "punctuations not permitted" (sol/clean "523-@:!-7890")))

(t/deftest "invalid if area code starts with 0"
  (t/assert-error "area code cannot start with zero" (sol/clean "(023) 456-7890")))

(t/deftest "invalid if area code starts with 1"
  (t/assert-error "area code cannot start with one" (sol/clean "(123) 456-7890")))

(t/deftest "invalid if exchange code starts with 0"
  (t/assert-error "exchange code cannot start with zero" (sol/clean "(223) 056-7890")))

(t/deftest "invalid if exchange code starts with 1"
  (t/assert-error "exchange code cannot start with one" (sol/clean "(223) 156-7890")))

(t/deftest "invalid if area code starts with 0 on valid 11-digit number"
  (t/assert-error "area code cannot start with zero" (sol/clean "1 (023) 456-7890")))

(t/deftest "invalid if area code starts with 1 on valid 11-digit number"
  (t/assert-error "area code cannot start with one" (sol/clean "1 (123) 456-7890")))

(t/deftest "invalid if exchange code starts with 0 on valid 11-digit number"
  (t/assert-error "exchange code cannot start with zero" (sol/clean "1 (223) 056-7890")))

(t/deftest "invalid if exchange code starts with 1 on valid 11-digit number"
  (t/assert-error "exchange code cannot start with one" (sol/clean "1 (223) 156-7890")))

(t/run)
