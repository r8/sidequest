require ../lib/test.fs
require ../receipt-printer.fs

test" 1. dollars and cents"  1250 price s" 12.50" assert-str= ;test
test" 1. cents only"  5 price s" 0.05" assert-str= ;test
test" 1. nothing at all"  0 price s" 0.00" assert-str= ;test
test" 1. a large price"  123456 price s" 1234.56" assert-str= ;test

test" 2. a refund"  -305 amount s" -3.05" assert-str= ;test
test" 2. a sale"  999 amount s" 9.99" assert-str= ;test
test" 2. a refund of a few cents"  -7 amount s" -0.07" assert-str= ;test
test" 2. zero"  0 amount s" 0.00" assert-str= ;test

test" 3. a small ticket number"  42 ticket-number s" 000042" assert-str= ;test
test" 3. the first ticket"  0 ticket-number s" 000000" assert-str= ;test
test" 3. the largest ticket number"  999999 ticket-number s" 999999" assert-str= ;test

test" 4. a code with letters"  48879 hex-code s" BEEF" assert-str= ;test
test" 4. a code with digits only"  4660 hex-code s" 1234" assert-str= ;test
test" 4. zero"  0 hex-code s" 0" assert-str= ;test
test" 4. the base is unchanged"  255 hex-code 2drop  base @ 10 assert= ;test
\ Runs hex-code with the base set to 8 and leaves the base it ended with. The base is decimal
\ again afterwards, even when hex-code throws, so the rest of the file is read in decimal.
: base-after-octal ( -- base )
  8 base !  255 ['] hex-code catch  base @ swap  decimal  throw  nip nip ;
test" 4. the base is unchanged when it was not decimal"  base-after-octal 8 assert= ;test

test" 5. a small code"  5 binary-byte s" 00000101" assert-str= ;test
test" 5. every switch on"  255 binary-byte s" 11111111" assert-str= ;test
test" 5. every switch off"  0 binary-byte s" 00000000" assert-str= ;test
test" 5. the base is unchanged"  170 binary-byte s" 10101010" assert-str=  base @ 10 assert= ;test

end-tests
