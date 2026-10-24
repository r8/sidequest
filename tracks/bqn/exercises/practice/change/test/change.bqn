t ← •Import "../lib/test.bqn"
g ← •Import "../change.bqn"

t.Run ⟨
  "change for 1 cent"‿{𝕊: ⟨1⟩ t.Expect ⟨1, 5, 10, 25⟩ g.FindFewestCoins 1}
  "single coin change"‿{𝕊: ⟨25⟩ t.Expect ⟨1, 5, 10, 25, 100⟩ g.FindFewestCoins 25}
  "multiple coin change"‿{𝕊: ⟨5, 10⟩ t.Expect ⟨1, 5, 10, 25, 100⟩ g.FindFewestCoins 15}
  "change with Lilliputian Coins"‿{𝕊: ⟨4, 4, 15⟩ t.Expect ⟨1, 4, 15, 20, 50⟩ g.FindFewestCoins 23}
  "change with Lower Elbonia Coins"‿{𝕊: ⟨21, 21, 21⟩ t.Expect ⟨1, 5, 10, 21, 25⟩ g.FindFewestCoins 63}
  "large target values"‿{𝕊: ⟨2, 2, 5, 20, 20, 50, 100, 100, 100, 100, 100, 100, 100, 100, 100⟩ t.Expect ⟨1, 2, 5, 10, 20, 50, 100⟩ g.FindFewestCoins 999}
  "possible change without unit coins available"‿{𝕊: ⟨2, 2, 2, 5, 10⟩ t.Expect ⟨2, 5, 10, 20, 50⟩ g.FindFewestCoins 21}
  "another possible change without unit coins available"‿{𝕊: ⟨4, 4, 4, 5, 5, 5⟩ t.Expect ⟨4, 5⟩ g.FindFewestCoins 27}
  "a greedy approach is not optimal"‿{𝕊: ⟨10, 10⟩ t.Expect ⟨1, 10, 11⟩ g.FindFewestCoins 20}
  "no coins make 0 change"‿{𝕊: ⟨⟩ t.Expect ⟨1, 5, 10, 21, 25⟩ g.FindFewestCoins 0}
  "error testing for change smaller than the smallest of coins"‿{𝕊: {𝕊: ⟨5, 10⟩ g.FindFewestCoins 3} t._throws "can't make target with given coins"}
  "error if no combination can add up to target"‿{𝕊: {𝕊: ⟨5, 10⟩ g.FindFewestCoins 94} t._throws "can't make target with given coins"}
  "cannot find negative change values"‿{𝕊: {𝕊: ⟨1, 2, 5⟩ g.FindFewestCoins ¯5} t._throws "target can't be negative"}
⟩
