t ← •Import "../lib/test.bqn"
g ← •Import "../redacted-files.bqn"

t.Run ⟨
  "1. black out the middle"‿{𝕊: "ab██c" t.Expect 0‿0‿1‿1‿0 g.BlackOut "ab12c"}
  "1. nothing marked"‿{𝕊: "open" t.Expect 0‿0‿0‿0 g.BlackOut "open"}
  "1. everything marked"‿{𝕊: "████" t.Expect 1‿1‿1‿1 g.BlackOut "shut"}
  "1. an empty text"‿{𝕊: "" t.Expect ⟨⟩ g.BlackOut ""}
  "2. a phone number"‿{𝕊: "Call ###-#### now" t.Expect g.HideDigits "Call 555-0199 now"}
  "2. no digits"‿{𝕊: "no numbers here" t.Expect g.HideDigits "no numbers here"}
  "2. only digits"‿{𝕊: "####" t.Expect g.HideDigits "1984"}
  "3. first and last name"‿{𝕊: "Alice Brown" t.Expect 0‿6 g.Capitalise "alice brown"}
  "3. no indices"‿{𝕊: "quiet" t.Expect ⟨⟩ g.Capitalise "quiet"}
  "3. indices in any order"‿{𝕊: "LoUD" t.Expect 3‿0‿2 g.Capitalise "loud"}
  "4. lower a level"‿{𝕊: 2‿"Budget"‿"Roads" t.Expect g.Declassify 3‿"Budget"‿"Roads"}
  "4. down to public"‿{𝕊: 0‿"Minutes" t.Expect g.Declassify 1‿"Minutes"}
  "4. already public"‿{𝕊: 0‿"Leaflet" t.Expect g.Declassify 0‿"Leaflet"}
  "5. round down"‿{𝕊: 1200‿0‿5000 t.Expect g.RoundBudget 1234‿99‿5000}
  "5. just below a hundred"‿{𝕊: ⟨900⟩ t.Expect g.RoundBudget ⟨999⟩}
  "5. a debt rounds down too"‿{𝕊: ¯100‿¯300 t.Expect g.RoundBudget ¯50‿¯250}
⟩
