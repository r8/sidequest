t ← •Import "../lib/test.bqn"
g ← •Import "../flatten-array.bqn"

# @ stands in for null.
t.Run ⟨
  "empty"‿{𝕊: ⟨⟩ t.Expect g.Flatten ⟨⟩}
  "no nesting"‿{𝕊: 0‿1‿2 t.Expect g.Flatten 0‿1‿2}
  "flattens a nested array"‿{𝕊: ⟨⟩ t.Expect g.Flatten ⟨⟨⟨⟩⟩⟩}
  "flattens array with just integers present"‿{𝕊: 1‿2‿3‿4‿5‿6‿7‿8 t.Expect g.Flatten ⟨1, 2‿3‿4‿5‿6‿7, 8⟩}
  "5 level nesting"‿{𝕊: 0‿2‿2‿3‿8‿100‿4‿50‿¯2 t.Expect g.Flatten ⟨0, 2, ⟨2‿3, 8, 100, 4, ⟨⟨⟨50⟩⟩⟩⟩, ¯2⟩}
  "6 level nesting"‿{𝕊: 1‿2‿3‿4‿5‿6‿7‿8 t.Expect g.Flatten ⟨1, ⟨2, ⟨⟨3⟩⟩, ⟨4, ⟨⟨5⟩⟩⟩, 6, 7⟩, 8⟩}
  "null values are omitted from the final result"‿{𝕊: 1‿2 t.Expect g.Flatten ⟨1, 2, @⟩}
  "consecutive null values at the front of the array are omitted from the final result"‿{𝕊: ⟨3⟩ t.Expect g.Flatten ⟨@, @, 3⟩}
  "consecutive null values in the middle of the array are omitted from the final result"‿{𝕊: 1‿4 t.Expect g.Flatten ⟨1, @, @, 4⟩}
  "6 level nested array with null values"‿{𝕊: 0‿2‿2‿3‿8‿100‿¯2 t.Expect g.Flatten ⟨0, 2, ⟨2‿3, 8, ⟨⟨100⟩⟩, @, ⟨⟨@⟩⟩⟩, ¯2⟩}
  "all values in nested array are null"‿{𝕊: ⟨⟩ t.Expect g.Flatten ⟨@, ⟨⟨⟨@⟩⟩⟩, @, @, ⟨⟨@, @⟩, @⟩, @⟩}
⟩
