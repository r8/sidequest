t ← •Import "../lib/test.bqn"
g ← •Import "../diamond.bqn"

smallestNondegenerateCase ← ⟨
  "   A   "
  "  B B  "
  " C   C "
  "D     D"
  " C   C "
  "  B B  "
  "   A   "
⟩

largestPossibleDiamond ← ⟨
  "                         A                         "
  "                        B B                        "
  "                       C   C                       "
  "                      D     D                      "
  "                     E       E                     "
  "                    F         F                    "
  "                   G           G                   "
  "                  H             H                  "
  "                 I               I                 "
  "                J                 J                "
  "               K                   K               "
  "              L                     L              "
  "             M                       M             "
  "            N                         N            "
  "           O                           O           "
  "          P                             P          "
  "         Q                               Q         "
  "        R                                 R        "
  "       S                                   S       "
  "      T                                     T      "
  "     U                                       U     "
  "    V                                         V    "
  "   W                                           W   "
  "  X                                             X  "
  " Y                                               Y "
  "Z                                                 Z"
  " Y                                               Y "
  "  X                                             X  "
  "   W                                           W   "
  "    V                                         V    "
  "     U                                       U     "
  "      T                                     T      "
  "       S                                   S       "
  "        R                                 R        "
  "         Q                               Q         "
  "          P                             P          "
  "           O                           O           "
  "            N                         N            "
  "             M                       M             "
  "              L                     L              "
  "               K                   K               "
  "                J                 J                "
  "                 I               I                 "
  "                  H             H                  "
  "                   G           G                   "
  "                    F         F                    "
  "                     E       E                     "
  "                      D     D                      "
  "                       C   C                       "
  "                        B B                        "
  "                         A                         "
⟩

t.Run ⟨
  "Degenerate case with a single 'A' row"‿{𝕊: ⟨"A"⟩ t.Expect g.Rows 'A'}
  "Degenerate case with no row containing 3 distinct groups of spaces"‿{𝕊: ⟨" A ", "B B", " A "⟩ t.Expect g.Rows 'B'}
  "Smallest non-degenerate case with odd diamond side length"‿{𝕊: ⟨"  A  ", " B B ", "C   C", " B B ", "  A  "⟩ t.Expect g.Rows 'C'}
  "Smallest non-degenerate case with even diamond side length"‿{𝕊: smallestNondegenerateCase t.Expect g.Rows 'D'}
  "Largest possible diamond"‿{𝕊: largestPossibleDiamond t.Expect g.Rows 'Z'}
⟩
