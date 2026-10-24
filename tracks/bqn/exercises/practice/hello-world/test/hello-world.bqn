t ← •Import "../lib/test.bqn"
g ← •Import "../hello-world.bqn"

t.Run ⟨
  "Say Hi!"‿{𝕊: "Hello, World!" t.Expect g.Hello @}
⟩
