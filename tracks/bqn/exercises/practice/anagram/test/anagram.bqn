t ← •Import "../lib/test.bqn"
g ← •Import "../anagram.bqn"

t.Run ⟨
  "no matches"‿{𝕊: ⟨⟩ t.Expect "diaper" g.FindAnagrams "hello"‿"world"‿"zombies"‿"pants"}
  "detects two anagrams"‿{𝕊: "lemons"‿"melons" t.Expect "solemn" g.FindAnagrams "lemons"‿"cherry"‿"melons"}
  "does not detect anagram subsets"‿{𝕊: ⟨⟩ t.Expect "good" g.FindAnagrams "dog"‿"goody"}
  "detects anagram"‿{𝕊: ⟨"inlets"⟩ t.Expect "listen" g.FindAnagrams "enlists"‿"google"‿"inlets"‿"banana"}
  "detects three anagrams"‿{𝕊: "gallery"‿"regally"‿"largely" t.Expect "allergy" g.FindAnagrams "gallery"‿"ballerina"‿"regally"‿"clergy"‿"largely"‿"leading"}
  "detects multiple anagrams with different case"‿{𝕊: "Eons"‿"ONES" t.Expect "nose" g.FindAnagrams "Eons"‿"ONES"}
  "does not detect non-anagrams with identical checksum"‿{𝕊: ⟨⟩ t.Expect "mass" g.FindAnagrams ⟨"last"⟩}
  "detects anagrams case-insensitively"‿{𝕊: ⟨"Carthorse"⟩ t.Expect "Orchestra" g.FindAnagrams "cashregister"‿"Carthorse"‿"radishes"}
  "detects anagrams using case-insensitive subject"‿{𝕊: ⟨"carthorse"⟩ t.Expect "Orchestra" g.FindAnagrams "cashregister"‿"carthorse"‿"radishes"}
  "detects anagrams using case-insensitive possible matches"‿{𝕊: ⟨"Carthorse"⟩ t.Expect "orchestra" g.FindAnagrams "cashregister"‿"Carthorse"‿"radishes"}
  "does not detect an anagram if the original word is repeated"‿{𝕊: ⟨⟩ t.Expect "go" g.FindAnagrams ⟨"goGoGO"⟩}
  "anagrams must use all letters exactly once"‿{𝕊: ⟨⟩ t.Expect "tapper" g.FindAnagrams ⟨"patter"⟩}
  "words are not anagrams of themselves"‿{𝕊: ⟨⟩ t.Expect "BANANA" g.FindAnagrams ⟨"BANANA"⟩}
  "words are not anagrams of themselves even if letter case is partially different"‿{𝕊: ⟨⟩ t.Expect "BANANA" g.FindAnagrams ⟨"Banana"⟩}
  "words are not anagrams of themselves even if letter case is completely different"‿{𝕊: ⟨⟩ t.Expect "BANANA" g.FindAnagrams ⟨"banana"⟩}
  "words other than themselves can be anagrams"‿{𝕊: ⟨"Silent"⟩ t.Expect "LISTEN" g.FindAnagrams "LISTEN"‿"Silent"}
  "handles case of greek letters"‿{𝕊: "ΒΓΑ"‿"γβα" t.Expect "ΑΒΓ" g.FindAnagrams "ΒΓΑ"‿"ΒΓΔ"‿"γβα"‿"αβγ"}
  "different characters may have the same bytes"‿{𝕊: ⟨⟩ t.Expect "a⬂" g.FindAnagrams ⟨"€a"⟩}
⟩
