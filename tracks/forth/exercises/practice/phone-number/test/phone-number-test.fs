require ../lib/test.fs
require ../phone-number.fs

test" cleans the number"  s" (223) 456-7890" clean s" 2234567890" assert-str= ;test
test" cleans numbers with dots"  s" 223.456.7890" clean s" 2234567890" assert-str= ;test
test" cleans numbers with multiple spaces"
  s" 223 456   7890   " clean s" 2234567890" assert-str= ;test

: nine-digits ( -- c-addr u ) s" 123456789" clean ;
test" invalid when 9 digits"  ['] nine-digits -24 assert-xt-throws ;test

: eleven-digits-not-1 ( -- c-addr u ) s" 22234567890" clean ;
test" invalid when 11 digits does not start with a 1"
  ['] eleven-digits-not-1 -24 assert-xt-throws ;test

test" valid when 11 digits and starting with 1"
  s" 12234567890" clean s" 2234567890" assert-str= ;test
test" valid when 11 digits and starting with 1 even with punctuation"
  s" +1 (223) 456-7890" clean s" 2234567890" assert-str= ;test

: twelve-digits ( -- c-addr u ) s" 321234567890" clean ;
test" invalid when more than 11 digits"  ['] twelve-digits -24 assert-xt-throws ;test

: with-letters ( -- c-addr u ) s" 523-abc-7890" clean ;
test" invalid with letters"  ['] with-letters -24 assert-xt-throws ;test

: with-punctuations ( -- c-addr u ) s" 523-@:!-7890" clean ;
test" invalid with punctuations"  ['] with-punctuations -24 assert-xt-throws ;test

: area-code-0 ( -- c-addr u ) s" (023) 456-7890" clean ;
test" invalid if area code starts with 0"  ['] area-code-0 -24 assert-xt-throws ;test

: area-code-1 ( -- c-addr u ) s" (123) 456-7890" clean ;
test" invalid if area code starts with 1"  ['] area-code-1 -24 assert-xt-throws ;test

: exchange-code-0 ( -- c-addr u ) s" (223) 056-7890" clean ;
test" invalid if exchange code starts with 0"  ['] exchange-code-0 -24 assert-xt-throws ;test

: exchange-code-1 ( -- c-addr u ) s" (223) 156-7890" clean ;
test" invalid if exchange code starts with 1"  ['] exchange-code-1 -24 assert-xt-throws ;test

: area-code-0-11-digits ( -- c-addr u ) s" 1 (023) 456-7890" clean ;
test" invalid if area code starts with 0 on valid 11-digit number"
  ['] area-code-0-11-digits -24 assert-xt-throws ;test

: area-code-1-11-digits ( -- c-addr u ) s" 1 (123) 456-7890" clean ;
test" invalid if area code starts with 1 on valid 11-digit number"
  ['] area-code-1-11-digits -24 assert-xt-throws ;test

: exchange-code-0-11-digits ( -- c-addr u ) s" 1 (223) 056-7890" clean ;
test" invalid if exchange code starts with 0 on valid 11-digit number"
  ['] exchange-code-0-11-digits -24 assert-xt-throws ;test

: exchange-code-1-11-digits ( -- c-addr u ) s" 1 (223) 156-7890" clean ;
test" invalid if exchange code starts with 1 on valid 11-digit number"
  ['] exchange-code-1-11-digits -24 assert-xt-throws ;test

\ Not in the canonical data: more digits than any fixed-size buffer a solution might reach for.
create many-digits 1000 chars allot  many-digits 1000 char 5 fill
: many-digits-number ( -- c-addr u ) many-digits 1000 clean ;
test" invalid with far more than 11 digits"  ['] many-digits-number -24 assert-xt-throws ;test

end-tests
