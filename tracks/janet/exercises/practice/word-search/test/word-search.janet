(import test :as t)
(import ../word-search :as sol)

# Words that are not in the grid are left out of the result.

(t/deftest "Should accept an initial game grid and a target search word"
  (t/assert-equal
    {}
    (sol/search ["jefblpepre"]
                ["clojure"])))

(t/deftest "Should locate one word written left to right"
  (t/assert-equal
    {"clojure" {:start {:column 1 :row 1} :end {:column 7 :row 1}}}
    (sol/search ["clojurermt"]
                ["clojure"])))

(t/deftest "Should locate the same word written left to right in a different position"
  (t/assert-equal
    {"clojure" {:start {:column 3 :row 1} :end {:column 9 :row 1}}}
    (sol/search ["mtclojurer"]
                ["clojure"])))

(t/deftest "Should locate a different left to right word"
  (t/assert-equal
    {"coffee" {:start {:column 1 :row 1} :end {:column 6 :row 1}}}
    (sol/search ["coffeelplx"]
                ["coffee"])))

(t/deftest "Should locate that different left to right word in a different position"
  (t/assert-equal
    {"coffee" {:start {:column 2 :row 1} :end {:column 7 :row 1}}}
    (sol/search ["xcoffeezlp"]
                ["coffee"])))

(t/deftest "Should locate a left to right word in two line grid"
  (t/assert-equal
    {"clojure" {:start {:column 2 :row 2} :end {:column 8 :row 2}}}
    (sol/search ["jefblpepre" "tclojurerm"]
                ["clojure"])))

(t/deftest "Should locate a left to right word in three line grid"
  (t/assert-equal
    {"clojure" {:start {:column 1 :row 3} :end {:column 7 :row 3}}}
    (sol/search ["camdcimgtc"
                 "jefblpepre"
                 "clojurermt"]
                ["clojure"])))

(t/deftest "Should locate a left to right word in ten line grid"
  (t/assert-equal
    {"clojure" {:start {:column 1 :row 10} :end {:column 7 :row 10}}}
    (sol/search ["jefblpepre"
                 "camdcimgtc"
                 "oivokprjsm"
                 "pbwasqroua"
                 "rixilelhrs"
                 "wolcqlirpc"
                 "screeaumgr"
                 "alxhpburyi"
                 "jalaycalmp"
                 "clojurermt"]
                ["clojure"])))

(t/deftest "Should locate that left to right word in a different position in a ten line grid"
  (t/assert-equal
    {"clojure" {:start {:column 1 :row 9} :end {:column 7 :row 9}}}
    (sol/search ["jefblpepre"
                 "camdcimgtc"
                 "oivokprjsm"
                 "pbwasqroua"
                 "rixilelhrs"
                 "wolcqlirpc"
                 "screeaumgr"
                 "alxhpburyi"
                 "clojurermt"
                 "jalaycalmp"]
                ["clojure"])))

(t/deftest "Should locate a different left to right word in a ten line grid"
  (t/assert-equal
    {"fortran" {:start {:column 1 :row 7} :end {:column 7 :row 7}}}
    (sol/search ["jefblpepre"
                 "camdcimgtc"
                 "oivokprjsm"
                 "pbwasqroua"
                 "rixilelhrs"
                 "wolcqlirpc"
                 "fortranftw"
                 "alxhpburyi"
                 "clojurermt"
                 "jalaycalmp"]
                ["fortran"])))

(t/deftest "Should locate multiple words"
  (t/assert-equal
    {"fortran" {:start {:column 1 :row 7} :end {:column 7 :row 7}}
     "clojure" {:start {:column 1 :row 10} :end {:column 7 :row 10}}}
    (sol/search ["jefblpepre"
                 "camdcimgtc"
                 "oivokprjsm"
                 "pbwasqroua"
                 "rixilelhrs"
                 "wolcqlirpc"
                 "fortranftw"
                 "alxhpburyi"
                 "jalaycalmp"
                 "clojurermt"]
                ["fortran" "clojure"])))

(t/deftest "Should locate a single word written right to left"
  (t/assert-equal
    {"elixir" {:start {:column 6 :row 1} :end {:column 1 :row 1}}}
    (sol/search ["rixilelhrs"]
                ["elixir"])))

(t/deftest "Should locate multiple words written in different horizontal directions"
  (t/assert-equal
    {"elixir" {:start {:column 6 :row 5} :end {:column 1 :row 5}}
     "clojure" {:start {:column 1 :row 10} :end {:column 7 :row 10}}}
    (sol/search ["jefblpepre"
                 "camdcimgtc"
                 "oivokprjsm"
                 "pbwasqroua"
                 "rixilelhrs"
                 "wolcqlirpc"
                 "screeaumgr"
                 "alxhpburyi"
                 "jalaycalmp"
                 "clojurermt"]
                ["elixir" "clojure"])))

(t/deftest "Should locate words written top to bottom"
  (t/assert-equal
    {"clojure" {:start {:column 1 :row 10} :end {:column 7 :row 10}}
     "elixir" {:start {:column 6 :row 5} :end {:column 1 :row 5}}
     "ecmascript" {:start {:column 10 :row 1} :end {:column 10 :row 10}}}
    (sol/search ["jefblpepre"
                 "camdcimgtc"
                 "oivokprjsm"
                 "pbwasqroua"
                 "rixilelhrs"
                 "wolcqlirpc"
                 "screeaumgr"
                 "alxhpburyi"
                 "jalaycalmp"
                 "clojurermt"]
                ["clojure" "elixir" "ecmascript"])))

(t/deftest "Should locate words written bottom to top"
  (t/assert-equal
    {"clojure" {:start {:column 1 :row 10} :end {:column 7 :row 10}}
     "elixir" {:start {:column 6 :row 5} :end {:column 1 :row 5}}
     "ecmascript" {:start {:column 10 :row 1} :end {:column 10 :row 10}}
     "rust" {:start {:column 9 :row 5} :end {:column 9 :row 2}}}
    (sol/search ["jefblpepre"
                 "camdcimgtc"
                 "oivokprjsm"
                 "pbwasqroua"
                 "rixilelhrs"
                 "wolcqlirpc"
                 "screeaumgr"
                 "alxhpburyi"
                 "jalaycalmp"
                 "clojurermt"]
                ["clojure" "elixir" "ecmascript" "rust"])))

(t/deftest "Should locate words written top left to bottom right"
  (t/assert-equal
    {"clojure" {:start {:column 1 :row 10} :end {:column 7 :row 10}}
     "elixir" {:start {:column 6 :row 5} :end {:column 1 :row 5}}
     "ecmascript" {:start {:column 10 :row 1} :end {:column 10 :row 10}}
     "rust" {:start {:column 9 :row 5} :end {:column 9 :row 2}}
     "java" {:start {:column 1 :row 1} :end {:column 4 :row 4}}}
    (sol/search ["jefblpepre"
                 "camdcimgtc"
                 "oivokprjsm"
                 "pbwasqroua"
                 "rixilelhrs"
                 "wolcqlirpc"
                 "screeaumgr"
                 "alxhpburyi"
                 "jalaycalmp"
                 "clojurermt"]
                ["clojure" "elixir" "ecmascript" "rust" "java"])))

(t/deftest "Should locate words written bottom right to top left"
  (t/assert-equal
    {"clojure" {:start {:column 1 :row 10} :end {:column 7 :row 10}}
     "elixir" {:start {:column 6 :row 5} :end {:column 1 :row 5}}
     "ecmascript" {:start {:column 10 :row 1} :end {:column 10 :row 10}}
     "rust" {:start {:column 9 :row 5} :end {:column 9 :row 2}}
     "java" {:start {:column 1 :row 1} :end {:column 4 :row 4}}
     "lua" {:start {:column 8 :row 9} :end {:column 6 :row 7}}}
    (sol/search ["jefblpepre"
                 "camdcimgtc"
                 "oivokprjsm"
                 "pbwasqroua"
                 "rixilelhrs"
                 "wolcqlirpc"
                 "screeaumgr"
                 "alxhpburyi"
                 "jalaycalmp"
                 "clojurermt"]
                ["clojure" "elixir" "ecmascript" "rust" "java" "lua"])))

(t/deftest "Should locate words written bottom left to top right"
  (t/assert-equal
    {"clojure" {:start {:column 1 :row 10} :end {:column 7 :row 10}}
     "elixir" {:start {:column 6 :row 5} :end {:column 1 :row 5}}
     "ecmascript" {:start {:column 10 :row 1} :end {:column 10 :row 10}}
     "rust" {:start {:column 9 :row 5} :end {:column 9 :row 2}}
     "java" {:start {:column 1 :row 1} :end {:column 4 :row 4}}
     "lua" {:start {:column 8 :row 9} :end {:column 6 :row 7}}
     "lisp" {:start {:column 3 :row 6} :end {:column 6 :row 3}}}
    (sol/search ["jefblpepre"
                 "camdcimgtc"
                 "oivokprjsm"
                 "pbwasqroua"
                 "rixilelhrs"
                 "wolcqlirpc"
                 "screeaumgr"
                 "alxhpburyi"
                 "jalaycalmp"
                 "clojurermt"]
                ["clojure" "elixir" "ecmascript" "rust" "java" "lua" "lisp"])))

(t/deftest "Should locate words written top right to bottom left"
  (t/assert-equal
    {"clojure" {:start {:column 1 :row 10} :end {:column 7 :row 10}}
     "elixir" {:start {:column 6 :row 5} :end {:column 1 :row 5}}
     "ecmascript" {:start {:column 10 :row 1} :end {:column 10 :row 10}}
     "rust" {:start {:column 9 :row 5} :end {:column 9 :row 2}}
     "java" {:start {:column 1 :row 1} :end {:column 4 :row 4}}
     "lua" {:start {:column 8 :row 9} :end {:column 6 :row 7}}
     "lisp" {:start {:column 3 :row 6} :end {:column 6 :row 3}}
     "ruby" {:start {:column 8 :row 6} :end {:column 5 :row 9}}}
    (sol/search ["jefblpepre"
                 "camdcimgtc"
                 "oivokprjsm"
                 "pbwasqroua"
                 "rixilelhrs"
                 "wolcqlirpc"
                 "screeaumgr"
                 "alxhpburyi"
                 "jalaycalmp"
                 "clojurermt"]
                ["clojure" "elixir" "ecmascript" "rust" "java" "lua" "lisp" "ruby"])))

(t/deftest "Should fail to locate a word that is not in the puzzle"
  (t/assert-equal
    {"clojure" {:start {:column 1 :row 10} :end {:column 7 :row 10}}
     "elixir" {:start {:column 6 :row 5} :end {:column 1 :row 5}}
     "ecmascript" {:start {:column 10 :row 1} :end {:column 10 :row 10}}
     "rust" {:start {:column 9 :row 5} :end {:column 9 :row 2}}
     "java" {:start {:column 1 :row 1} :end {:column 4 :row 4}}
     "lua" {:start {:column 8 :row 9} :end {:column 6 :row 7}}
     "lisp" {:start {:column 3 :row 6} :end {:column 6 :row 3}}
     "ruby" {:start {:column 8 :row 6} :end {:column 5 :row 9}}}
    (sol/search ["jefblpepre"
                 "camdcimgtc"
                 "oivokprjsm"
                 "pbwasqroua"
                 "rixilelhrs"
                 "wolcqlirpc"
                 "screeaumgr"
                 "alxhpburyi"
                 "jalaycalmp"
                 "clojurermt"]
                ["clojure" "elixir" "ecmascript" "rust" "java" "lua" "lisp" "ruby" "haskell"])))

(t/deftest "Should fail to locate words that are not on horizontal, vertical, or diagonal lines"
  (t/assert-equal
    {}
    (sol/search ["abc" "def"]
                ["aef" "ced" "abf" "cbd"])))

(t/deftest "Should not concatenate different lines to find a horizontal word"
  (t/assert-equal
    {}
    (sol/search ["abceli" "xirdfg"]
                ["elixir"])))

(t/deftest "Should not wrap around horizontally to find a word"
  (t/assert-equal
    {}
    (sol/search ["silabcdefp"]
                ["lisp"])))

(t/deftest "Should not wrap around vertically to find a word"
  (t/assert-equal
    {}
    (sol/search ["s"
                 "u"
                 "r"
                 "a"
                 "b"
                 "c"
                 "t"]
                ["rust"])))

(t/run)
