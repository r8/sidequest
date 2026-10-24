t ← •Import "../lib/test.bqn"
g ← •Import "../rna-transcription.bqn"

t.Run ⟨
  "Empty RNA sequence"‿{𝕊: "" t.Expect g.ToRna ""}
  "RNA complement of cytosine is guanine"‿{𝕊: "G" t.Expect g.ToRna "C"}
  "RNA complement of guanine is cytosine"‿{𝕊: "C" t.Expect g.ToRna "G"}
  "RNA complement of thymine is adenine"‿{𝕊: "A" t.Expect g.ToRna "T"}
  "RNA complement of adenine is uracil"‿{𝕊: "U" t.Expect g.ToRna "A"}
  "RNA complement"‿{𝕊: "UGCACCAGAAUU" t.Expect g.ToRna "ACGTGGTCTTAA"}
⟩
