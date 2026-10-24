require ../lib/test.fs
require ../roman-numerals.fs

test" 1 is I"  1 roman s" I" assert-str= ;test
test" 2 is II"  2 roman s" II" assert-str= ;test
test" 3 is III"  3 roman s" III" assert-str= ;test
test" 4 is IV"  4 roman s" IV" assert-str= ;test
test" 5 is V"  5 roman s" V" assert-str= ;test
test" 6 is VI"  6 roman s" VI" assert-str= ;test
test" 9 is IX"  9 roman s" IX" assert-str= ;test
test" 16 is XVI"  16 roman s" XVI" assert-str= ;test
test" 27 is XXVII"  27 roman s" XXVII" assert-str= ;test
test" 48 is XLVIII"  48 roman s" XLVIII" assert-str= ;test
test" 49 is XLIX"  49 roman s" XLIX" assert-str= ;test
test" 59 is LIX"  59 roman s" LIX" assert-str= ;test
test" 66 is LXVI"  66 roman s" LXVI" assert-str= ;test
test" 93 is XCIII"  93 roman s" XCIII" assert-str= ;test
test" 141 is CXLI"  141 roman s" CXLI" assert-str= ;test
test" 163 is CLXIII"  163 roman s" CLXIII" assert-str= ;test
test" 166 is CLXVI"  166 roman s" CLXVI" assert-str= ;test
test" 402 is CDII"  402 roman s" CDII" assert-str= ;test
test" 575 is DLXXV"  575 roman s" DLXXV" assert-str= ;test
test" 666 is DCLXVI"  666 roman s" DCLXVI" assert-str= ;test
test" 911 is CMXI"  911 roman s" CMXI" assert-str= ;test
test" 1024 is MXXIV"  1024 roman s" MXXIV" assert-str= ;test
test" 1666 is MDCLXVI"  1666 roman s" MDCLXVI" assert-str= ;test
test" 3000 is MMM"  3000 roman s" MMM" assert-str= ;test
test" 3001 is MMMI"  3001 roman s" MMMI" assert-str= ;test
test" 3888 is MMMDCCCLXXXVIII"  3888 roman s" MMMDCCCLXXXVIII" assert-str= ;test
test" 3999 is MMMCMXCIX"  3999 roman s" MMMCMXCIX" assert-str= ;test

end-tests
