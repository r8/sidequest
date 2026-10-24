t ← •Import "../lib/test.bqn"
g ← •Import "../flower-field.bqn"

t.Run ⟨
  "no rows"‿{𝕊: ⟨⟩ t.Expect g.Annotate ⟨⟩}
  "no columns"‿{𝕊: ⟨""⟩ t.Expect g.Annotate ⟨""⟩}
  "no flowers"‿{𝕊: "   "‿"   "‿"   " t.Expect g.Annotate "   "‿"   "‿"   "}
  "garden full of flowers"‿{𝕊: "***"‿"***"‿"***" t.Expect g.Annotate "***"‿"***"‿"***"}
  "flower surrounded by spaces"‿{𝕊: "111"‿"1*1"‿"111" t.Expect g.Annotate "   "‿" * "‿"   "}
  "space surrounded by flowers"‿{𝕊: "***"‿"*8*"‿"***" t.Expect g.Annotate "***"‿"* *"‿"***"}
  "horizontal line"‿{𝕊: ⟨"1*2*1"⟩ t.Expect g.Annotate ⟨" * * "⟩}
  "horizontal line, flowers at edges"‿{𝕊: ⟨"*1 1*"⟩ t.Expect g.Annotate ⟨"*   *"⟩}
  "vertical line"‿{𝕊: "1"‿"*"‿"2"‿"*"‿"1" t.Expect g.Annotate " "‿"*"‿" "‿"*"‿" "}
  "vertical line, flowers at edges"‿{𝕊: "*"‿"1"‿" "‿"1"‿"*" t.Expect g.Annotate "*"‿" "‿" "‿" "‿"*"}
  "cross"‿{𝕊: " 2*2 "‿"25*52"‿"*****"‿"25*52"‿" 2*2 " t.Expect g.Annotate "  *  "‿"  *  "‿"*****"‿"  *  "‿"  *  "}
  "large garden"‿{𝕊: "1*22*1"‿"12*322"‿" 123*2"‿"112*4*"‿"1*22*2"‿"111111" t.Expect g.Annotate " *  * "‿"  *   "‿"    * "‿"   * *"‿" *  * "‿"      "}
  "multiple adjacent flowers"‿{𝕊: ⟨"1**1"⟩ t.Expect g.Annotate ⟨" ** "⟩}
⟩
