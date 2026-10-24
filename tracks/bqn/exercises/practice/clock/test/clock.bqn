t ← •Import "../lib/test.bqn"
g ← •Import "../clock.bqn"

t.Run ⟨
  "Create a new clock with an initial time > on the hour"‿{𝕊: "08:00" t.Expect g.ToString g.Create 8‿0}
  "Create a new clock with an initial time > past the hour"‿{𝕊: "11:09" t.Expect g.ToString g.Create 11‿9}
  "Create a new clock with an initial time > midnight is zero hours"‿{𝕊: "00:00" t.Expect g.ToString g.Create 24‿0}
  "Create a new clock with an initial time > hour rolls over"‿{𝕊: "01:00" t.Expect g.ToString g.Create 25‿0}
  "Create a new clock with an initial time > hour rolls over continuously"‿{𝕊: "04:00" t.Expect g.ToString g.Create 100‿0}
  "Create a new clock with an initial time > sixty minutes is next hour"‿{𝕊: "02:00" t.Expect g.ToString g.Create 1‿60}
  "Create a new clock with an initial time > minutes roll over"‿{𝕊: "02:40" t.Expect g.ToString g.Create 0‿160}
  "Create a new clock with an initial time > minutes roll over continuously"‿{𝕊: "04:43" t.Expect g.ToString g.Create 0‿1723}
  "Create a new clock with an initial time > hour and minutes roll over"‿{𝕊: "03:40" t.Expect g.ToString g.Create 25‿160}
  "Create a new clock with an initial time > hour and minutes roll over continuously"‿{𝕊: "11:01" t.Expect g.ToString g.Create 201‿3001}
  "Create a new clock with an initial time > hour and minutes roll over to exactly midnight"‿{𝕊: "00:00" t.Expect g.ToString g.Create 72‿8640}
  "Create a new clock with an initial time > negative hour"‿{𝕊: "23:15" t.Expect g.ToString g.Create ¯1‿15}
  "Create a new clock with an initial time > negative hour rolls over"‿{𝕊: "23:00" t.Expect g.ToString g.Create ¯25‿0}
  "Create a new clock with an initial time > negative hour rolls over continuously"‿{𝕊: "05:00" t.Expect g.ToString g.Create ¯91‿0}
  "Create a new clock with an initial time > negative minutes"‿{𝕊: "00:20" t.Expect g.ToString g.Create 1‿¯40}
  "Create a new clock with an initial time > negative minutes roll over"‿{𝕊: "22:20" t.Expect g.ToString g.Create 1‿¯160}
  "Create a new clock with an initial time > negative minutes roll over continuously"‿{𝕊: "16:40" t.Expect g.ToString g.Create 1‿¯4820}
  "Create a new clock with an initial time > negative sixty minutes is previous hour"‿{𝕊: "01:00" t.Expect g.ToString g.Create 2‿¯60}
  "Create a new clock with an initial time > negative hour and minutes both roll over"‿{𝕊: "20:20" t.Expect g.ToString g.Create ¯25‿¯160}
  "Create a new clock with an initial time > negative hour and minutes both roll over continuously"‿{𝕊: "22:10" t.Expect g.ToString g.Create ¯121‿¯5810}
  "Add minutes > add minutes"‿{𝕊: "10:03" t.Expect g.ToString (g.Create 10‿0) g.Add 3}
  "Add minutes > add no minutes"‿{𝕊: "06:41" t.Expect g.ToString (g.Create 6‿41) g.Add 0}
  "Add minutes > add to next hour"‿{𝕊: "01:25" t.Expect g.ToString (g.Create 0‿45) g.Add 40}
  "Add minutes > add more than one hour"‿{𝕊: "11:01" t.Expect g.ToString (g.Create 10‿0) g.Add 61}
  "Add minutes > add more than two hours with carry"‿{𝕊: "03:25" t.Expect g.ToString (g.Create 0‿45) g.Add 160}
  "Add minutes > add across midnight"‿{𝕊: "00:01" t.Expect g.ToString (g.Create 23‿59) g.Add 2}
  "Add minutes > add more than one day (1500 min = 25 hrs)"‿{𝕊: "06:32" t.Expect g.ToString (g.Create 5‿32) g.Add 1500}
  "Add minutes > add more than two days"‿{𝕊: "11:21" t.Expect g.ToString (g.Create 1‿1) g.Add 3500}
  "Subtract minutes > subtract minutes"‿{𝕊: "10:00" t.Expect g.ToString (g.Create 10‿3) g.Subtract 3}
  "Subtract minutes > subtract to previous hour"‿{𝕊: "09:33" t.Expect g.ToString (g.Create 10‿3) g.Subtract 30}
  "Subtract minutes > subtract more than an hour"‿{𝕊: "08:53" t.Expect g.ToString (g.Create 10‿3) g.Subtract 70}
  "Subtract minutes > subtract across midnight"‿{𝕊: "23:59" t.Expect g.ToString (g.Create 0‿3) g.Subtract 4}
  "Subtract minutes > subtract more than two hours"‿{𝕊: "21:20" t.Expect g.ToString (g.Create 0‿0) g.Subtract 160}
  "Subtract minutes > subtract more than two hours with borrow"‿{𝕊: "03:35" t.Expect g.ToString (g.Create 6‿15) g.Subtract 160}
  "Subtract minutes > subtract more than one day (1500 min = 25 hrs)"‿{𝕊: "04:32" t.Expect g.ToString (g.Create 5‿32) g.Subtract 1500}
  "Subtract minutes > subtract more than two days"‿{𝕊: "00:20" t.Expect g.ToString (g.Create 2‿20) g.Subtract 3000}
  "Compare two clocks for equality > clocks with same time"‿{𝕊: 1 t.Expect (g.Create 15‿37) ≡ g.Create 15‿37}
  "Compare two clocks for equality > clocks a minute apart"‿{𝕊: 0 t.Expect (g.Create 15‿36) ≡ g.Create 15‿37}
  "Compare two clocks for equality > clocks an hour apart"‿{𝕊: 0 t.Expect (g.Create 14‿37) ≡ g.Create 15‿37}
  "Compare two clocks for equality > clocks with hour overflow"‿{𝕊: 1 t.Expect (g.Create 10‿37) ≡ g.Create 34‿37}
  "Compare two clocks for equality > clocks with hour overflow by several days"‿{𝕊: 1 t.Expect (g.Create 3‿11) ≡ g.Create 99‿11}
  "Compare two clocks for equality > clocks with negative hour"‿{𝕊: 1 t.Expect (g.Create 22‿40) ≡ g.Create ¯2‿40}
  "Compare two clocks for equality > clocks with negative hour that wraps"‿{𝕊: 1 t.Expect (g.Create 17‿3) ≡ g.Create ¯31‿3}
  "Compare two clocks for equality > clocks with negative hour that wraps multiple times"‿{𝕊: 1 t.Expect (g.Create 13‿49) ≡ g.Create ¯83‿49}
  "Compare two clocks for equality > clocks with minute overflow"‿{𝕊: 1 t.Expect (g.Create 0‿1) ≡ g.Create 0‿1441}
  "Compare two clocks for equality > clocks with minute overflow by several days"‿{𝕊: 1 t.Expect (g.Create 2‿2) ≡ g.Create 2‿4322}
  "Compare two clocks for equality > clocks with negative minute"‿{𝕊: 1 t.Expect (g.Create 2‿40) ≡ g.Create 3‿¯20}
  "Compare two clocks for equality > clocks with negative minute that wraps"‿{𝕊: 1 t.Expect (g.Create 4‿10) ≡ g.Create 5‿¯1490}
  "Compare two clocks for equality > clocks with negative minute that wraps multiple times"‿{𝕊: 1 t.Expect (g.Create 6‿15) ≡ g.Create 6‿¯4305}
  "Compare two clocks for equality > clocks with negative hours and minutes"‿{𝕊: 1 t.Expect (g.Create 7‿32) ≡ g.Create ¯12‿¯268}
  "Compare two clocks for equality > clocks with negative hours and minutes that wrap"‿{𝕊: 1 t.Expect (g.Create 18‿7) ≡ g.Create ¯54‿¯11513}
  "Compare two clocks for equality > full clock and zeroed clock"‿{𝕊: 1 t.Expect (g.Create 24‿0) ≡ g.Create 0‿0}
⟩
