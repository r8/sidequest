t ← •Import "../lib/test.bqn"
g ← •Import "../train-cars.bqn"

t.Run ⟨
  "1. the first two cars"‿{𝕊: 7‿31 t.Expect 2 g.Front 7‿31‿12‿45}
  "1. only the locomotive"‿{𝕊: ⟨7⟩ t.Expect 1 g.Front 7‿31‿12‿45}
  "1. no cars"‿{𝕊: ⟨⟩ t.Expect 0 g.Front 7‿31‿12‿45}
  "1. the whole train"‿{𝕊: 7‿31‿12‿45 t.Expect 4 g.Front 7‿31‿12‿45}
  "2. uncouple one car"‿{𝕊: 7‿31‿12 t.Expect 1 g.Uncouple 7‿31‿12‿45}
  "2. uncouple three cars"‿{𝕊: ⟨7⟩ t.Expect 3 g.Uncouple 7‿31‿12‿45}
  "2. uncouple nothing"‿{𝕊: 7‿31‿12‿45 t.Expect 0 g.Uncouple 7‿31‿12‿45}
  "3. turn a train of four"‿{𝕊: 7‿45‿12‿31 t.Expect g.Turn 7‿31‿12‿45}
  "3. turn a train with one car"‿{𝕊: 7‿31 t.Expect g.Turn 7‿31}
  "3. a locomotive alone"‿{𝕊: ⟨7⟩ t.Expect g.Turn ⟨7⟩}
  "4. one step"‿{𝕊: 0‿8‿5‿3 t.Expect 1 g.Turntable 3‿0‿8‿5}
  "4. one step back"‿{𝕊: 5‿3‿0‿8 t.Expect ¯1 g.Turntable 3‿0‿8‿5}
  "4. a full turn"‿{𝕊: 3‿0‿8‿5 t.Expect 4 g.Turntable 3‿0‿8‿5}
  "4. more than a full turn"‿{𝕊: 8‿5‿3‿0 t.Expect 6 g.Turntable 3‿0‿8‿5}
  "5. an empty slot rolls out"‿{𝕊: 9‿4‿6 t.Expect 9 g.Siding 4‿6‿0}
  "5. a car rolls out"‿{𝕊: 9‿4‿6 t.Expect 9 g.Siding 4‿6‿2}
  "5. into an empty siding"‿{𝕊: 9‿0‿0‿0 t.Expect 9 g.Siding 0‿0‿0‿0}
  "6. a short train"‿{𝕊: 0‿0‿7‿31‿12 t.Expect 5 g.Platform 7‿31‿12}
  "6. a train that fits exactly"‿{𝕊: 7‿31‿12 t.Expect 3 g.Platform 7‿31‿12}
  "6. a long train"‿{𝕊: 12‿45 t.Expect 2 g.Platform 7‿31‿12‿45}
⟩
