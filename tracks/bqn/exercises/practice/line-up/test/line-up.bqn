t ← •Import "../lib/test.bqn"
g ← •Import "../line-up.bqn"

t.Run ⟨
  "format smallest non-exceptional ordinal numeral 4"‿{𝕊: "Gianna, you are the 4th customer we serve today. Thank you!" t.Expect "Gianna" g.Format 4}
  "format greatest single digit non-exceptional ordinal numeral 9"‿{𝕊: "Maarten, you are the 9th customer we serve today. Thank you!" t.Expect "Maarten" g.Format 9}
  "format non-exceptional ordinal numeral 5"‿{𝕊: "Petronila, you are the 5th customer we serve today. Thank you!" t.Expect "Petronila" g.Format 5}
  "format non-exceptional ordinal numeral 6"‿{𝕊: "Attakullakulla, you are the 6th customer we serve today. Thank you!" t.Expect "Attakullakulla" g.Format 6}
  "format non-exceptional ordinal numeral 7"‿{𝕊: "Kate, you are the 7th customer we serve today. Thank you!" t.Expect "Kate" g.Format 7}
  "format non-exceptional ordinal numeral 8"‿{𝕊: "Maximiliano, you are the 8th customer we serve today. Thank you!" t.Expect "Maximiliano" g.Format 8}
  "format exceptional ordinal numeral 1"‿{𝕊: "Mary, you are the 1st customer we serve today. Thank you!" t.Expect "Mary" g.Format 1}
  "format exceptional ordinal numeral 2"‿{𝕊: "Haruto, you are the 2nd customer we serve today. Thank you!" t.Expect "Haruto" g.Format 2}
  "format exceptional ordinal numeral 3"‿{𝕊: "Henriette, you are the 3rd customer we serve today. Thank you!" t.Expect "Henriette" g.Format 3}
  "format smallest two digit non-exceptional ordinal numeral 10"‿{𝕊: "Alvarez, you are the 10th customer we serve today. Thank you!" t.Expect "Alvarez" g.Format 10}
  "format non-exceptional ordinal numeral 11"‿{𝕊: "Jacqueline, you are the 11th customer we serve today. Thank you!" t.Expect "Jacqueline" g.Format 11}
  "format non-exceptional ordinal numeral 12"‿{𝕊: "Juan, you are the 12th customer we serve today. Thank you!" t.Expect "Juan" g.Format 12}
  "format non-exceptional ordinal numeral 13"‿{𝕊: "Patricia, you are the 13th customer we serve today. Thank you!" t.Expect "Patricia" g.Format 13}
  "format exceptional ordinal numeral 21"‿{𝕊: "Washi, you are the 21st customer we serve today. Thank you!" t.Expect "Washi" g.Format 21}
  "format exceptional ordinal numeral 22 ending in nd even though it is a multiple of 11"‿{𝕊: "Ingrid, you are the 22nd customer we serve today. Thank you!" t.Expect "Ingrid" g.Format 22}
  "format exceptional ordinal numeral 33 ending in rd even though it is a multiple of 11"‿{𝕊: "Mario, you are the 33rd customer we serve today. Thank you!" t.Expect "Mario" g.Format 33}
  "format exceptional ordinal numeral 52 ending in nd even though it is a multiple of 13"‿{𝕊: "Quentin, you are the 52nd customer we serve today. Thank you!" t.Expect "Quentin" g.Format 52}
  "format exceptional ordinal numeral 62"‿{𝕊: "Nayra, you are the 62nd customer we serve today. Thank you!" t.Expect "Nayra" g.Format 62}
  "format non-exceptional ordinal numeral 72 ending in nd even though it is a multiple of 12"‿{𝕊: "Ugo, you are the 72nd customer we serve today. Thank you!" t.Expect "Ugo" g.Format 72}
  "format exceptional ordinal numeral 91 ending in st even though it is a multiple of 13"‿{𝕊: "Boris, you are the 91st customer we serve today. Thank you!" t.Expect "Boris" g.Format 91}
  "format exceptional ordinal numeral 100"‿{𝕊: "John, you are the 100th customer we serve today. Thank you!" t.Expect "John" g.Format 100}
  "format exceptional ordinal numeral 101"‿{𝕊: "Zeinab, you are the 101st customer we serve today. Thank you!" t.Expect "Zeinab" g.Format 101}
  "format non-exceptional ordinal numeral 112"‿{𝕊: "Knud, you are the 112th customer we serve today. Thank you!" t.Expect "Knud" g.Format 112}
  "format exceptional ordinal numeral 123"‿{𝕊: "Yma, you are the 123rd customer we serve today. Thank you!" t.Expect "Yma" g.Format 123}
  "format large number 972 ending in nd even though it is a multiple of 12"‿{𝕊: "Elias, you are the 972nd customer we serve today. Thank you!" t.Expect "Elias" g.Format 972}
⟩
