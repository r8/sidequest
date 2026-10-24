t ← •Import "../lib/test.bqn"
g ← •Import "../grains.bqn"

# Square 64 and the board total exceed 2⋆53, beyond exact doubles, so they are left out.
t.Run ⟨
  "returns the number of grains on the square > grains on square 1"‿{𝕊: 1 t.Expect g.Square 1}
  "returns the number of grains on the square > grains on square 2"‿{𝕊: 2 t.Expect g.Square 2}
  "returns the number of grains on the square > grains on square 3"‿{𝕊: 4 t.Expect g.Square 3}
  "returns the number of grains on the square > grains on square 4"‿{𝕊: 8 t.Expect g.Square 4}
  "returns the number of grains on the square > grains on square 16"‿{𝕊: 32768 t.Expect g.Square 16}
  "returns the number of grains on the square > grains on square 32"‿{𝕊: 2147483648 t.Expect g.Square 32}
  "returns the number of grains on the square > square 0 is invalid"‿{𝕊: {𝕊: g.Square 0} t._throws "square must be between 1 and 64"}
  "returns the number of grains on the square > negative square is invalid"‿{𝕊: {𝕊: g.Square ¯1} t._throws "square must be between 1 and 64"}
  "returns the number of grains on the square > square greater than 64 is invalid"‿{𝕊: {𝕊: g.Square 65} t._throws "square must be between 1 and 64"}
⟩
