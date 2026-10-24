\ A small test harness for the Forth track (gforth 0.7.3). It needs nothing beyond gforth.
\
\   require ../lib/test.fs
\   require ../leap.fs
\
\   test" year divisible by 400 is leap year"  2000 leap-year?  true assert= ;test
\
\   end-tests
\
\ test" <name>" starts an anonymous definition that ;test ends and runs under CATCH. Assertions take
\ the actual value first, then the expected one. end-tests prints the summary and exits.
\
\ Each test prints one machine-readable line, in definition order:
\
\   PASS<TAB><name><TAB><TAB>
\   FAIL<TAB><name><TAB><expected/got message><TAB>
\   ERROR<TAB><name><TAB><error message><TAB>
\   SUMMARY<TAB><passed><TAB><failed><TAB><errored>
\
\ Backslash, tab, newline and carriage return in a field are escaped as \\ \t \n \r. Whatever a test
\ prints appears on the lines before its record (records are surrounded by newlines, so blank lines
\ in between mean nothing). A test must leave the data and floating-point stacks as it found them.

variable #passed  variable #failed  variable #errored
create test-name 256 chars allot  variable test-name#
create msg 512 chars allot  variable msg#

-4242 constant fail-code

: msg-reset ( -- ) 0 msg# ! ;
: +msg ( c-addr u -- ) 512 msg# @ - min tuck msg msg# @ chars + swap move msg# +! ;
: n>s ( n -- c-addr u ) dup >r abs s>d <# #s r> sign #> ;
: u>s ( u -- c-addr u ) 0 <# #s #> ;
: float>s ( F: r -- ) ( -- c-addr u )
  20 6 0 f>str-rdp -trailing  begin dup if over c@ bl = else false then while 1 /string repeat ;
: fail ( -- ) fail-code throw ;

\ --- Assertions ---

: assert= ( actual expected -- )
  2dup <> if msg-reset s" expected " +msg n>s +msg s" , got " +msg n>s +msg fail then 2drop ;
: assert-u= ( actual expected -- )
  2dup <> if msg-reset s" expected " +msg u>s +msg s" , got " +msg u>s +msg fail then 2drop ;
: assert-true ( flag -- )
  0= if msg-reset s" expected true, got false" +msg fail then ;
: assert-false ( flag -- )
  if msg-reset s" expected false, got true" +msg fail then ;
: assert-str= ( c-addr1 u1 c-addr2 u2 -- )
  2over 2over compare if
    msg-reset s\" expected \"" +msg +msg s\" \", got \"" +msg +msg s\" \"" +msg fail
  then 2drop 2drop ;
: +cells ( addr n -- )
  s" [" +msg 0 ?do i if s"  " +msg then dup i cells + @ n>s +msg loop drop s" ]" +msg ;
\ Two arrays of n cells each, compared element by element:  primes 3 expected 3 assert-cells=
: assert-cells= ( addr1 n1 addr2 n2 -- )
  2over 2over 2>r 2>r  rot over = if  ( a1 a2 n )
    true swap 0 ?do  2 pick i cells + @  2 pick i cells + @ <> if 0= leave then  loop nip nip
  else drop 2drop false then
  2r> 2r> 4 roll if 2drop 2drop exit then
  msg-reset s" expected " +msg +cells s" , got " +msg +cells fail ;
\ Floats compare to within 0.01, as Exercism's canonical data rounds to two decimals. The test is
\ "within", not "not beyond": NaN compares false to everything, so it must fail rather than pass.
: assert-f~ ( F: actual expected -- )
  fover fover f- fabs 0.01e f<= 0= if
    msg-reset s" expected " +msg float>s +msg s" , got " +msg float>s +msg fail
  then fdrop fdrop ;
\ Passes when executing xt on the argument n throws `code`:  0 ['] square -24 assert-throws
: assert-throws ( n xt code -- )
  >r catch ?dup 0= if
    msg-reset s" expected throw " +msg r> n>s +msg s" , but nothing was thrown" +msg fail
  then
  nip dup r@ = if drop rdrop exit then
  msg-reset s" expected throw " +msg r> n>s +msg s" , got throw " +msg n>s +msg fail ;
\ The same for a word that takes no arguments, such as a helper the test file defines for a case
\ whose arguments are strings:  : too-long s" AATG" s" AAA" distance ;  ['] too-long -24 assert-xt-throws
: assert-xt-throws ( xt code -- ) 0 -rot assert-throws ;

\ --- Running ---

: error-text ( code -- )
  msg-reset
  case
    -1 of s" abort" +msg endof
    -2 of "error @ count +msg endof
    -3 of s" stack overflow" +msg endof
    -4 of s" stack underflow" +msg endof
    -9 of s" invalid memory address" +msg endof
    -10 of s" division by zero" +msg endof
    -11 of s" result out of range" +msg endof
    -13 of s" undefined word" +msg endof
    -24 of s" invalid numeric argument" +msg endof
    s" throw " +msg dup n>s +msg
  endcase ;

: escape-type ( c-addr u -- )
  bounds ?do
    i c@ case
      [char] \ of ." \\" endof
      9 of ." \t" endof
      10 of ." \n" endof
      13 of ." \r" endof
      dup emit
    endcase
  loop ;

: record ( c-addr u status-addr status-u -- )
  cr type 9 emit test-name test-name# @ escape-type 9 emit escape-type 9 emit cr ;

\ Each test runs on a cushion of zeros on both stacks, so a test that takes items it was not given
\ takes zeros. Without it gforth reads below the stack on macOS, reports a data stack underflow as a
\ throw on Linux, and on Linux faults past CATCH on a floating-point one, ending the whole file.
8 constant cushion
variable unbalanced

: run-test ( xt -- )
  >r cushion 0 ?do 0 loop cushion 0 ?do 0e loop r>
  fdepth >r depth 1- >r catch depth r> - 1- fdepth r> - ( code extra fextra )
  \ The file is read in decimal: a test that changed BASE, even one that threw meanwhile, must not
  \ change how the rest of it reads, or the counts in the summary.
  decimal
  \ CATCH restores both depths on a throw, so only a body that returned (code 0) can change them.
  2dup or dup unbalanced ! if
    msg-reset
    over if s" the test left the stack changed by " +msg over n>s +msg s"  item(s)" +msg then
    dup if
      msg# @ if s" ; " +msg then
      s" the test left the floating-point stack changed by " +msg dup n>s +msg s"  item(s)" +msg
    then
  then
  \ Drop whatever the test left, and the cushion.
  cushion + 0 max 0 ?do fdrop loop
  swap >r cushion + 0 max 0 ?do drop loop r>
  unbalanced @ if drop 1 #errored +! msg msg# @ s" ERROR" record exit then
  ?dup 0= if 1 #passed +! 0 0 s" PASS" record exit then
  dup fail-code = if drop 1 #failed +! msg msg# @ s" FAIL" record exit then
  error-text 1 #errored +! msg msg# @ s" ERROR" record ;

: test" ( "name<quote>" -- xt colon-sys )
  [char] " parse 255 min dup test-name# ! test-name swap chars move :noname ;
: ;test ( xt colon-sys -- ) postpone ; run-test ; immediate

: end-tests ( -- )
  cr ." SUMMARY" 9 emit #passed @ 0 .r 9 emit #failed @ 0 .r 9 emit #errored @ 0 .r cr
  #failed @ #errored @ + if 1 else 0 then (bye) ;
