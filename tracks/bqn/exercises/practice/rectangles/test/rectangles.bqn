t ← •Import "../lib/test.bqn"
g ← •Import "../rectangles.bqn"

t.Run ⟨
  "no rows"‿{𝕊: 0 t.Expect g.Rectangles ⟨⟩}
  "no columns"‿{𝕊: 0 t.Expect g.Rectangles ⟨""⟩}
  "no rectangles"‿{𝕊: 0 t.Expect g.Rectangles ⟨" "⟩}
  "one rectangle"‿{𝕊: 1 t.Expect g.Rectangles "+-+"‿"| |"‿"+-+"}
  "two rectangles without shared parts"‿{𝕊: 2 t.Expect g.Rectangles "  +-+"‿"  | |"‿"+-+-+"‿"| |  "‿"+-+  "}
  "five rectangles with shared parts"‿{𝕊: 5 t.Expect g.Rectangles "  +-+"‿"  | |"‿"+-+-+"‿"| | |"‿"+-+-+"}
  "rectangle of height 1 is counted"‿{𝕊: 1 t.Expect g.Rectangles "+--+"‿"+--+"}
  "rectangle of width 1 is counted"‿{𝕊: 1 t.Expect g.Rectangles "++"‿"||"‿"++"}
  "1x1 square is counted"‿{𝕊: 1 t.Expect g.Rectangles "++"‿"++"}
  "only complete rectangles are counted"‿{𝕊: 1 t.Expect g.Rectangles "  +-+"‿"    |"‿"+-+-+"‿"| | -"‿"+-+-+"}
  "rectangles can be of different sizes"‿{𝕊: 3 t.Expect g.Rectangles "+------+----+"‿"|      |    |"‿"+---+--+    |"‿"|   |       |"‿"+---+-------+"}
  "corner is required for a rectangle to be complete"‿{𝕊: 2 t.Expect g.Rectangles "+------+----+"‿"|      |    |"‿"+------+    |"‿"|   |       |"‿"+---+-------+"}
  "large input with many rectangles"‿{𝕊:
    diagram ← ⟨
      "+---+--+----+"
      "|   +--+----+"
      "+---+--+    |"
      "|   +--+----+"
      "+---+--+--+-+"
      "+---+--+--+-+"
      "+------+  | |"
      "          +-+"
    ⟩
    60 t.Expect g.Rectangles diagram
  }
  "rectangles must have four sides"‿{𝕊: 5 t.Expect g.Rectangles "+-+ +-+"‿"| | | |"‿"+-+-+-+"‿"  | |  "‿"+-+-+-+"‿"| | | |"‿"+-+ +-+"}
⟩
