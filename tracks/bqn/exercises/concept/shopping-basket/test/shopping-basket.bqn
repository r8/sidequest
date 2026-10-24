t ← •Import "../lib/test.bqn"
g ← •Import "../shopping-basket.bqn"

t.Run ⟨
  "1. three items"‿{𝕊: 769 t.Expect g.Total 250‿120‿399}
  "1. one item"‿{𝕊: 99 t.Expect g.Total ⟨99⟩}
  "1. an empty basket"‿{𝕊: 0 t.Expect g.Total ⟨⟩}
  "2. the last item is dearest"‿{𝕊: 399 t.Expect g.MostExpensive 250‿120‿399}
  "2. the first item is dearest"‿{𝕊: 800 t.Expect g.MostExpensive 800‿120‿399}
  "2. a single item"‿{𝕊: 99 t.Expect g.MostExpensive ⟨99⟩}
  "3. one item is sold out"‿{𝕊: 0 t.Expect g.AllInStock 4‿0‿12}
  "3. everything in stock"‿{𝕊: 1 t.Expect g.AllInStock 4‿1‿12}
  "3. nothing in stock"‿{𝕊: 0 t.Expect g.AllInStock 0‿0}
  "3. an empty basket needs nothing"‿{𝕊: 1 t.Expect g.AllInStock ⟨⟩}
  "4. two halvings"‿{𝕊: 100 t.Expect 400 g.Discounted 0.5‿0.5}
  "4. one discount"‿{𝕊: 300 t.Expect 400 g.Discounted ⟨0.75⟩}
  "4. no discounts"‿{𝕊: 400 t.Expect 400 g.Discounted ⟨⟩}
  "5. three items"‿{𝕊: "apples, bread, milk" t.Expect g.PackingList "apples"‿"bread"‿"milk"}
  "5. two items"‿{𝕊: "tea, honey" t.Expect g.PackingList "tea"‿"honey"}
  "5. one item"‿{𝕊: "eggs" t.Expect g.PackingList ⟨"eggs"⟩}
  "6. three baskets"‿{𝕊: 370‿0‿399 t.Expect g.BasketTotals ⟨250‿120, ⟨⟩, ⟨399⟩⟩}
  "6. one basket"‿{𝕊: ⟨10⟩ t.Expect g.BasketTotals ⟨1‿2‿3‿4⟩}
  "6. no baskets"‿{𝕊: ⟨⟩ t.Expect g.BasketTotals ⟨⟩}
⟩
