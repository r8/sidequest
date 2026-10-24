t ← •Import "../lib/test.bqn"
g ← •Import "../name-tags.bqn"

t.Run ⟨
  "1. a short name"‿{𝕊: "Hello, my name is Grace" t.Expect g.Badge "Grace"}
  "1. a full name"‿{𝕊: "Hello, my name is Alan Turing" t.Expect g.Badge "Alan Turing"}
  "1. no name"‿{𝕊: "Hello, my name is " t.Expect g.Badge ""}
  "2. two names"‿{𝕊: "Ada Lovelace" t.Expect "Ada" g.FullName "Lovelace"}
  "2. one-letter names"‿{𝕊: "X Y" t.Expect "X" g.FullName "Y"}
  "2. accented names"‿{𝕊: "Émilie du Châtelet" t.Expect "Émilie" g.FullName "du Châtelet"}
  "3. small letters"‿{𝕊: "GRACE" t.Expect g.Shout "grace"}
  "3. a mixed-case name"‿{𝕊: "ADA LOVELACE" t.Expect g.Shout "Ada Lovelace"}
  "3. punctuation and digits stay"‿{𝕊: "R2-D2, O'BRIEN!" t.Expect g.Shout "r2-d2, O'Brien!"}
  "3. already capitals"‿{𝕊: "ALAN" t.Expect g.Shout "ALAN"}
  "4. the first table"‿{𝕊: 'A' t.Expect g.TableLetter 0}
  "4. the third table"‿{𝕊: 'C' t.Expect g.TableLetter 2}
  "4. several tables"‿{𝕊: "ABD" t.Expect g.TableLetter 0‿1‿3}
  "4. the last letter"‿{𝕊: 'Z' t.Expect g.TableLetter 25}
  "5. a nickname"‿{𝕊: """Amazing Grace""" t.Expect g.Quote "Amazing Grace"}
  "5. a one-letter nickname"‿{𝕊: """Q""" t.Expect g.Quote "Q"}
  "5. an empty nickname"‿{𝕊: """""" t.Expect g.Quote ""}
⟩
