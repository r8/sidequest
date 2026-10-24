t ← •Import "../lib/test.bqn"
g ← •Import "../nucleotide-count.bqn"

t.Run ⟨
  "empty strand"‿{𝕊: 0‿0‿0‿0 t.Expect g.NucleotideCounts ""}
  "can count one nucleotide in single-character input"‿{𝕊: 0‿0‿1‿0 t.Expect g.NucleotideCounts "G"}
  "strand with repeated nucleotide"‿{𝕊: 0‿0‿7‿0 t.Expect g.NucleotideCounts "GGGGGGG"}
  "strand with multiple nucleotides"‿{𝕊: 20‿12‿17‿21 t.Expect g.NucleotideCounts "AGCTTTTCATTCTGACTGCAACGGGCAATATGTCTCTGTGTGGATTAAAAAAAGAGTGTCTGATAGCAGC"}
  "strand with invalid nucleotides"‿{𝕊: {𝕊: g.NucleotideCounts "AGXXACT"} t._throws "Invalid nucleotide in strand"}
⟩
