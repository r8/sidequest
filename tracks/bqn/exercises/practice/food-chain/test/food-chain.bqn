t ← •Import "../lib/test.bqn"
g ← •Import "../food-chain.bqn"

fly ← ⟨
  "I know an old lady who swallowed a fly."
  "I don't know why she swallowed the fly. Perhaps she'll die."
⟩

spider ← ⟨
  "I know an old lady who swallowed a spider."
  "It wriggled and jiggled and tickled inside her."
  "She swallowed the spider to catch the fly."
  "I don't know why she swallowed the fly. Perhaps she'll die."
⟩

bird ← ⟨
  "I know an old lady who swallowed a bird."
  "How absurd to swallow a bird!"
  "She swallowed the bird to catch the spider that wriggled and jiggled and tickled inside her."
  "She swallowed the spider to catch the fly."
  "I don't know why she swallowed the fly. Perhaps she'll die."
⟩

cat ← ⟨
  "I know an old lady who swallowed a cat."
  "Imagine that, to swallow a cat!"
  "She swallowed the cat to catch the bird."
  "She swallowed the bird to catch the spider that wriggled and jiggled and tickled inside her."
  "She swallowed the spider to catch the fly."
  "I don't know why she swallowed the fly. Perhaps she'll die."
⟩

dog ← ⟨
  "I know an old lady who swallowed a dog."
  "What a hog, to swallow a dog!"
  "She swallowed the dog to catch the cat."
  "She swallowed the cat to catch the bird."
  "She swallowed the bird to catch the spider that wriggled and jiggled and tickled inside her."
  "She swallowed the spider to catch the fly."
  "I don't know why she swallowed the fly. Perhaps she'll die."
⟩

goat ← ⟨
  "I know an old lady who swallowed a goat."
  "Just opened her throat and swallowed a goat!"
  "She swallowed the goat to catch the dog."
  "She swallowed the dog to catch the cat."
  "She swallowed the cat to catch the bird."
  "She swallowed the bird to catch the spider that wriggled and jiggled and tickled inside her."
  "She swallowed the spider to catch the fly."
  "I don't know why she swallowed the fly. Perhaps she'll die."
⟩

cow ← ⟨
  "I know an old lady who swallowed a cow."
  "I don't know how she swallowed a cow!"
  "She swallowed the cow to catch the goat."
  "She swallowed the goat to catch the dog."
  "She swallowed the dog to catch the cat."
  "She swallowed the cat to catch the bird."
  "She swallowed the bird to catch the spider that wriggled and jiggled and tickled inside her."
  "She swallowed the spider to catch the fly."
  "I don't know why she swallowed the fly. Perhaps she'll die."
⟩

multipleVerses ← ⟨
  "I know an old lady who swallowed a fly."
  "I don't know why she swallowed the fly. Perhaps she'll die."
  ""
  "I know an old lady who swallowed a spider."
  "It wriggled and jiggled and tickled inside her."
  "She swallowed the spider to catch the fly."
  "I don't know why she swallowed the fly. Perhaps she'll die."
  ""
  "I know an old lady who swallowed a bird."
  "How absurd to swallow a bird!"
  "She swallowed the bird to catch the spider that wriggled and jiggled and tickled inside her."
  "She swallowed the spider to catch the fly."
  "I don't know why she swallowed the fly. Perhaps she'll die."
⟩

fullSong ← ⟨
  "I know an old lady who swallowed a fly."
  "I don't know why she swallowed the fly. Perhaps she'll die."
  ""
  "I know an old lady who swallowed a spider."
  "It wriggled and jiggled and tickled inside her."
  "She swallowed the spider to catch the fly."
  "I don't know why she swallowed the fly. Perhaps she'll die."
  ""
  "I know an old lady who swallowed a bird."
  "How absurd to swallow a bird!"
  "She swallowed the bird to catch the spider that wriggled and jiggled and tickled inside her."
  "She swallowed the spider to catch the fly."
  "I don't know why she swallowed the fly. Perhaps she'll die."
  ""
  "I know an old lady who swallowed a cat."
  "Imagine that, to swallow a cat!"
  "She swallowed the cat to catch the bird."
  "She swallowed the bird to catch the spider that wriggled and jiggled and tickled inside her."
  "She swallowed the spider to catch the fly."
  "I don't know why she swallowed the fly. Perhaps she'll die."
  ""
  "I know an old lady who swallowed a dog."
  "What a hog, to swallow a dog!"
  "She swallowed the dog to catch the cat."
  "She swallowed the cat to catch the bird."
  "She swallowed the bird to catch the spider that wriggled and jiggled and tickled inside her."
  "She swallowed the spider to catch the fly."
  "I don't know why she swallowed the fly. Perhaps she'll die."
  ""
  "I know an old lady who swallowed a goat."
  "Just opened her throat and swallowed a goat!"
  "She swallowed the goat to catch the dog."
  "She swallowed the dog to catch the cat."
  "She swallowed the cat to catch the bird."
  "She swallowed the bird to catch the spider that wriggled and jiggled and tickled inside her."
  "She swallowed the spider to catch the fly."
  "I don't know why she swallowed the fly. Perhaps she'll die."
  ""
  "I know an old lady who swallowed a cow."
  "I don't know how she swallowed a cow!"
  "She swallowed the cow to catch the goat."
  "She swallowed the goat to catch the dog."
  "She swallowed the dog to catch the cat."
  "She swallowed the cat to catch the bird."
  "She swallowed the bird to catch the spider that wriggled and jiggled and tickled inside her."
  "She swallowed the spider to catch the fly."
  "I don't know why she swallowed the fly. Perhaps she'll die."
  ""
  "I know an old lady who swallowed a horse."
  "She's dead, of course!"
⟩

t.Run ⟨
  "fly"‿{𝕊: fly t.Expect g.Recite 1‿1}
  "spider"‿{𝕊: spider t.Expect g.Recite 2‿2}
  "bird"‿{𝕊: bird t.Expect g.Recite 3‿3}
  "cat"‿{𝕊: cat t.Expect g.Recite 4‿4}
  "dog"‿{𝕊: dog t.Expect g.Recite 5‿5}
  "goat"‿{𝕊: goat t.Expect g.Recite 6‿6}
  "cow"‿{𝕊: cow t.Expect g.Recite 7‿7}
  "horse"‿{𝕊: ⟨"I know an old lady who swallowed a horse.", "She's dead, of course!"⟩ t.Expect g.Recite 8‿8}
  "multiple verses"‿{𝕊: multipleVerses t.Expect g.Recite 1‿3}
  "full song"‿{𝕊: fullSong t.Expect g.Recite 1‿8}
⟩
