require ../lib/test.fs
require ../secret-handshake.fs

test" wink for 1"  1 commands s" wink" assert-str= ;test
test" double blink for 10"  2 commands s" double blink" assert-str= ;test
test" close your eyes for 100"  4 commands s" close your eyes" assert-str= ;test
test" jump for 1000"  8 commands s" jump" assert-str= ;test
test" combine two actions"  3 commands s" wink, double blink" assert-str= ;test
test" reverse two actions"  19 commands s" double blink, wink" assert-str= ;test
test" reversing one action gives the same action"  24 commands s" jump" assert-str= ;test
test" reversing no actions still gives no actions"  16 commands s" " assert-str= ;test
test" all possible actions"  15 commands s" wink, double blink, close your eyes, jump" assert-str= ;test
test" reverse all possible actions"  31 commands s" jump, close your eyes, double blink, wink" assert-str= ;test
test" do nothing for zero"  0 commands s" " assert-str= ;test

end-tests
