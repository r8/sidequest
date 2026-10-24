t ← •Import "../lib/test.bqn"
g ← •Import "../bottle-song.bqn"

firstGenericVerse ← ⟨
  "Ten green bottles hanging on the wall,"
  "Ten green bottles hanging on the wall,"
  "And if one green bottle should accidentally fall,"
  "There'll be nine green bottles hanging on the wall."
⟩

lastGenericVerse ← ⟨
  "Three green bottles hanging on the wall,"
  "Three green bottles hanging on the wall,"
  "And if one green bottle should accidentally fall,"
  "There'll be two green bottles hanging on the wall."
⟩

verseWith2Bottles ← ⟨
  "Two green bottles hanging on the wall,"
  "Two green bottles hanging on the wall,"
  "And if one green bottle should accidentally fall,"
  "There'll be one green bottle hanging on the wall."
⟩

verseWith1Bottle ← ⟨
  "One green bottle hanging on the wall,"
  "One green bottle hanging on the wall,"
  "And if one green bottle should accidentally fall,"
  "There'll be no green bottles hanging on the wall."
⟩

firstTwoVerses ← ⟨
  "Ten green bottles hanging on the wall,"
  "Ten green bottles hanging on the wall,"
  "And if one green bottle should accidentally fall,"
  "There'll be nine green bottles hanging on the wall."
  ""
  "Nine green bottles hanging on the wall,"
  "Nine green bottles hanging on the wall,"
  "And if one green bottle should accidentally fall,"
  "There'll be eight green bottles hanging on the wall."
⟩

lastThreeVerses ← ⟨
  "Three green bottles hanging on the wall,"
  "Three green bottles hanging on the wall,"
  "And if one green bottle should accidentally fall,"
  "There'll be two green bottles hanging on the wall."
  ""
  "Two green bottles hanging on the wall,"
  "Two green bottles hanging on the wall,"
  "And if one green bottle should accidentally fall,"
  "There'll be one green bottle hanging on the wall."
  ""
  "One green bottle hanging on the wall,"
  "One green bottle hanging on the wall,"
  "And if one green bottle should accidentally fall,"
  "There'll be no green bottles hanging on the wall."
⟩

allVerses ← ⟨
  "Ten green bottles hanging on the wall,"
  "Ten green bottles hanging on the wall,"
  "And if one green bottle should accidentally fall,"
  "There'll be nine green bottles hanging on the wall."
  ""
  "Nine green bottles hanging on the wall,"
  "Nine green bottles hanging on the wall,"
  "And if one green bottle should accidentally fall,"
  "There'll be eight green bottles hanging on the wall."
  ""
  "Eight green bottles hanging on the wall,"
  "Eight green bottles hanging on the wall,"
  "And if one green bottle should accidentally fall,"
  "There'll be seven green bottles hanging on the wall."
  ""
  "Seven green bottles hanging on the wall,"
  "Seven green bottles hanging on the wall,"
  "And if one green bottle should accidentally fall,"
  "There'll be six green bottles hanging on the wall."
  ""
  "Six green bottles hanging on the wall,"
  "Six green bottles hanging on the wall,"
  "And if one green bottle should accidentally fall,"
  "There'll be five green bottles hanging on the wall."
  ""
  "Five green bottles hanging on the wall,"
  "Five green bottles hanging on the wall,"
  "And if one green bottle should accidentally fall,"
  "There'll be four green bottles hanging on the wall."
  ""
  "Four green bottles hanging on the wall,"
  "Four green bottles hanging on the wall,"
  "And if one green bottle should accidentally fall,"
  "There'll be three green bottles hanging on the wall."
  ""
  "Three green bottles hanging on the wall,"
  "Three green bottles hanging on the wall,"
  "And if one green bottle should accidentally fall,"
  "There'll be two green bottles hanging on the wall."
  ""
  "Two green bottles hanging on the wall,"
  "Two green bottles hanging on the wall,"
  "And if one green bottle should accidentally fall,"
  "There'll be one green bottle hanging on the wall."
  ""
  "One green bottle hanging on the wall,"
  "One green bottle hanging on the wall,"
  "And if one green bottle should accidentally fall,"
  "There'll be no green bottles hanging on the wall."
⟩

t.Run ⟨
  "verse > single verse > first generic verse"‿{𝕊: firstGenericVerse t.Expect g.Recite 10‿1}
  "verse > single verse > last generic verse"‿{𝕊: lastGenericVerse t.Expect g.Recite 3‿1}
  "verse > single verse > verse with 2 bottles"‿{𝕊: verseWith2Bottles t.Expect g.Recite 2‿1}
  "verse > single verse > verse with 1 bottle"‿{𝕊: verseWith1Bottle t.Expect g.Recite 1‿1}
  "lyrics > multiple verses > first two verses"‿{𝕊: firstTwoVerses t.Expect g.Recite 10‿2}
  "lyrics > multiple verses > last three verses"‿{𝕊: lastThreeVerses t.Expect g.Recite 3‿3}
  "lyrics > multiple verses > all verses"‿{𝕊: allVerses t.Expect g.Recite 10‿10}
⟩
