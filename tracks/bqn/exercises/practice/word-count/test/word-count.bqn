t ← •Import "../lib/test.bqn"
g ← •Import "../word-count.bqn"

nl ← @+10

t.Run ⟨
  "count one word"‿{𝕊: ⟨"word"‿1⟩ t.Expect g.CountWords "word"}
  "count one of each word"‿{𝕊: ⟨"each"‿1, "of"‿1, "one"‿1⟩ t.Expect g.CountWords "one of each"}
  "multiple occurrences of a word"‿{𝕊: ⟨"blue"‿1, "fish"‿4, "one"‿1, "red"‿1, "two"‿1⟩ t.Expect g.CountWords "one fish two fish red fish blue fish"}
  "handles cramped lists"‿{𝕊: ⟨"one"‿1, "three"‿1, "two"‿1⟩ t.Expect g.CountWords "one,two,three"}
  "handles expanded lists"‿{𝕊: ⟨"one"‿1, "three"‿1, "two"‿1⟩ t.Expect g.CountWords "one,"∾nl∾"two,"∾nl∾"three"}
  "ignore punctuation"‿{𝕊: ⟨"as"‿1, "car"‿1, "carpet"‿1, "java"‿1, "javascript"‿1⟩ t.Expect g.CountWords "car: carpet as java: javascript!!&@$%^&"}
  "include numbers"‿{𝕊: ⟨"1"‿1, "2"‿1, "testing"‿2⟩ t.Expect g.CountWords "testing, 1, 2 testing"}
  "normalize case"‿{𝕊: ⟨"go"‿3, "stop"‿2⟩ t.Expect g.CountWords "go Go GO Stop stop"}
  "with apostrophes"‿{𝕊: ⟨"cry"‿1, "don't"‿2, "first"‿1, "getting"‿1, "it"‿1, "laugh"‿1, "then"‿1, "you're"‿1⟩ t.Expect g.CountWords "'First: don't laugh. Then: don't cry. You're getting it.'"}
  "with quotations"‿{𝕊: ⟨"and"‿1, "between"‿1, "can't"‿1, "joe"‿1, "large"‿2, "tell"‿1⟩ t.Expect g.CountWords "Joe can't tell between 'large' and large."}
  "substrings from the beginning"‿{𝕊: ⟨"a"‿1, "and"‿1, "app"‿1, "apple"‿1, "between"‿1, "can't"‿1, "joe"‿1, "tell"‿1⟩ t.Expect g.CountWords "Joe can't tell between app, apple and a."}
  "multiple spaces not detected as a word"‿{𝕊: ⟨"multiple"‿1, "whitespaces"‿1⟩ t.Expect g.CountWords " multiple   whitespaces"}
  "alternating word separators not detected as a word"‿{𝕊: ⟨"one"‿1, "three"‿1, "two"‿1⟩ t.Expect g.CountWords ","∾nl∾",one,"∾nl∾" ,two "∾nl∾" 'three'"}
  "quotation for word with apostrophe"‿{𝕊: ⟨"can"‿1, "can't"‿2⟩ t.Expect g.CountWords "can, can't, 'can't'"}
⟩
