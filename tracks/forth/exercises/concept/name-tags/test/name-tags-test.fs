require ../lib/test.fs
require ../name-tags.fs

test" 1. the initial of a full name"  s" Grace Hopper" initial [char] G assert= ;test
test" 1. the initial of a lower-case name"  s" bell hooks" initial [char] b assert= ;test
test" 1. the initial of a one-letter name"  s" Q" initial [char] Q assert= ;test

test" 2. a letter that appears several times"  s" Barbara Liskov" [char] a count-letter 3 assert= ;test
test" 2. a letter that does not appear"  s" Barbara Liskov" [char] z count-letter 0 assert= ;test
test" 2. case matters"  s" Barbara Liskov" [char] B count-letter 1 assert= ;test
test" 2. an empty name"  s" " [char] a count-letter 0 assert= ;test

test" 3. the same name"  s" Ada Lovelace" s" Ada Lovelace" same-name? assert-true ;test
test" 3. a different case"  s" Ada Lovelace" s" Ada lovelace" same-name? assert-false ;test
test" 3. one name a prefix of the other"  s" Ada" s" Ada Lovelace" same-name? assert-false ;test
test" 3. two empty names"  s" " s" " same-name? assert-true ;test

test" 4. spaces at both ends"  s"   Alan Turing " trim s" Alan Turing" assert-str= ;test
test" 4. no spaces to trim"  s" Alan Turing" trim s" Alan Turing" assert-str= ;test
test" 4. spaces only at the start"  s"  Hedy Lamarr" trim s" Hedy Lamarr" assert-str= ;test
test" 4. nothing but spaces"  s"    " trim nip 0 assert= ;test

test" 5. a first and a last name"  s" Edsger Dijkstra" first-name s" Edsger" assert-str= ;test
test" 5. three names"  s" John von Neumann" first-name s" John" assert-str= ;test
test" 5. a single name"  s" Plato" first-name s" Plato" assert-str= ;test
test" 5. the first name keeps its address"  s" Edsger Dijkstra" over >r first-name drop r> assert= ;test

test" 6. a first and a last name"  s" Edsger Dijkstra" surname s" Dijkstra" assert-str= ;test
test" 6. three names"  s" John von Neumann" surname s" von Neumann" assert-str= ;test
test" 6. a single name"  s" Plato" surname nip 0 assert= ;test
test" 6. a name ending in a space"  s" Cher " surname nip 0 assert= ;test

end-tests
