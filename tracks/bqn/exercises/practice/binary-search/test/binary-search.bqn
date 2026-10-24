t ← •Import "../lib/test.bqn"
g ← •Import "../binary-search.bqn"

t.Run ⟨
  "finds a value in an array with one element"‿{𝕊: 0 t.Expect ⟨6⟩ g.Find 6}
  "finds a value in the middle of an array"‿{𝕊: 3 t.Expect ⟨1, 3, 4, 6, 8, 9, 11⟩ g.Find 6}
  "finds a value at the beginning of an array"‿{𝕊: 0 t.Expect ⟨1, 3, 4, 6, 8, 9, 11⟩ g.Find 1}
  "finds a value at the end of an array"‿{𝕊: 6 t.Expect ⟨1, 3, 4, 6, 8, 9, 11⟩ g.Find 11}
  "finds a value in an array of odd length"‿{𝕊: 9 t.Expect ⟨1, 3, 5, 8, 13, 21, 34, 55, 89, 144, 233, 377, 634⟩ g.Find 144}
  "finds a value in an array of even length"‿{𝕊: 5 t.Expect ⟨1, 3, 5, 8, 13, 21, 34, 55, 89, 144, 233, 377⟩ g.Find 21}
  "identifies that a value is not included in the array"‿{𝕊: {𝕊: ⟨1, 3, 4, 6, 8, 9, 11⟩ g.Find 7} t._throws "value not in array"}
  "a value smaller than the array's smallest value is not found"‿{𝕊: {𝕊: ⟨1, 3, 4, 6, 8, 9, 11⟩ g.Find 0} t._throws "value not in array"}
  "a value larger than the array's largest value is not found"‿{𝕊: {𝕊: ⟨1, 3, 4, 6, 8, 9, 11⟩ g.Find 13} t._throws "value not in array"}
  "nothing is found in an empty array"‿{𝕊: {𝕊: ⟨⟩ g.Find 1} t._throws "value not in array"}
  "nothing is found when the left and right bounds cross"‿{𝕊: {𝕊: ⟨1, 2⟩ g.Find 0} t._throws "value not in array"}
⟩
