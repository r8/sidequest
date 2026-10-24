t ← •Import "../lib/test.bqn"
g ← •Import "../triangle.bqn"

t.Run ⟨
  "equilateral triangle > all sides are equal"‿{𝕊: 1 t.Expect g.Equilateral 2‿2‿2}
  "equilateral triangle > any side is unequal"‿{𝕊: 0 t.Expect g.Equilateral 2‿3‿2}
  "equilateral triangle > no sides are equal"‿{𝕊: 0 t.Expect g.Equilateral 5‿4‿6}
  "equilateral triangle > all zero sides is not a triangle"‿{𝕊: 0 t.Expect g.Equilateral 0‿0‿0}
  "equilateral triangle > sides may be floats"‿{𝕊: 1 t.Expect g.Equilateral 0.5‿0.5‿0.5}
  "isosceles triangle > last two sides are equal"‿{𝕊: 1 t.Expect g.Isosceles 3‿4‿4}
  "isosceles triangle > first two sides are equal"‿{𝕊: 1 t.Expect g.Isosceles 4‿4‿3}
  "isosceles triangle > first and last sides are equal"‿{𝕊: 1 t.Expect g.Isosceles 4‿3‿4}
  "isosceles triangle > equilateral triangles are also isosceles"‿{𝕊: 1 t.Expect g.Isosceles 4‿4‿4}
  "isosceles triangle > no sides are equal"‿{𝕊: 0 t.Expect g.Isosceles 2‿3‿4}
  "isosceles triangle > first triangle inequality violation"‿{𝕊: 0 t.Expect g.Isosceles 1‿1‿3}
  "isosceles triangle > second triangle inequality violation"‿{𝕊: 0 t.Expect g.Isosceles 1‿3‿1}
  "isosceles triangle > third triangle inequality violation"‿{𝕊: 0 t.Expect g.Isosceles 3‿1‿1}
  "isosceles triangle > sides may be floats"‿{𝕊: 1 t.Expect g.Isosceles 0.5‿0.4‿0.5}
  "scalene triangle > no sides are equal"‿{𝕊: 1 t.Expect g.Scalene 5‿4‿6}
  "scalene triangle > all sides are equal"‿{𝕊: 0 t.Expect g.Scalene 4‿4‿4}
  "scalene triangle > first and second sides are equal"‿{𝕊: 0 t.Expect g.Scalene 4‿4‿3}
  "scalene triangle > first and third sides are equal"‿{𝕊: 0 t.Expect g.Scalene 3‿4‿3}
  "scalene triangle > second and third sides are equal"‿{𝕊: 0 t.Expect g.Scalene 4‿3‿3}
  "scalene triangle > may not violate triangle inequality"‿{𝕊: 0 t.Expect g.Scalene 7‿3‿2}
  "scalene triangle > sides may be floats"‿{𝕊: 1 t.Expect g.Scalene 0.5‿0.4‿0.6}
⟩
