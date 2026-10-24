require ../lib/test.fs
require ../diamond.fs

\ Lays a string down in data space, so a long expected text can be written one line per row:
\   create verse  s\" line one\n" text,  s" line two" text,  here verse - constant verse#
: text, ( c-addr u -- ) here swap dup chars allot move ;

test" Degenerate case with a single 'A' row"  [char] A diamond s" A" assert-str= ;test

create diamond-b
  s\"  A \n" text,
  s\" B B\n" text,
  s"  A " text,
here diamond-b - constant diamond-b#
test" Degenerate case with no row containing 3 distinct groups of spaces"  [char] B diamond diamond-b diamond-b# assert-str= ;test

create diamond-c
  s\"   A  \n" text,
  s\"  B B \n" text,
  s\" C   C\n" text,
  s\"  B B \n" text,
  s"   A  " text,
here diamond-c - constant diamond-c#
test" Smallest non-degenerate case with odd diamond side length"  [char] C diamond diamond-c diamond-c# assert-str= ;test

create diamond-d
  s\"    A   \n" text,
  s\"   B B  \n" text,
  s\"  C   C \n" text,
  s\" D     D\n" text,
  s\"  C   C \n" text,
  s\"   B B  \n" text,
  s"    A   " text,
here diamond-d - constant diamond-d#
test" Smallest non-degenerate case with even diamond side length"  [char] D diamond diamond-d diamond-d# assert-str= ;test

create diamond-z
  s\"                          A                         \n" text,
  s\"                         B B                        \n" text,
  s\"                        C   C                       \n" text,
  s\"                       D     D                      \n" text,
  s\"                      E       E                     \n" text,
  s\"                     F         F                    \n" text,
  s\"                    G           G                   \n" text,
  s\"                   H             H                  \n" text,
  s\"                  I               I                 \n" text,
  s\"                 J                 J                \n" text,
  s\"                K                   K               \n" text,
  s\"               L                     L              \n" text,
  s\"              M                       M             \n" text,
  s\"             N                         N            \n" text,
  s\"            O                           O           \n" text,
  s\"           P                             P          \n" text,
  s\"          Q                               Q         \n" text,
  s\"         R                                 R        \n" text,
  s\"        S                                   S       \n" text,
  s\"       T                                     T      \n" text,
  s\"      U                                       U     \n" text,
  s\"     V                                         V    \n" text,
  s\"    W                                           W   \n" text,
  s\"   X                                             X  \n" text,
  s\"  Y                                               Y \n" text,
  s\" Z                                                 Z\n" text,
  s\"  Y                                               Y \n" text,
  s\"   X                                             X  \n" text,
  s\"    W                                           W   \n" text,
  s\"     V                                         V    \n" text,
  s\"      U                                       U     \n" text,
  s\"       T                                     T      \n" text,
  s\"        S                                   S       \n" text,
  s\"         R                                 R        \n" text,
  s\"          Q                               Q         \n" text,
  s\"           P                             P          \n" text,
  s\"            O                           O           \n" text,
  s\"             N                         N            \n" text,
  s\"              M                       M             \n" text,
  s\"               L                     L              \n" text,
  s\"                K                   K               \n" text,
  s\"                 J                 J                \n" text,
  s\"                  I               I                 \n" text,
  s\"                   H             H                  \n" text,
  s\"                    G           G                   \n" text,
  s\"                     F         F                    \n" text,
  s\"                      E       E                     \n" text,
  s\"                       D     D                      \n" text,
  s\"                        C   C                       \n" text,
  s\"                         B B                        \n" text,
  s"                          A                         " text,
here diamond-z - constant diamond-z#
test" Largest possible diamond"  [char] Z diamond diamond-z diamond-z# assert-str= ;test

end-tests
