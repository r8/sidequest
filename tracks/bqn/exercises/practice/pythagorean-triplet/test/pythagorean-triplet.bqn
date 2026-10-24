t ← •Import "../lib/test.bqn"
g ← •Import "../pythagorean-triplet.bqn"

t.Run ⟨
  "triplets whose sum is 12"‿{𝕊: ⟨3‿4‿5⟩ t.Expect g.TripletsWithSum 12}
  "triplets whose sum is 108"‿{𝕊: ⟨27‿36‿45⟩ t.Expect g.TripletsWithSum 108}
  "triplets whose sum is 1000"‿{𝕊: ⟨200‿375‿425⟩ t.Expect g.TripletsWithSum 1000}
  "no matching triplets for 1001"‿{𝕊: ⟨⟩ t.Expect g.TripletsWithSum 1001}
  "returns all matching triplets"‿{𝕊: ⟨9‿40‿41, 15‿36‿39⟩ t.Expect g.TripletsWithSum 90}
  "several matching triplets"‿{𝕊: ⟨40‿399‿401, 56‿390‿394, 105‿360‿375, 120‿350‿370, 140‿336‿364, 168‿315‿357, 210‿280‿350, 240‿252‿348⟩ t.Expect g.TripletsWithSum 840}
  "triplets for large number"‿{𝕊: ⟨1200‿14375‿14425, 1875‿14000‿14125, 5000‿12000‿13000, 6000‿11250‿12750, 7500‿10000‿12500⟩ t.Expect g.TripletsWithSum 30000}
⟩
