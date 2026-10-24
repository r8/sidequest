t ← •Import "../lib/test.bqn"
g ← •Import "../hamming.bqn"

t.Run ⟨
  "empty strands"‿{𝕊: 0 t.Expect "" g.Distance ""}
  "single letter identical strands"‿{𝕊: 0 t.Expect "A" g.Distance "A"}
  "single letter different strands"‿{𝕊: 1 t.Expect "G" g.Distance "T"}
  "long identical strands"‿{𝕊: 0 t.Expect "GGACTGAAATCTG" g.Distance "GGACTGAAATCTG"}
  "long different strands"‿{𝕊: 9 t.Expect "GGACGGATTCTG" g.Distance "AGGACGGATTCT"}
  "disallow first strand longer"‿{𝕊: {𝕊: "AATG" g.Distance "AAA"} t._throws "strands must be of equal length"}
  "disallow second strand longer"‿{𝕊: {𝕊: "ATA" g.Distance "AGTG"} t._throws "strands must be of equal length"}
  "disallow empty first strand"‿{𝕊: {𝕊: "" g.Distance "G"} t._throws "strands must be of equal length"}
  "disallow empty second strand"‿{𝕊: {𝕊: "G" g.Distance ""} t._throws "strands must be of equal length"}
⟩
