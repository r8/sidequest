require ../lib/test.fs
require ../list-ops.fs

create no-items
create one-to-four 1 , 2 , 3 , 4 ,
test" append entries to a list and return the new list > empty lists"  no-items 0 no-items 0 append-lists no-items 0 assert-cells= ;test
test" append entries to a list and return the new list > list to empty list"  no-items 0 one-to-four 4 append-lists one-to-four 4 assert-cells= ;test
test" append entries to a list and return the new list > empty list to list"  one-to-four 4 no-items 0 append-lists one-to-four 4 assert-cells= ;test

create one-two 1 , 2 ,
create two-to-five 2 , 3 , 4 , 5 ,
create appended-expected 1 , 2 , 2 , 3 , 4 , 5 ,
test" append entries to a list and return the new list > non-empty lists"
  one-two 2 two-to-five 4 append-lists appended-expected 6 assert-cells= ;test

test" concatenate a list of lists > empty list"  no-items 0 concat no-items 0 assert-cells= ;test

\ Counted lists: the count, then the elements.
create list-12 2 , 1 , 2 ,
create list-3 1 , 3 ,
create list-empty 0 ,
create list-456 3 , 4 , 5 , 6 ,
create lists list-12 , list-3 , list-empty , list-456 ,
create one-to-six 1 , 2 , 3 , 4 , 5 , 6 ,
test" concatenate a list of lists > list of lists"  lists 4 concat one-to-six 6 assert-cells= ;test

\ [[[1],[2]],[[3]],[[]],[[4,5,6]]]: the inner lists are compared by address.
create list-1 1 , 1 ,
create list-2 1 , 2 ,
create list-1-2 2 , list-1 , list-2 ,
create list-of-3 1 , list-3 ,
create list-of-empty 1 , list-empty ,
create list-of-456 1 , list-456 ,
create nested-lists list-1-2 , list-of-3 , list-of-empty , list-of-456 ,
create nested-expected list-1 , list-2 , list-3 , list-empty , list-456 ,
test" concatenate a list of lists > list of nested lists"  nested-lists 4 concat nested-expected 5 assert-cells= ;test

: odd? ( n -- flag ) 1 and 0<> ;
test" filter list returning only values that satisfy the filter function > empty list"  no-items 0 ['] odd? filter no-items 0 assert-cells= ;test

create filter-input 1 , 2 , 3 , 5 ,
create filter-expected 1 , 3 , 5 ,
test" filter list returning only values that satisfy the filter function > non-empty list"
  filter-input 4 ['] odd? filter filter-expected 3 assert-cells= ;test

test" returns the length of a list > empty list"  no-items 0 length 0 assert= ;test
test" returns the length of a list > non-empty list"  one-to-four 4 length 4 assert= ;test

test" return a list of elements whose values equal the list value transformed by the mapping function > empty list"
  no-items 0 ['] 1+ map no-items 0 assert-cells= ;test

create odds-to-7 1 , 3 , 5 , 7 ,
create evens-to-8 2 , 4 , 6 , 8 ,
test" return a list of elements whose values equal the list value transformed by the mapping function > non-empty list"
  odds-to-7 4 ['] 1+ map evens-to-8 4 assert-cells= ;test

\ The original integer-division case: (x, y) -> x / y with x the accumulator.
create two-five 2 , 5 ,
test" folds (reduces) the given list from the left with a function > direction dependent function applied to non-empty list"
  two-five 2 5 ['] / foldl 0 assert= ;test
test" folds (reduces) the given list from the left with a function > empty list"  no-items 0 2 ['] * foldl 2 assert= ;test
test" folds (reduces) the given list from the left with a function > direction independent function applied to non-empty list"
  one-to-four 4 5 ['] + foldl 15 assert= ;test

\ The original integer-division case: (x, y) -> x / y with x the element.
: element/acc ( acc x -- x/acc ) swap / ;
test" folds (reduces) the given list from the right with a function > direction dependent function applied to non-empty list"
  two-five 2 5 ['] element/acc foldr 2 assert= ;test
test" folds (reduces) the given list from the right with a function > empty list"  no-items 0 2 ['] * foldr 2 assert= ;test
test" folds (reduces) the given list from the right with a function > direction independent function applied to non-empty list"
  one-to-four 4 5 ['] + foldr 15 assert= ;test
\ Not in the canonical data: a list of one element, where the first element is also the last.
create just-seven 7 ,
test" folds (reduces) the given list from the right with a function > list of one element"
  just-seven 1 10 ['] + foldr 17 assert= ;test

test" reverse the elements of the list > empty list"  no-items 0 reverse no-items 0 assert-cells= ;test

create reversed-odds 7 , 5 , 3 , 1 ,
test" reverse the elements of the list > non-empty even-length list"  odds-to-7 4 reverse reversed-odds 4 assert-cells= ;test

create odds-to-13 1 , 3 , 5 , 7 , 9 , 11 , 13 ,
create odds-from-13 13 , 11 , 9 , 7 , 5 , 3 , 1 ,
test" reverse the elements of the list > non-empty odd-length list"  odds-to-13 7 reverse odds-from-13 7 assert-cells= ;test

create lists-reversed list-456 , list-empty , list-3 , list-12 ,
test" reverse the elements of the list > list of lists is not flattened"  lists 4 reverse lists-reversed 4 assert-cells= ;test

end-tests
