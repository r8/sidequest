t ← •Import "../lib/test.bqn"
g ← •Import "../space-age.bqn"

t.Run ⟨
  "age on Earth"‿{𝕊: 31.69 t.Approx "Earth" g.Age 1000000000}
  "age on Mercury"‿{𝕊: 280.88 t.Approx "Mercury" g.Age 2134835688}
  "age on Venus"‿{𝕊: 9.78 t.Approx "Venus" g.Age 189839836}
  "age on Mars"‿{𝕊: 35.88 t.Approx "Mars" g.Age 2129871239}
  "age on Jupiter"‿{𝕊: 2.41 t.Approx "Jupiter" g.Age 901876382}
  "age on Saturn"‿{𝕊: 2.15 t.Approx "Saturn" g.Age 2000000000}
  "age on Uranus"‿{𝕊: 0.46 t.Approx "Uranus" g.Age 1210123456}
  "age on Neptune"‿{𝕊: 0.35 t.Approx "Neptune" g.Age 1821023456}
  "invalid planet causes error"‿{𝕊: {𝕊: "Sun" g.Age 680804807} t._throws "not a planet"}
⟩
