t ← •Import "../lib/test.bqn"
g ← •Import "../forth.bqn"

t.Run ⟨
  "parsing and numbers > numbers just get pushed onto the stack"‿{𝕊: 1‿2‿3‿4‿5 t.Expect g.Evaluate ⟨"1 2 3 4 5"⟩}
  "parsing and numbers > pushes negative numbers onto the stack"‿{𝕊: ¯1‿¯2‿¯3‿¯4‿¯5 t.Expect g.Evaluate ⟨"-1 -2 -3 -4 -5"⟩}
  "addition > can add two numbers"‿{𝕊: ⟨3⟩ t.Expect g.Evaluate ⟨"1 2 +"⟩}
  "addition > errors if there is nothing on the stack"‿{𝕊: {𝕊: g.Evaluate ⟨"+"⟩} t._throws "empty stack"}
  "addition > errors if there is only one value on the stack"‿{𝕊: {𝕊: g.Evaluate ⟨"1 +"⟩} t._throws "only one value on the stack"}
  "addition > more than two values on the stack"‿{𝕊: 1‿5 t.Expect g.Evaluate ⟨"1 2 3 +"⟩}
  "subtraction > can subtract two numbers"‿{𝕊: ⟨¯1⟩ t.Expect g.Evaluate ⟨"3 4 -"⟩}
  "subtraction > errors if there is nothing on the stack"‿{𝕊: {𝕊: g.Evaluate ⟨"-"⟩} t._throws "empty stack"}
  "subtraction > errors if there is only one value on the stack"‿{𝕊: {𝕊: g.Evaluate ⟨"1 -"⟩} t._throws "only one value on the stack"}
  "subtraction > more than two values on the stack"‿{𝕊: 1‿9 t.Expect g.Evaluate ⟨"1 12 3 -"⟩}
  "multiplication > can multiply two numbers"‿{𝕊: ⟨8⟩ t.Expect g.Evaluate ⟨"2 4 *"⟩}
  "multiplication > errors if there is nothing on the stack"‿{𝕊: {𝕊: g.Evaluate ⟨"*"⟩} t._throws "empty stack"}
  "multiplication > errors if there is only one value on the stack"‿{𝕊: {𝕊: g.Evaluate ⟨"1 *"⟩} t._throws "only one value on the stack"}
  "multiplication > more than two values on the stack"‿{𝕊: 1‿6 t.Expect g.Evaluate ⟨"1 2 3 *"⟩}
  "division > can divide two numbers"‿{𝕊: ⟨4⟩ t.Expect g.Evaluate ⟨"12 3 /"⟩}
  "division > performs integer division"‿{𝕊: ⟨2⟩ t.Expect g.Evaluate ⟨"8 3 /"⟩}
  "division > errors if dividing by zero"‿{𝕊: {𝕊: g.Evaluate ⟨"4 0 /"⟩} t._throws "divide by zero"}
  "division > errors if there is nothing on the stack"‿{𝕊: {𝕊: g.Evaluate ⟨"/"⟩} t._throws "empty stack"}
  "division > errors if there is only one value on the stack"‿{𝕊: {𝕊: g.Evaluate ⟨"1 /"⟩} t._throws "only one value on the stack"}
  "division > more than two values on the stack"‿{𝕊: 1‿4 t.Expect g.Evaluate ⟨"1 12 3 /"⟩}
  # Not in the canonical data: integer division rounds toward zero, as in most languages' integer division.
  "division > rounds toward zero"‿{𝕊: ⟨¯3⟩ t.Expect g.Evaluate ⟨"-7 2 /"⟩}
  "combined arithmetic > addition and subtraction"‿{𝕊: ⟨¯1⟩ t.Expect g.Evaluate ⟨"1 2 + 4 -"⟩}
  "combined arithmetic > multiplication and division"‿{𝕊: ⟨2⟩ t.Expect g.Evaluate ⟨"2 4 * 3 /"⟩}
  "combined arithmetic > multiplication and addition"‿{𝕊: ⟨13⟩ t.Expect g.Evaluate ⟨"1 3 4 * +"⟩}
  "combined arithmetic > addition and multiplication"‿{𝕊: ⟨7⟩ t.Expect g.Evaluate ⟨"1 3 4 + *"⟩}
  "dup > copies a value on the stack"‿{𝕊: 1‿1 t.Expect g.Evaluate ⟨"1 dup"⟩}
  "dup > copies the top value on the stack"‿{𝕊: 1‿2‿2 t.Expect g.Evaluate ⟨"1 2 dup"⟩}
  "dup > errors if there is nothing on the stack"‿{𝕊: {𝕊: g.Evaluate ⟨"dup"⟩} t._throws "empty stack"}
  "drop > removes the top value on the stack if it is the only one"‿{𝕊: ⟨⟩ t.Expect g.Evaluate ⟨"1 drop"⟩}
  "drop > removes the top value on the stack if it is not the only one"‿{𝕊: ⟨1⟩ t.Expect g.Evaluate ⟨"1 2 drop"⟩}
  "drop > errors if there is nothing on the stack"‿{𝕊: {𝕊: g.Evaluate ⟨"drop"⟩} t._throws "empty stack"}
  "swap > swaps the top two values on the stack if they are the only ones"‿{𝕊: 2‿1 t.Expect g.Evaluate ⟨"1 2 swap"⟩}
  "swap > swaps the top two values on the stack if they are not the only ones"‿{𝕊: 1‿3‿2 t.Expect g.Evaluate ⟨"1 2 3 swap"⟩}
  "swap > errors if there is nothing on the stack"‿{𝕊: {𝕊: g.Evaluate ⟨"swap"⟩} t._throws "empty stack"}
  "swap > errors if there is only one value on the stack"‿{𝕊: {𝕊: g.Evaluate ⟨"1 swap"⟩} t._throws "only one value on the stack"}
  "over > copies the second element if there are only two"‿{𝕊: 1‿2‿1 t.Expect g.Evaluate ⟨"1 2 over"⟩}
  "over > copies the second element if there are more than two"‿{𝕊: 1‿2‿3‿2 t.Expect g.Evaluate ⟨"1 2 3 over"⟩}
  "over > errors if there is nothing on the stack"‿{𝕊: {𝕊: g.Evaluate ⟨"over"⟩} t._throws "empty stack"}
  "over > errors if there is only one value on the stack"‿{𝕊: {𝕊: g.Evaluate ⟨"1 over"⟩} t._throws "only one value on the stack"}
  "user-defined words > can consist of built-in words"‿{𝕊: 1‿1‿1 t.Expect g.Evaluate ⟨": dup-twice dup dup ;", "1 dup-twice"⟩}
  "user-defined words > execute in the right order"‿{𝕊: 1‿2‿3 t.Expect g.Evaluate ⟨": countup 1 2 3 ;", "countup"⟩}
  "user-defined words > can override other user-defined words"‿{𝕊: 1‿1‿1 t.Expect g.Evaluate ⟨": foo dup ;", ": foo dup dup ;", "1 foo"⟩}
  "user-defined words > can override built-in words"‿{𝕊: 1‿1 t.Expect g.Evaluate ⟨": swap dup ;", "1 swap"⟩}
  "user-defined words > can override built-in operators"‿{𝕊: ⟨12⟩ t.Expect g.Evaluate ⟨": + * ;", "3 4 +"⟩}
  "user-defined words > can use different words with the same name"‿{𝕊: 5‿6 t.Expect g.Evaluate ⟨": foo 5 ;", ": bar foo ;", ": foo 6 ;", "bar foo"⟩}
  "user-defined words > can define word that uses word with the same name"‿{𝕊: ⟨11⟩ t.Expect g.Evaluate ⟨": foo 10 ;", ": foo foo 1 + ;", "foo"⟩}
  "user-defined words > cannot redefine non-negative numbers"‿{𝕊: {𝕊: g.Evaluate ⟨": 1 2 ;"⟩} t._throws "illegal operation"}
  "user-defined words > cannot redefine negative numbers"‿{𝕊: {𝕊: g.Evaluate ⟨": -1 2 ;"⟩} t._throws "illegal operation"}
  "user-defined words > errors if executing a non-existent word"‿{𝕊: {𝕊: g.Evaluate ⟨"foo"⟩} t._throws "undefined operation"}
  "user-defined words > only defines locally"‿{𝕊: ⟨⟨0⟩, ⟨2⟩⟩ t.Expect g.Evaluate¨ ⟨⟨": + - ;", "1 1 +"⟩, ⟨"1 1 +"⟩⟩}
  "case-insensitivity > DUP is case-insensitive"‿{𝕊: 1‿1‿1‿1 t.Expect g.Evaluate ⟨"1 DUP Dup dup"⟩}
  "case-insensitivity > DROP is case-insensitive"‿{𝕊: ⟨1⟩ t.Expect g.Evaluate ⟨"1 2 3 4 DROP Drop drop"⟩}
  "case-insensitivity > SWAP is case-insensitive"‿{𝕊: 2‿3‿4‿1 t.Expect g.Evaluate ⟨"1 2 SWAP 3 Swap 4 swap"⟩}
  "case-insensitivity > OVER is case-insensitive"‿{𝕊: 1‿2‿1‿2‿1 t.Expect g.Evaluate ⟨"1 2 OVER Over over"⟩}
  "case-insensitivity > user-defined words are case-insensitive"‿{𝕊: 1‿1‿1‿1 t.Expect g.Evaluate ⟨": foo dup ;", "1 FOO Foo foo"⟩}
  "case-insensitivity > definitions are case-insensitive"‿{𝕊: 1‿1‿1‿1 t.Expect g.Evaluate ⟨": SWAP DUP Dup dup ;", "1 swap"⟩}
  # Not in the canonical data: a line with no words is a valid (empty) program.
  "empty and blank lines do nothing"‿{𝕊: 1‿2 t.Expect g.Evaluate ⟨"1", "", "   ", "2"⟩}
  # Not in the canonical data: words are separated by any whitespace, however much.
  "words are separated by any whitespace"‿{𝕊: ⟨3⟩ t.Expect g.Evaluate ⟨"1  2"∾(@+9)∾"+"⟩}
⟩
