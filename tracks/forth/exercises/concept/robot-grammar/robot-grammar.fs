\ Compiles code that squares the top of the stack: ( n -- n*n ) at run time.
: squared ( -- )
  true abort" implement me" ; immediate

\ Like if, but the code after it runs when the flag is false: ( flag -- ) at run time.
: unless ( -- )
  true abort" implement me" ; immediate

\ Reads the next word of the definition and compiles it twice.
: twice ( "name" -- )
  true abort" implement me" ; immediate

\ The number of steps compiled so far.
variable steps

\ Adds one to steps and compiles the new value as a literal: ( -- n ) at run time.
: step ( -- )
  true abort" implement me" ; immediate

\ Starts a loop that runs n times, i counting from 0: ( n -- ) at run time.
: times ( -- )
  true abort" implement me" ; immediate

\ Ends the loop that times starts.
: end-times ( -- )
  true abort" implement me" ; immediate
