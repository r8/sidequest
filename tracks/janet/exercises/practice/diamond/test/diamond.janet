(import test :as t)
(import ../diamond :as sol)

(t/deftest "Degenerate case with a single 'A' row"
  (t/assert-equal ["A"] (sol/rows "A")))

(t/deftest "Degenerate case with no row containing 3 distinct groups of spaces"
  (t/assert-equal [" A " "B B" " A "] (sol/rows "B")))

(t/deftest "Smallest non-degenerate case with odd diamond side length"
  (t/assert-equal ["  A  " " B B " "C   C" " B B " "  A  "] (sol/rows "C")))

(t/deftest "Smallest non-degenerate case with even diamond side length"
  (t/assert-equal ["   A   " "  B B  " " C   C " "D     D" " C   C " "  B B  " "   A   "] (sol/rows "D")))

(t/deftest "Largest possible diamond"
  (t/assert-equal ["                         A                         " "                        B B                        " "                       C   C                       " "                      D     D                      " "                     E       E                     " "                    F         F                    " "                   G           G                   " "                  H             H                  " "                 I               I                 " "                J                 J                " "               K                   K               " "              L                     L              " "             M                       M             " "            N                         N            " "           O                           O           " "          P                             P          " "         Q                               Q         " "        R                                 R        " "       S                                   S       " "      T                                     T      " "     U                                       U     " "    V                                         V    " "   W                                           W   " "  X                                             X  " " Y                                               Y " "Z                                                 Z" " Y                                               Y " "  X                                             X  " "   W                                           W   " "    V                                         V    " "     U                                       U     " "      T                                     T      " "       S                                   S       " "        R                                 R        " "         Q                               Q         " "          P                             P          " "           O                           O           " "            N                         N            " "             M                       M             " "              L                     L              " "               K                   K               " "                J                 J                " "                 I               I                 " "                  H             H                  " "                   G           G                   " "                    F         F                    " "                     E       E                     " "                      D     D                      " "                       C   C                       " "                        B B                        " "                         A                         "] (sol/rows "Z")))

(t/run)
