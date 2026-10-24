t ← •Import "../lib/test.bqn"
g ← •Import "../allergies.bqn"

t.Run ⟨
  "testing for eggs allergy > not allergic to anything"‿{𝕊: 0 t.Expect 0 g.AllergicTo "eggs"}
  "testing for eggs allergy > allergic only to eggs"‿{𝕊: 1 t.Expect 1 g.AllergicTo "eggs"}
  "testing for eggs allergy > allergic to eggs and something else"‿{𝕊: 1 t.Expect 3 g.AllergicTo "eggs"}
  "testing for eggs allergy > allergic to something, but not eggs"‿{𝕊: 0 t.Expect 2 g.AllergicTo "eggs"}
  "testing for eggs allergy > allergic to everything"‿{𝕊: 1 t.Expect 255 g.AllergicTo "eggs"}
  "testing for peanuts allergy > not allergic to anything"‿{𝕊: 0 t.Expect 0 g.AllergicTo "peanuts"}
  "testing for peanuts allergy > allergic only to peanuts"‿{𝕊: 1 t.Expect 2 g.AllergicTo "peanuts"}
  "testing for peanuts allergy > allergic to peanuts and something else"‿{𝕊: 1 t.Expect 7 g.AllergicTo "peanuts"}
  "testing for peanuts allergy > allergic to something, but not peanuts"‿{𝕊: 0 t.Expect 5 g.AllergicTo "peanuts"}
  "testing for peanuts allergy > allergic to everything"‿{𝕊: 1 t.Expect 255 g.AllergicTo "peanuts"}
  "testing for shellfish allergy > not allergic to anything"‿{𝕊: 0 t.Expect 0 g.AllergicTo "shellfish"}
  "testing for shellfish allergy > allergic only to shellfish"‿{𝕊: 1 t.Expect 4 g.AllergicTo "shellfish"}
  "testing for shellfish allergy > allergic to shellfish and something else"‿{𝕊: 1 t.Expect 14 g.AllergicTo "shellfish"}
  "testing for shellfish allergy > allergic to something, but not shellfish"‿{𝕊: 0 t.Expect 10 g.AllergicTo "shellfish"}
  "testing for shellfish allergy > allergic to everything"‿{𝕊: 1 t.Expect 255 g.AllergicTo "shellfish"}
  "testing for strawberries allergy > not allergic to anything"‿{𝕊: 0 t.Expect 0 g.AllergicTo "strawberries"}
  "testing for strawberries allergy > allergic only to strawberries"‿{𝕊: 1 t.Expect 8 g.AllergicTo "strawberries"}
  "testing for strawberries allergy > allergic to strawberries and something else"‿{𝕊: 1 t.Expect 28 g.AllergicTo "strawberries"}
  "testing for strawberries allergy > allergic to something, but not strawberries"‿{𝕊: 0 t.Expect 20 g.AllergicTo "strawberries"}
  "testing for strawberries allergy > allergic to everything"‿{𝕊: 1 t.Expect 255 g.AllergicTo "strawberries"}
  "testing for tomatoes allergy > not allergic to anything"‿{𝕊: 0 t.Expect 0 g.AllergicTo "tomatoes"}
  "testing for tomatoes allergy > allergic only to tomatoes"‿{𝕊: 1 t.Expect 16 g.AllergicTo "tomatoes"}
  "testing for tomatoes allergy > allergic to tomatoes and something else"‿{𝕊: 1 t.Expect 56 g.AllergicTo "tomatoes"}
  "testing for tomatoes allergy > allergic to something, but not tomatoes"‿{𝕊: 0 t.Expect 40 g.AllergicTo "tomatoes"}
  "testing for tomatoes allergy > allergic to everything"‿{𝕊: 1 t.Expect 255 g.AllergicTo "tomatoes"}
  "testing for chocolate allergy > not allergic to anything"‿{𝕊: 0 t.Expect 0 g.AllergicTo "chocolate"}
  "testing for chocolate allergy > allergic only to chocolate"‿{𝕊: 1 t.Expect 32 g.AllergicTo "chocolate"}
  "testing for chocolate allergy > allergic to chocolate and something else"‿{𝕊: 1 t.Expect 112 g.AllergicTo "chocolate"}
  "testing for chocolate allergy > allergic to something, but not chocolate"‿{𝕊: 0 t.Expect 80 g.AllergicTo "chocolate"}
  "testing for chocolate allergy > allergic to everything"‿{𝕊: 1 t.Expect 255 g.AllergicTo "chocolate"}
  "testing for pollen allergy > not allergic to anything"‿{𝕊: 0 t.Expect 0 g.AllergicTo "pollen"}
  "testing for pollen allergy > allergic only to pollen"‿{𝕊: 1 t.Expect 64 g.AllergicTo "pollen"}
  "testing for pollen allergy > allergic to pollen and something else"‿{𝕊: 1 t.Expect 224 g.AllergicTo "pollen"}
  "testing for pollen allergy > allergic to something, but not pollen"‿{𝕊: 0 t.Expect 160 g.AllergicTo "pollen"}
  "testing for pollen allergy > allergic to everything"‿{𝕊: 1 t.Expect 255 g.AllergicTo "pollen"}
  "testing for cats allergy > not allergic to anything"‿{𝕊: 0 t.Expect 0 g.AllergicTo "cats"}
  "testing for cats allergy > allergic only to cats"‿{𝕊: 1 t.Expect 128 g.AllergicTo "cats"}
  "testing for cats allergy > allergic to cats and something else"‿{𝕊: 1 t.Expect 192 g.AllergicTo "cats"}
  "testing for cats allergy > allergic to something, but not cats"‿{𝕊: 0 t.Expect 64 g.AllergicTo "cats"}
  "testing for cats allergy > allergic to everything"‿{𝕊: 1 t.Expect 255 g.AllergicTo "cats"}
  "list when: > no allergies"‿{𝕊: ⟨⟩ t.Expect g.List 0}
  "list when: > just eggs"‿{𝕊: ⟨"eggs"⟩ t.Expect g.List 1}
  "list when: > just peanuts"‿{𝕊: ⟨"peanuts"⟩ t.Expect g.List 2}
  "list when: > just strawberries"‿{𝕊: ⟨"strawberries"⟩ t.Expect g.List 8}
  "list when: > eggs and peanuts"‿{𝕊: "eggs"‿"peanuts" t.Expect g.List 3}
  "list when: > more than eggs but not peanuts"‿{𝕊: "eggs"‿"shellfish" t.Expect g.List 5}
  "list when: > lots of stuff"‿{𝕊: "strawberries"‿"tomatoes"‿"chocolate"‿"pollen"‿"cats" t.Expect g.List 248}
  "list when: > everything"‿{𝕊: "eggs"‿"peanuts"‿"shellfish"‿"strawberries"‿"tomatoes"‿"chocolate"‿"pollen"‿"cats" t.Expect g.List 255}
  "list when: > no allergen score parts"‿{𝕊: "eggs"‿"shellfish"‿"strawberries"‿"tomatoes"‿"chocolate"‿"pollen"‿"cats" t.Expect g.List 509}
  "list when: > no allergen score parts without highest valid score"‿{𝕊: ⟨"eggs"⟩ t.Expect g.List 257}
⟩
