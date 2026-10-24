t ← •Import "../lib/test.bqn"
g ← •Import "../word-search.bqn"

# Each found word is ⟨start, end⟩, both row‿column counting from 1; a missing word is ⟨⟩.
grid ← ⟨
  "jefblpepre", "camdcimgtc", "oivokprjsm", "pbwasqroua", "rixilelhrs"
  "wolcqlirpc", "screeaumgr", "alxhpburyi", "jalaycalmp", "clojurermt"
⟩
clojure ← ⟨10‿1, 10‿7⟩
elixir ← ⟨5‿6, 5‿1⟩
ecmascript ← ⟨1‿10, 10‿10⟩
rust ← ⟨5‿9, 2‿9⟩
java ← ⟨1‿1, 4‿4⟩
lua ← ⟨9‿8, 7‿6⟩
lisp ← ⟨6‿3, 3‿6⟩
ruby ← ⟨6‿8, 9‿5⟩

t.Run ⟨
  "Should accept an initial game grid and a target search word"‿{𝕊: ⟨⟨⟩⟩ t.Expect ⟨"jefblpepre"⟩ g.Search ⟨"clojure"⟩}
  "Should locate one word written left to right"‿{𝕊: ⟨⟨1‿1, 1‿7⟩⟩ t.Expect ⟨"clojurermt"⟩ g.Search ⟨"clojure"⟩}
  "Should locate the same word written left to right in a different position"‿{𝕊: ⟨⟨1‿3, 1‿9⟩⟩ t.Expect ⟨"mtclojurer"⟩ g.Search ⟨"clojure"⟩}
  "Should locate a different left to right word"‿{𝕊: ⟨⟨1‿1, 1‿6⟩⟩ t.Expect ⟨"coffeelplx"⟩ g.Search ⟨"coffee"⟩}
  "Should locate that different left to right word in a different position"‿{𝕊: ⟨⟨1‿2, 1‿7⟩⟩ t.Expect ⟨"xcoffeezlp"⟩ g.Search ⟨"coffee"⟩}
  "Should locate a left to right word in two line grid"‿{𝕊: ⟨⟨2‿2, 2‿8⟩⟩ t.Expect "jefblpepre"‿"tclojurerm" g.Search ⟨"clojure"⟩}
  "Should locate a left to right word in three line grid"‿{𝕊: ⟨⟨3‿1, 3‿7⟩⟩ t.Expect "camdcimgtc"‿"jefblpepre"‿"clojurermt" g.Search ⟨"clojure"⟩}
  "Should locate a left to right word in ten line grid"‿{𝕊: ⟨clojure⟩ t.Expect grid g.Search ⟨"clojure"⟩}
  "Should locate that left to right word in a different position in a ten line grid"‿{𝕊:
    moved ← ⟨"jefblpepre", "camdcimgtc", "oivokprjsm", "pbwasqroua", "rixilelhrs", "wolcqlirpc", "screeaumgr", "alxhpburyi", "clojurermt", "jalaycalmp"⟩
    ⟨⟨9‿1, 9‿7⟩⟩ t.Expect moved g.Search ⟨"clojure"⟩
  }
  "Should locate a different left to right word in a ten line grid"‿{𝕊:
    fortranGrid ← ⟨"jefblpepre", "camdcimgtc", "oivokprjsm", "pbwasqroua", "rixilelhrs", "wolcqlirpc", "fortranftw", "alxhpburyi", "clojurermt", "jalaycalmp"⟩
    ⟨⟨7‿1, 7‿7⟩⟩ t.Expect fortranGrid g.Search ⟨"fortran"⟩
  }
  "Should locate multiple words"‿{𝕊:
    fortranGrid ← ⟨"jefblpepre", "camdcimgtc", "oivokprjsm", "pbwasqroua", "rixilelhrs", "wolcqlirpc", "fortranftw", "alxhpburyi", "jalaycalmp", "clojurermt"⟩
    ⟨⟨7‿1, 7‿7⟩, clojure⟩ t.Expect fortranGrid g.Search "fortran"‿"clojure"
  }
  "Should locate a single word written right to left"‿{𝕊: ⟨⟨1‿6, 1‿1⟩⟩ t.Expect ⟨"rixilelhrs"⟩ g.Search ⟨"elixir"⟩}
  "Should locate multiple words written in different horizontal directions"‿{𝕊: elixir‿clojure t.Expect grid g.Search "elixir"‿"clojure"}
  "Should locate words written top to bottom"‿{𝕊: clojure‿elixir‿ecmascript t.Expect grid g.Search "clojure"‿"elixir"‿"ecmascript"}
  "Should locate words written bottom to top"‿{𝕊: clojure‿elixir‿ecmascript‿rust t.Expect grid g.Search "clojure"‿"elixir"‿"ecmascript"‿"rust"}
  "Should locate words written top left to bottom right"‿{𝕊: clojure‿elixir‿ecmascript‿rust‿java t.Expect grid g.Search "clojure"‿"elixir"‿"ecmascript"‿"rust"‿"java"}
  "Should locate words written bottom right to top left"‿{𝕊: clojure‿elixir‿ecmascript‿rust‿java‿lua t.Expect grid g.Search "clojure"‿"elixir"‿"ecmascript"‿"rust"‿"java"‿"lua"}
  "Should locate words written bottom left to top right"‿{𝕊: clojure‿elixir‿ecmascript‿rust‿java‿lua‿lisp t.Expect grid g.Search "clojure"‿"elixir"‿"ecmascript"‿"rust"‿"java"‿"lua"‿"lisp"}
  "Should locate words written top right to bottom left"‿{𝕊: clojure‿elixir‿ecmascript‿rust‿java‿lua‿lisp‿ruby t.Expect grid g.Search "clojure"‿"elixir"‿"ecmascript"‿"rust"‿"java"‿"lua"‿"lisp"‿"ruby"}
  "Should fail to locate a word that is not in the puzzle"‿{𝕊: clojure‿elixir‿ecmascript‿rust‿java‿lua‿lisp‿ruby‿⟨⟩ t.Expect grid g.Search "clojure"‿"elixir"‿"ecmascript"‿"rust"‿"java"‿"lua"‿"lisp"‿"ruby"‿"haskell"}
  "Should fail to locate words that are not on horizontal, vertical, or diagonal lines"‿{𝕊: ⟨⟨⟩, ⟨⟩, ⟨⟩, ⟨⟩⟩ t.Expect "abc"‿"def" g.Search "aef"‿"ced"‿"abf"‿"cbd"}
  "Should not concatenate different lines to find a horizontal word"‿{𝕊: ⟨⟨⟩⟩ t.Expect "abceli"‿"xirdfg" g.Search ⟨"elixir"⟩}
  "Should not wrap around horizontally to find a word"‿{𝕊: ⟨⟨⟩⟩ t.Expect ⟨"silabcdefp"⟩ g.Search ⟨"lisp"⟩}
  "Should not wrap around vertically to find a word"‿{𝕊: ⟨⟨⟩⟩ t.Expect "s"‿"u"‿"r"‿"a"‿"b"‿"c"‿"t" g.Search ⟨"rust"⟩}
⟩
