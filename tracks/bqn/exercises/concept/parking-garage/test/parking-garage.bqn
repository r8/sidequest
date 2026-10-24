t ← •Import "../lib/test.bqn"
g ← •Import "../parking-garage.bqn"

t.Run ⟨
  "1. a motorbike"‿{𝕊: 1 t.Expect g.Rate "motorbike"}
  "1. a car"‿{𝕊: 2 t.Expect g.Rate "car"}
  "1. a van"‿{𝕊: 3 t.Expect g.Rate "van"}
  "1. a camper"‿{𝕊: 4 t.Expect g.Rate "camper"}
  "1. an empty string"‿{𝕊: 4 t.Expect g.Rate ""}
  "2. a quick stop is free"‿{𝕊: 0 t.Expect g.Fee 1}
  "2. no time at all"‿{𝕊: 0 t.Expect g.Fee 0}
  "2. an afternoon"‿{𝕊: 6 t.Expect g.Fee 4}
  "2. just under the cap"‿{𝕊: 20 t.Expect g.Fee 11}
  "2. a whole day"‿{𝕊: 20 t.Expect g.Fee 24}
  "3. a lorry"‿{𝕊: "ground" t.Expect g.Floor 3.4}
  "3. a camper van"‿{𝕊: "middle" t.Expect g.Floor 1.9}
  "3. exactly 2.2 metres"‿{𝕊: "middle" t.Expect g.Floor 2.2}
  "3. a hatchback"‿{𝕊: "roof" t.Expect g.Floor 1.5}
  "3. exactly 1.6 metres"‿{𝕊: "roof" t.Expect g.Floor 1.6}
  "4. no voucher"‿{𝕊: 6 t.Approx g.Charge 4}
  "4. half price"‿{𝕊: 3 t.Approx "HALF" g.Charge 4}
  "4. free parking"‿{𝕊: 0 t.Approx "FREE" g.Charge 24}
  "4. an unknown voucher"‿{𝕊: 20 t.Approx "LUCKY" g.Charge 30}
  "5. plenty of space"‿{𝕊: 35 t.Expect g.Sign 120‿85}
  "5. one space left"‿{𝕊: 1 t.Expect g.Sign 120‿119}
  "5. exactly full"‿{𝕊: "FULL" t.Expect g.Sign 120‿120}
  "5. overbooked"‿{𝕊: "FULL" t.Expect g.Sign 120‿121}
⟩
