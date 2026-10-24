t ← •Import "../lib/test.bqn"
g ← •Import "../gigasecond.bqn"

t.Run ⟨
  "date only specification of time"‿{𝕊: "2043-01-01T01:46:40" t.Expect g.Add "2011-04-25"}
  "second test for date only specification of time"‿{𝕊: "2009-02-19T01:46:40" t.Expect g.Add "1977-06-13"}
  "third test for date only specification of time"‿{𝕊: "1991-03-27T01:46:40" t.Expect g.Add "1959-07-19"}
  "full time specified"‿{𝕊: "2046-10-02T23:46:40" t.Expect g.Add "2015-01-24T22:00:00"}
  "full time with day roll-over"‿{𝕊: "2046-10-03T01:46:39" t.Expect g.Add "2015-01-24T23:59:59"}
  "does not mutate the input"‿{𝕊: m ← "2015-01-24T23:59:59" ⋄ g.Add m ⋄ "2015-01-24T23:59:59" t.Expect m}
⟩
