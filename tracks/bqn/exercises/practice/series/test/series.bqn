t ← •Import "../lib/test.bqn"
g ← •Import "../series.bqn"

t.Run ⟨
  "slices of one from one"‿{𝕊: ⟨"1"⟩ t.Expect 1 g.Slices "1"}
  "slices of one from two"‿{𝕊: "1"‿"2" t.Expect 1 g.Slices "12"}
  "slices of two"‿{𝕊: ⟨"35"⟩ t.Expect 2 g.Slices "35"}
  "slices of two overlap"‿{𝕊: "91"‿"14"‿"42" t.Expect 2 g.Slices "9142"}
  "slices can include duplicates"‿{𝕊: "777"‿"777"‿"777"‿"777" t.Expect 3 g.Slices "777777"}
  "slices of a long series"‿{𝕊: "91849"‿"18493"‿"84939"‿"49390"‿"93904"‿"39042"‿"90424"‿"04243" t.Expect 5 g.Slices "918493904243"}
  "slice length is too large"‿{𝕊: {𝕊: 6 g.Slices "12345"} t._throws "slice length cannot be greater than series length"}
  "slice length is way too large"‿{𝕊: {𝕊: 42 g.Slices "12345"} t._throws "slice length cannot be greater than series length"}
  "slice length cannot be zero"‿{𝕊: {𝕊: 0 g.Slices "12345"} t._throws "slice length cannot be zero"}
  "slice length cannot be negative"‿{𝕊: {𝕊: ¯1 g.Slices "123"} t._throws "slice length cannot be negative"}
  "empty series is invalid"‿{𝕊: {𝕊: 1 g.Slices ""} t._throws "series cannot be empty"}
⟩
