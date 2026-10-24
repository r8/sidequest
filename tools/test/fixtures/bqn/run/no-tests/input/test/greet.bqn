t ← •Import "../lib/test.bqn"
g ← •Import "../greet.bqn"

# A comment with a brace } and a "string" that must not confuse extraction.
t.Run ⟨
  "greets"‿{𝕊:
    •Out "noisy output"
    •Out "second line"
    "Hello, you!" t.Expect g.Greet "you"
  }
  "name with ""quotes"""‿{𝕊: "Hello, ""Bob""!" t.Expect g.Greet """Bob"""}
  "doubles a list"‿{𝕊: 2‿4‿6 t.Expect g.Double 1‿2‿3}
⟩
