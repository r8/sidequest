t ← •Import "../lib/test.bqn"
g ← •Import "../package-inspector.bqn"

t.Run ⟨
  "1. a valid weight"‿{𝕊: 12 t.Expect g.CheckWeight 12}
  "1. exactly the limit"‿{𝕊: 30 t.Expect g.CheckWeight 30}
  "1. too heavy"‿{𝕊: {𝕊: g.CheckWeight 31} t._throws "too heavy"}
  "1. weighs nothing"‿{𝕊: {𝕊: g.CheckWeight 0} t._throws "weight must be positive"}
  "1. a negative weight"‿{𝕊: {𝕊: g.CheckWeight ¯4} t._throws "weight must be positive"}
  "2. a small box"‿{𝕊: 6000 t.Expect g.Volume 20‿30‿10}
  "2. exactly the limit"‿{𝕊: 125000 t.Expect g.Volume 50‿50‿50}
  "2. too big"‿{𝕊: {𝕊: g.Volume 100‿40‿20} t._throws "too big"}
  "2. a flat parcel"‿{𝕊: {𝕊: g.Volume 30‿20‿0} t._throws "sides must be positive"}
  "2. a negative side is checked before the size"‿{𝕊: {𝕊: g.Volume 200‿¯1‿10} t._throws "sides must be positive"}
  "3. a valid parcel"‿{𝕊: 24 t.Expect 2 g.Postage 12}
  "3. a cheaper rate"‿{𝕊: 7.5 t.Expect 0.5 g.Postage 15}
  "3. too heavy"‿{𝕊: {𝕊: 2 g.Postage 40} t._throws "too heavy"}
  "3. weighs nothing"‿{𝕊: {𝕊: 2 g.Postage 0} t._throws "weight must be positive"}
  "4. a valid weight"‿{𝕊: 12 t.Expect g.SafeWeight 12}
  "4. too heavy"‿{𝕊: 0 t.Expect g.SafeWeight 31}
  "4. a negative weight"‿{𝕊: 0 t.Expect g.SafeWeight ¯4}
  "5. a valid parcel"‿{𝕊: "ok" t.Expect g.Inspect 20‿30‿10}
  "5. too big"‿{𝕊: "too big" t.Expect g.Inspect 100‿40‿20}
  "5. a flat parcel"‿{𝕊: "sides must be positive" t.Expect g.Inspect 30‿0‿20}
⟩
