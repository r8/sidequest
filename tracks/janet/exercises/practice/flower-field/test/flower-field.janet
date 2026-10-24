(import test :as t)
(import ../flower-field :as sol)

(t/deftest "no rows"
  (t/assert-equal [] (sol/annotate [])))

(t/deftest "no columns"
  (t/assert-equal [""] (sol/annotate [""])))

(t/deftest "no flowers"
  (t/assert-equal ["   " "   " "   "] (sol/annotate ["   " "   " "   "])))

(t/deftest "garden full of flowers"
  (t/assert-equal ["***" "***" "***"] (sol/annotate ["***" "***" "***"])))

(t/deftest "flower surrounded by spaces"
  (t/assert-equal ["111" "1*1" "111"] (sol/annotate ["   " " * " "   "])))

(t/deftest "space surrounded by flowers"
  (t/assert-equal ["***" "*8*" "***"] (sol/annotate ["***" "* *" "***"])))

(t/deftest "horizontal line"
  (t/assert-equal ["1*2*1"] (sol/annotate [" * * "])))

(t/deftest "horizontal line, flowers at edges"
  (t/assert-equal ["*1 1*"] (sol/annotate ["*   *"])))

(t/deftest "vertical line"
  (t/assert-equal ["1" "*" "2" "*" "1"] (sol/annotate [" " "*" " " "*" " "])))

(t/deftest "vertical line, flowers at edges"
  (t/assert-equal ["*" "1" " " "1" "*"] (sol/annotate ["*" " " " " " " "*"])))

(t/deftest "cross"
  (t/assert-equal [" 2*2 " "25*52" "*****" "25*52" " 2*2 "] (sol/annotate ["  *  " "  *  " "*****" "  *  " "  *  "])))

(t/deftest "large garden"
  (t/assert-equal ["1*22*1" "12*322" " 123*2" "112*4*" "1*22*2" "111111"] (sol/annotate [" *  * " "  *   " "    * " "   * *" " *  * " "      "])))

(t/deftest "multiple adjacent flowers"
  (t/assert-equal ["1**1"] (sol/annotate [" ** "])))

(t/run)
