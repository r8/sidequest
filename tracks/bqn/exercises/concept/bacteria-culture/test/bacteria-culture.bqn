t ← •Import "../lib/test.bqn"
g ← •Import "../bacteria-culture.bqn"

t.Run ⟨
  "1. three hours"‿{𝕊: 800 t.Expect 3 g.Grow 100}
  "1. one hour"‿{𝕊: 14 t.Expect 1 g.Grow 7}
  "1. no time at all"‿{𝕊: 50 t.Expect 0 g.Grow 50}
  "1. a long night"‿{𝕊: 4096 t.Expect 12 g.Grow 1}
  "2. three hours"‿{𝕊: 100‿200‿400‿800 t.Expect 3 g.Timeline 100}
  "2. one hour"‿{𝕊: 5‿10 t.Expect 1 g.Timeline 5}
  "2. only now"‿{𝕊: ⟨9⟩ t.Expect 0 g.Timeline 9}
  "3. two hours ago"‿{𝕊: 200 t.Expect 2 g.Earlier 800}
  "3. one hour ago"‿{𝕊: 15 t.Expect 1 g.Earlier 30}
  "3. now"‿{𝕊: 64 t.Expect 0 g.Earlier 64}
  "3. back to a fraction"‿{𝕊: 0.5 t.Expect 3 g.Earlier 4}
  "4. four doublings"‿{𝕊: 4 t.Approx 100 g.HoursNeeded 1600}
  "4. already there"‿{𝕊: 0 t.Approx 25 g.HoursNeeded 25}
  "4. ten doublings"‿{𝕊: 10 t.Approx 3 g.HoursNeeded 3072}
  "4. part of an hour"‿{𝕊: 1.58 t.Approx 100 g.HoursNeeded 300}
  "5. body temperature"‿{𝕊: 141 t.Approx g.Encode 37}
  "5. freezing"‿{𝕊: 30 t.Approx g.Encode 0}
  "5. below freezing"‿{𝕊: 0 t.Approx g.Encode ¯10}
  "6. body temperature"‿{𝕊: 37 t.Approx g.Decode 141}
  "6. freezing"‿{𝕊: 0 t.Approx g.Decode 30}
  "6. a fraction of a degree"‿{𝕊: 21.5 t.Approx g.Decode 94.5}
⟩
