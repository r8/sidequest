require ../lib/test.fs
require ../matching-brackets.fs

test" paired square brackets"  s" []" paired? assert-true ;test
test" empty string"  s" " paired? assert-true ;test
test" unpaired brackets"  s" [[" paired? assert-false ;test
test" wrong ordered brackets"  s" }{" paired? assert-false ;test
test" wrong closing bracket"  s" {]" paired? assert-false ;test
test" paired with whitespace"  s" { }" paired? assert-true ;test
test" partially paired brackets"  s" {[])" paired? assert-false ;test
test" simple nested brackets"  s" {[]}" paired? assert-true ;test
test" several paired brackets"  s" {}[]" paired? assert-true ;test
test" paired and nested brackets"  s" ([{}({}[])])" paired? assert-true ;test
test" unopened closing brackets"  s" {[)][]}" paired? assert-false ;test
test" unpaired and nested brackets"  s" ([{])" paired? assert-false ;test
test" paired and wrong nested brackets"  s" [({]})" paired? assert-false ;test
test" paired and wrong nested brackets but innermost are correct"  s" [({}])" paired? assert-false ;test
test" paired and incomplete brackets"  s" {}[" paired? assert-false ;test
test" too many closing brackets"  s" []]" paired? assert-false ;test
test" early unexpected brackets"  s" )()" paired? assert-false ;test
test" early mismatched brackets"  s" {)()" paired? assert-false ;test
test" math expression"  s" (((185 + 223.85) * 15) - 543)/2" paired? assert-true ;test
test" complex latex expression"
  s" \left(\begin{array}{cc} \frac{1}{3} & x\\ \mathrm{e}^{x} &... x^2 \end{array}\right)"
  paired? assert-true ;test

\ Not in the canonical data: nesting deeper than any fixed-size stack a solution might reach for.
create deep 2000 chars allot  deep 1000 char ( fill  deep 1000 chars + 1000 char ) fill
test" deeply nested brackets"  deep 2000 paired? assert-true ;test

end-tests
