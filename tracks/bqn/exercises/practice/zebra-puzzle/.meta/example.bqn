# DrinksWater @ → the nationality of the resident who drinks water
# OwnsZebra @ → the nationality of the resident who owns the zebra
#
# Each attribute is a permutation from its values to houses 0–4. The solver adds one attribute
# at a time, keeping only the combinations that satisfy every clue mentioning those attributes.
red‿green‿ivory‿yellow‿blue ← ↕5
english‿spaniard‿ukrainian‿norwegian‿japanese ← ↕5
coffee‿tea‿milk‿orangeJuice‿water ← ↕5
oldGold‿kools‿chesterfield‿luckyStrike‿parliament ← ↕5
dog‿snails‿fox‿horse‿zebra ← ↕5
nationalities ← "Englishman"‿"Spaniard"‿"Ukrainian"‿"Norwegian"‿"Japanese"

perms ← (∧´∘∊)¨⊸/ ⥊↕5⥊5
Adj ← 1=|∘-
_add ← {𝔽¨⊸/ ⥊ 𝕩 ∾⟜<⌜ perms}

s ← ⋈⟨⟩
s ↩ {⟨c⟩: (green⊑c) = 1+ivory⊑c} _add s
s ↩ {c‿n: ∧´⟨(english⊑n)=red⊑c, 0=norwegian⊑n, (norwegian⊑n) Adj blue⊑c⟩} _add s
s ↩ {c‿n‿d: ∧´⟨(coffee⊑d)=green⊑c, (ukrainian⊑n)=tea⊑d, 2=milk⊑d⟩} _add s
s ↩ {c‿n‿d‿m: ∧´⟨(kools⊑m)=yellow⊑c, (luckyStrike⊑m)=orangeJuice⊑d, (japanese⊑n)=parliament⊑m⟩} _add s
s ↩ {c‿n‿d‿m‿p: ∧´⟨(spaniard⊑n)=dog⊑p, (oldGold⊑m)=snails⊑p, (chesterfield⊑m) Adj fox⊑p, (kools⊑m) Adj horse⊑p⟩} _add s
c‿n‿d‿m‿p ← ⊑s

Owner ← {nationalities ⊑˜ ⊑n⊐<𝕩}

DrinksWater ⇐ {𝕊: Owner water⊑d}
OwnsZebra ⇐ {𝕊: Owner zebra⊑p}
