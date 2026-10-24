t ← •Import "../lib/test.bqn"
g ← •Import "../phone-number.bqn"

t.Run ⟨
  "cleans the number"‿{𝕊: "2234567890" t.Expect g.Clean "(223) 456-7890"}
  "cleans numbers with dots"‿{𝕊: "2234567890" t.Expect g.Clean "223.456.7890"}
  "cleans numbers with multiple spaces"‿{𝕊: "2234567890" t.Expect g.Clean "223 456   7890   "}
  "invalid when 9 digits"‿{𝕊: {𝕊: g.Clean "123456789"} t._throws "must not be fewer than 10 digits"}
  "invalid when 11 digits does not start with a 1"‿{𝕊: {𝕊: g.Clean "22234567890"} t._throws "11 digits must start with 1"}
  "valid when 11 digits and starting with 1"‿{𝕊: "2234567890" t.Expect g.Clean "12234567890"}
  "valid when 11 digits and starting with 1 even with punctuation"‿{𝕊: "2234567890" t.Expect g.Clean "+1 (223) 456-7890"}
  "invalid when more than 11 digits"‿{𝕊: {𝕊: g.Clean "321234567890"} t._throws "must not be greater than 11 digits"}
  "invalid with letters"‿{𝕊: {𝕊: g.Clean "523-abc-7890"} t._throws "letters not permitted"}
  "invalid with punctuations"‿{𝕊: {𝕊: g.Clean "523-@:!-7890"} t._throws "punctuations not permitted"}
  "invalid if area code starts with 0"‿{𝕊: {𝕊: g.Clean "(023) 456-7890"} t._throws "area code cannot start with zero"}
  "invalid if area code starts with 1"‿{𝕊: {𝕊: g.Clean "(123) 456-7890"} t._throws "area code cannot start with one"}
  "invalid if exchange code starts with 0"‿{𝕊: {𝕊: g.Clean "(223) 056-7890"} t._throws "exchange code cannot start with zero"}
  "invalid if exchange code starts with 1"‿{𝕊: {𝕊: g.Clean "(223) 156-7890"} t._throws "exchange code cannot start with one"}
  "invalid if area code starts with 0 on valid 11-digit number"‿{𝕊: {𝕊: g.Clean "1 (023) 456-7890"} t._throws "area code cannot start with zero"}
  "invalid if area code starts with 1 on valid 11-digit number"‿{𝕊: {𝕊: g.Clean "1 (123) 456-7890"} t._throws "area code cannot start with one"}
  "invalid if exchange code starts with 0 on valid 11-digit number"‿{𝕊: {𝕊: g.Clean "1 (223) 056-7890"} t._throws "exchange code cannot start with zero"}
  "invalid if exchange code starts with 1 on valid 11-digit number"‿{𝕊: {𝕊: g.Clean "1 (223) 156-7890"} t._throws "exchange code cannot start with one"}
⟩
