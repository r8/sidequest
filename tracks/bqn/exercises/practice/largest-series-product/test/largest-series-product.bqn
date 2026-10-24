t ← •Import "../lib/test.bqn"
g ← •Import "../largest-series-product.bqn"

t.Run ⟨
  "finds the largest product if span equals length"‿{𝕊: 18 t.Expect 2 g.LargestProduct "29"}
  "can find the largest product of 2 with numbers in order"‿{𝕊: 72 t.Expect 2 g.LargestProduct "0123456789"}
  "can find the largest product of 2"‿{𝕊: 48 t.Expect 2 g.LargestProduct "576802143"}
  "can find the largest product of 3 with numbers in order"‿{𝕊: 504 t.Expect 3 g.LargestProduct "0123456789"}
  "can find the largest product of 3"‿{𝕊: 270 t.Expect 3 g.LargestProduct "1027839564"}
  "can find the largest product of 5 with numbers in order"‿{𝕊: 15120 t.Expect 5 g.LargestProduct "0123456789"}
  "can get the largest product of a big number"‿{𝕊: 23520 t.Expect 6 g.LargestProduct "73167176531330624919225119674426574742355349194934"}
  "reports zero if the only digits are zero"‿{𝕊: 0 t.Expect 2 g.LargestProduct "0000"}
  "reports zero if all spans include zero"‿{𝕊: 0 t.Expect 3 g.LargestProduct "99099"}
  "rejects span longer than string length"‿{𝕊: {𝕊: 4 g.LargestProduct "123"} t._throws "span must not exceed string length"}
  "reports 1 for empty string and empty product (0 span)"‿{𝕊: 1 t.Expect 0 g.LargestProduct ""}
  "reports 1 for nonempty string and empty product (0 span)"‿{𝕊: 1 t.Expect 0 g.LargestProduct "123"}
  "rejects empty string and nonzero span"‿{𝕊: {𝕊: 1 g.LargestProduct ""} t._throws "span must not exceed string length"}
  "rejects invalid character in digits"‿{𝕊: {𝕊: 2 g.LargestProduct "1234a5"} t._throws "digits input must only contain digits"}
  "rejects negative span"‿{𝕊: {𝕊: ¯1 g.LargestProduct "12345"} t._throws "span must not be negative"}
⟩
