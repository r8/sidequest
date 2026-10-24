t ← •Import "../lib/test.bqn"
g ← •Import "../dnd-character.bqn"

# The random cases check many samples, listing any that break the rule (expected: none).
scores ← 3+↕16
Abilities ← {⟨𝕩.strength, 𝕩.dexterity, 𝕩.constitution, 𝕩.intelligence, 𝕩.wisdom, 𝕩.charisma⟩}

t.Run ⟨
  "ability modifier > ability modifier for score 3 is -4"‿{𝕊: ¯4 t.Expect g.Modifier 3}
  "ability modifier > ability modifier for score 4 is -3"‿{𝕊: ¯3 t.Expect g.Modifier 4}
  "ability modifier > ability modifier for score 5 is -3"‿{𝕊: ¯3 t.Expect g.Modifier 5}
  "ability modifier > ability modifier for score 6 is -2"‿{𝕊: ¯2 t.Expect g.Modifier 6}
  "ability modifier > ability modifier for score 7 is -2"‿{𝕊: ¯2 t.Expect g.Modifier 7}
  "ability modifier > ability modifier for score 8 is -1"‿{𝕊: ¯1 t.Expect g.Modifier 8}
  "ability modifier > ability modifier for score 9 is -1"‿{𝕊: ¯1 t.Expect g.Modifier 9}
  "ability modifier > ability modifier for score 10 is 0"‿{𝕊: 0 t.Expect g.Modifier 10}
  "ability modifier > ability modifier for score 11 is 0"‿{𝕊: 0 t.Expect g.Modifier 11}
  "ability modifier > ability modifier for score 12 is +1"‿{𝕊: 1 t.Expect g.Modifier 12}
  "ability modifier > ability modifier for score 13 is +1"‿{𝕊: 1 t.Expect g.Modifier 13}
  "ability modifier > ability modifier for score 14 is +2"‿{𝕊: 2 t.Expect g.Modifier 14}
  "ability modifier > ability modifier for score 15 is +2"‿{𝕊: 2 t.Expect g.Modifier 15}
  "ability modifier > ability modifier for score 16 is +3"‿{𝕊: 3 t.Expect g.Modifier 16}
  "ability modifier > ability modifier for score 17 is +3"‿{𝕊: 3 t.Expect g.Modifier 17}
  "ability modifier > ability modifier for score 18 is +4"‿{𝕊: 4 t.Expect g.Modifier 18}
  "random ability is within range"‿{𝕊:
    a ← g.Ability¨ 1000⥊@
    ⟨⟩ t.Expect (¬a∊scores)/a
  }
  "random character is valid"‿{𝕊:
    cs ← g.Character¨ 200⥊@
    ⟨⟩ t.Expect (¬∧´∘∊⟜scores¨)⊸/ Abilities¨ cs
    ⟨⟩ t.Expect {h‿c: h ≠ 10 + g.Modifier c}¨⊸/ {𝕩.hitpoints‿𝕩.constitution}¨ cs
  }
  "each ability is only calculated once"‿{𝕊:
    cs ← g.Character¨ 200⥊@
    1 t.Expect ∧´ {(Abilities 𝕩) ≡ Abilities 𝕩}¨ cs
  }
⟩
