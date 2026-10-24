t ← •Import "../lib/test.bqn"
g ← •Import "../palindrome-products.bqn"

t.Run ⟨
  "find the smallest palindrome from single digit factors"‿{𝕊: 1‿⟨1‿1⟩ t.Expect g.Smallest 1‿9}
  "find the largest palindrome from single digit factors"‿{𝕊: 9‿⟨1‿9, 3‿3⟩ t.Expect g.Largest 1‿9}
  "find the smallest palindrome from double digit factors"‿{𝕊: 121‿⟨11‿11⟩ t.Expect g.Smallest 10‿99}
  "find the largest palindrome from double digit factors"‿{𝕊: 9009‿⟨91‿99⟩ t.Expect g.Largest 10‿99}
  "find the smallest palindrome from triple digit factors"‿{𝕊: 10201‿⟨101‿101⟩ t.Expect g.Smallest 100‿999}
  "find the largest palindrome from triple digit factors"‿{𝕊: 906609‿⟨913‿993⟩ t.Expect g.Largest 100‿999}
  "find the smallest palindrome from four digit factors"‿{𝕊: 1002001‿⟨1001‿1001⟩ t.Expect g.Smallest 1000‿9999}
  "find the largest palindrome from four digit factors"‿{𝕊: 99000099‿⟨9901‿9999⟩ t.Expect g.Largest 1000‿9999}
  "empty result for smallest if no palindrome in the range"‿{𝕊: @‿⟨⟩ t.Expect g.Smallest 1002‿1003}
  "empty result for largest if no palindrome in the range"‿{𝕊: @‿⟨⟩ t.Expect g.Largest 15‿15}
  "error result for smallest if min is more than max"‿{𝕊: {𝕊: g.Smallest 10000‿1} t._throws "min must be <= max"}
  "error result for largest if min is more than max"‿{𝕊: {𝕊: g.Largest 2‿1} t._throws "min must be <= max"}
  "smallest product does not use the smallest factor"‿{𝕊: 10988901‿⟨3297‿3333⟩ t.Expect g.Smallest 3215‿4000}
  # Not in the canonical data: a range starting at zero, whose smallest palindrome 0 is 0 times anything.
  "smallest palindrome of a range starting at zero"‿{𝕊: 0‿⟨0‿0, 0‿1, 0‿2, 0‿3⟩ t.Expect g.Smallest 0‿3}
  "largest palindrome of the range zero to zero"‿{𝕊: 0‿⟨0‿0⟩ t.Expect g.Largest 0‿0}
⟩
