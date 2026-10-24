t ← •Import "../lib/test.bqn"
g ← •Import "../game-of-life.bqn"

bigger ← >⟨
  1‿1‿0‿1‿1‿0‿0‿0, 1‿0‿1‿1‿0‿0‿0‿0, 1‿1‿1‿0‿0‿1‿1‿1, 0‿0‿0‿0‿0‿1‿1‿0
  1‿0‿0‿0‿1‿1‿0‿0, 1‿1‿0‿0‿0‿1‿1‿1, 0‿0‿1‿0‿1‿0‿0‿1, 1‿0‿0‿0‿0‿0‿1‿1
⟩
biggerNext ← >⟨
  1‿1‿0‿1‿1‿0‿0‿0, 0‿0‿0‿0‿0‿1‿1‿0, 1‿0‿1‿1‿1‿1‿0‿1, 1‿0‿0‿0‿0‿0‿0‿1
  1‿1‿0‿0‿1‿0‿0‿1, 1‿1‿0‿1‿0‿0‿0‿1, 1‿0‿0‿0‿0‿0‿0‿0, 0‿0‿0‿0‿0‿0‿1‿1
⟩

t.Run ⟨
  "empty matrix"‿{𝕊: (0‿0⥊0) t.Expect g.Tick 0‿0⥊0}
  "live cells with zero live neighbors die"‿{𝕊: (>⟨0‿0‿0, 0‿0‿0, 0‿0‿0⟩) t.Expect g.Tick >⟨0‿0‿0, 0‿1‿0, 0‿0‿0⟩}
  "live cells with only one live neighbor die"‿{𝕊: (>⟨0‿0‿0, 0‿0‿0, 0‿0‿0⟩) t.Expect g.Tick >⟨0‿0‿0, 0‿1‿0, 0‿1‿0⟩}
  "live cells with two live neighbors stay alive"‿{𝕊: (>⟨0‿0‿0, 1‿0‿1, 0‿0‿0⟩) t.Expect g.Tick >⟨1‿0‿1, 1‿0‿1, 1‿0‿1⟩}
  "live cells with three live neighbors stay alive"‿{𝕊: (>⟨0‿0‿0, 1‿0‿0, 1‿1‿0⟩) t.Expect g.Tick >⟨0‿1‿0, 1‿0‿0, 1‿1‿0⟩}
  "dead cells with three live neighbors become alive"‿{𝕊: (>⟨0‿0‿0, 1‿1‿0, 0‿0‿0⟩) t.Expect g.Tick >⟨1‿1‿0, 0‿0‿0, 1‿0‿0⟩}
  "live cells with four or more neighbors die"‿{𝕊: (>⟨1‿0‿1, 0‿0‿0, 1‿0‿1⟩) t.Expect g.Tick >⟨1‿1‿1, 1‿1‿1, 1‿1‿1⟩}
  "bigger matrix"‿{𝕊: biggerNext t.Expect g.Tick bigger}
⟩
