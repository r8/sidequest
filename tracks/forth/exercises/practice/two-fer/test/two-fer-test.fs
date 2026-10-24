require ../lib/test.fs
require ../two-fer.fs

test" no name given"  0 0 two-fer s" One for you, one for me." assert-str= ;test
test" a name given"  s" Alice" two-fer s" One for Alice, one for me." assert-str= ;test
test" another name given"  s" Bob" two-fer s" One for Bob, one for me." assert-str= ;test

\ Not in the canonical data: a name longer than any fixed-size buffer (or counted string) a
\ solution might reach for.
create long-name 300 chars allot  long-name 300 char x fill
create long-sentence 321 chars allot  long-sentence 321 char x fill
s" One for " long-sentence swap chars move  s" , one for me." long-sentence 308 chars + swap chars move
test" a long name given"  long-name 300 two-fer long-sentence 321 assert-str= ;test

end-tests
