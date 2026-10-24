t ← •Import "../lib/test.bqn"
g ← •Import "../all-your-base.bqn"

t.Run ⟨
  "single bit one to decimal"‿{𝕊: ⟨1⟩ t.Expect g.Rebase 2‿⟨1⟩‿10}
  "binary to single decimal"‿{𝕊: ⟨5⟩ t.Expect g.Rebase 2‿⟨1, 0, 1⟩‿10}
  "single decimal to binary"‿{𝕊: ⟨1, 0, 1⟩ t.Expect g.Rebase 10‿⟨5⟩‿2}
  "binary to multiple decimal"‿{𝕊: ⟨4, 2⟩ t.Expect g.Rebase 2‿⟨1, 0, 1, 0, 1, 0⟩‿10}
  "decimal to binary"‿{𝕊: ⟨1, 0, 1, 0, 1, 0⟩ t.Expect g.Rebase 10‿⟨4, 2⟩‿2}
  "trinary to hexadecimal"‿{𝕊: ⟨2, 10⟩ t.Expect g.Rebase 3‿⟨1, 1, 2, 0⟩‿16}
  "hexadecimal to trinary"‿{𝕊: ⟨1, 1, 2, 0⟩ t.Expect g.Rebase 16‿⟨2, 10⟩‿3}
  "15-bit integer"‿{𝕊: ⟨6, 10, 45⟩ t.Expect g.Rebase 97‿⟨3, 46, 60⟩‿73}
  "empty list"‿{𝕊: ⟨0⟩ t.Expect g.Rebase 2‿⟨⟩‿10}
  "single zero"‿{𝕊: ⟨0⟩ t.Expect g.Rebase 10‿⟨0⟩‿2}
  "multiple zeros"‿{𝕊: ⟨0⟩ t.Expect g.Rebase 10‿⟨0, 0, 0⟩‿2}
  "leading zeros"‿{𝕊: ⟨4, 2⟩ t.Expect g.Rebase 7‿⟨0, 6, 0⟩‿10}
  "input base is one"‿{𝕊: {𝕊: g.Rebase 1‿⟨0⟩‿10} t._throws "input base must be >= 2"}
  "input base is zero"‿{𝕊: {𝕊: g.Rebase 0‿⟨⟩‿10} t._throws "input base must be >= 2"}
  "input base is negative"‿{𝕊: {𝕊: g.Rebase ¯2‿⟨1⟩‿10} t._throws "input base must be >= 2"}
  "negative digit"‿{𝕊: {𝕊: g.Rebase 2‿⟨1, ¯1, 1, 0, 1, 0⟩‿10} t._throws "all digits must satisfy 0 <= d < input base"}
  "invalid positive digit"‿{𝕊: {𝕊: g.Rebase 2‿⟨1, 2, 1, 0, 1, 0⟩‿10} t._throws "all digits must satisfy 0 <= d < input base"}
  "output base is one"‿{𝕊: {𝕊: g.Rebase 2‿⟨1, 0, 1, 0, 1, 0⟩‿1} t._throws "output base must be >= 2"}
  "output base is zero"‿{𝕊: {𝕊: g.Rebase 10‿⟨7⟩‿0} t._throws "output base must be >= 2"}
  "output base is negative"‿{𝕊: {𝕊: g.Rebase 2‿⟨1⟩‿¯7} t._throws "output base must be >= 2"}
  "both bases are negative"‿{𝕊: {𝕊: g.Rebase ¯2‿⟨1⟩‿¯7} t._throws "input base must be >= 2"}
⟩
