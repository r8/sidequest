\ Compiles code that squares the top of the stack: ( n -- n*n ) at run time.
: squared ( -- )
  postpone dup  postpone * ; immediate

\ Like if, but the code after it runs when the flag is false: ( flag -- ) at run time.
: unless ( -- )
  postpone 0=  postpone if ; immediate

\ Reads the next word of the definition and compiles it twice.
: twice ( "name" -- )
  ' dup compile, compile, ; immediate

\ The number of steps compiled so far.
variable steps

\ Adds one to steps and compiles the new value as a literal: ( -- n ) at run time.
: step ( -- )
  1 steps +!  steps @ postpone literal ; immediate

\ Starts a loop that runs n times, i counting from 0: ( n -- ) at run time.
: times ( -- )
  0 postpone literal  postpone ?do ; immediate

\ Ends the loop that times starts.
: end-times ( -- )
  postpone loop ; immediate
