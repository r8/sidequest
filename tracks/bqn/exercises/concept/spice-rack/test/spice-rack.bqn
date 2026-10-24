t ← •Import "../lib/test.bqn"
g ← •Import "../spice-rack.bqn"

rack ← "salt"‿"pepper"‿"cumin"‿"salt"‿"paprika"‿"pepper"

t.Run ⟨
  "1. spices that are on the rack"‿{𝕊: 2‿4 t.Expect rack g.Slots "cumin"‿"paprika"}
  "1. a spice with two jars is found at the first"‿{𝕊: ⟨0⟩ t.Expect rack g.Slots ⟨"salt"⟩}
  "1. a spice that is not on the rack"‿{𝕊: 1‿6 t.Expect rack g.Slots "pepper"‿"saffron"}
  "1. nothing to look for"‿{𝕊: ⟨⟩ t.Expect rack g.Slots ⟨⟩}
  "2. some spices are missing"‿{𝕊: "dill"‿"saffron" t.Expect rack g.Missing "dill"‿"salt"‿"saffron"}
  "2. everything is on the rack"‿{𝕊: ⟨⟩ t.Expect rack g.Missing "pepper"‿"cumin"}
  "2. an empty rack"‿{𝕊: "salt"‿"dill" t.Expect ⟨⟩ g.Missing "salt"‿"dill"}
  "2. a missing spice the recipe uses twice"‿{𝕊: "mace"‿"mace" t.Expect rack g.Missing "mace"‿"salt"‿"mace"}
  "3. one jar of each spice"‿{𝕊: 2‿4 t.Expect rack g.JarsFor "cumin"‿"paprika"}
  "3. the second step of salt takes the second jar"‿{𝕊: 0‿3 t.Expect rack g.JarsFor "salt"‿"salt"}
  "3. the jars run out"‿{𝕊: 0‿3‿6‿2 t.Expect rack g.JarsFor "salt"‿"salt"‿"salt"‿"cumin"}
  "3. a spice that is not on the rack"‿{𝕊: 6‿1 t.Expect rack g.JarsFor "mace"‿"pepper"}
  "4. repeats are removed"‿{𝕊: "salt"‿"dill"‿"cumin" t.Expect g.Restock "salt"‿"dill"‿"salt"‿"cumin"‿"dill"}
  "4. no repeats"‿{𝕊: "mace"‿"dill" t.Expect g.Restock "mace"‿"dill"}
  "4. one spice many times"‿{𝕊: ⟨"salt"⟩ t.Expect g.Restock "salt"‿"salt"‿"salt"}
  "4. nothing ran out"‿{𝕊: ⟨⟩ t.Expect g.Restock ⟨⟩}
  "5. spare jars of two spices"‿{𝕊: "salt"‿"pepper" t.Expect g.Spares rack}
  "5. three jars of salt leave two spares"‿{𝕊: "salt"‿"salt" t.Expect g.Spares "salt"‿"dill"‿"salt"‿"cumin"‿"salt"}
  "5. no spares"‿{𝕊: ⟨⟩ t.Expect g.Spares "mace"‿"dill"‿"cumin"}
⟩
