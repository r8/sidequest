t ← •Import "../lib/test.bqn"
g ← •Import "../robot-simulator.bqn"

t.Run ⟨
  "Create robot > at origin facing north"‿{𝕊: 0‿0‿"north" t.Expect g.Create 0‿0‿"north"}
  "Create robot > at negative position facing south"‿{𝕊: ¯1‿¯1‿"south" t.Expect g.Create ¯1‿¯1‿"south"}
  "Rotating clockwise > changes north to east"‿{𝕊: 0‿0‿"east" t.Expect (0‿0‿"north") g.Move "R"}
  "Rotating clockwise > changes east to south"‿{𝕊: 0‿0‿"south" t.Expect (0‿0‿"east") g.Move "R"}
  "Rotating clockwise > changes south to west"‿{𝕊: 0‿0‿"west" t.Expect (0‿0‿"south") g.Move "R"}
  "Rotating clockwise > changes west to north"‿{𝕊: 0‿0‿"north" t.Expect (0‿0‿"west") g.Move "R"}
  "Rotating counter-clockwise > changes north to west"‿{𝕊: 0‿0‿"west" t.Expect (0‿0‿"north") g.Move "L"}
  "Rotating counter-clockwise > changes west to south"‿{𝕊: 0‿0‿"south" t.Expect (0‿0‿"west") g.Move "L"}
  "Rotating counter-clockwise > changes south to east"‿{𝕊: 0‿0‿"east" t.Expect (0‿0‿"south") g.Move "L"}
  "Rotating counter-clockwise > changes east to north"‿{𝕊: 0‿0‿"north" t.Expect (0‿0‿"east") g.Move "L"}
  "Moving forward one > facing north increments Y"‿{𝕊: 0‿1‿"north" t.Expect (0‿0‿"north") g.Move "A"}
  "Moving forward one > facing south decrements Y"‿{𝕊: 0‿¯1‿"south" t.Expect (0‿0‿"south") g.Move "A"}
  "Moving forward one > facing east increments X"‿{𝕊: 1‿0‿"east" t.Expect (0‿0‿"east") g.Move "A"}
  "Moving forward one > facing west decrements X"‿{𝕊: ¯1‿0‿"west" t.Expect (0‿0‿"west") g.Move "A"}
  "Follow series of instructions > moving east and north from README"‿{𝕊: 9‿4‿"west" t.Expect (7‿3‿"north") g.Move "RAALAL"}
  "Follow series of instructions > moving west and north"‿{𝕊: ¯4‿1‿"west" t.Expect (0‿0‿"north") g.Move "LAAARALA"}
  "Follow series of instructions > moving west and south"‿{𝕊: ¯3‿¯8‿"south" t.Expect (2‿¯7‿"east") g.Move "RRAAAAALA"}
  "Follow series of instructions > moving east and north"‿{𝕊: 11‿5‿"north" t.Expect (8‿4‿"south") g.Move "LAAARRRALLLL"}
⟩
