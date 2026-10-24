(import test :as t)
(import ../food-chain :as sol)

(t/deftest "fly"
  (t/assert-equal ["I know an old lady who swallowed a fly."
                   "I don't know why she swallowed the fly. Perhaps she'll die."]
                  (sol/recite 1 1)))

(t/deftest "spider"
  (t/assert-equal ["I know an old lady who swallowed a spider."
                   "It wriggled and jiggled and tickled inside her."
                   "She swallowed the spider to catch the fly."
                   "I don't know why she swallowed the fly. Perhaps she'll die."]
                  (sol/recite 2 2)))

(t/deftest "bird"
  (t/assert-equal ["I know an old lady who swallowed a bird."
                   "How absurd to swallow a bird!"
                   "She swallowed the bird to catch the spider that wriggled and jiggled and tickled inside her."
                   "She swallowed the spider to catch the fly."
                   "I don't know why she swallowed the fly. Perhaps she'll die."]
                  (sol/recite 3 3)))

(t/deftest "cat"
  (t/assert-equal ["I know an old lady who swallowed a cat."
                   "Imagine that, to swallow a cat!"
                   "She swallowed the cat to catch the bird."
                   "She swallowed the bird to catch the spider that wriggled and jiggled and tickled inside her."
                   "She swallowed the spider to catch the fly."
                   "I don't know why she swallowed the fly. Perhaps she'll die."]
                  (sol/recite 4 4)))

(t/deftest "dog"
  (t/assert-equal ["I know an old lady who swallowed a dog."
                   "What a hog, to swallow a dog!"
                   "She swallowed the dog to catch the cat."
                   "She swallowed the cat to catch the bird."
                   "She swallowed the bird to catch the spider that wriggled and jiggled and tickled inside her."
                   "She swallowed the spider to catch the fly."
                   "I don't know why she swallowed the fly. Perhaps she'll die."]
                  (sol/recite 5 5)))

(t/deftest "goat"
  (t/assert-equal ["I know an old lady who swallowed a goat."
                   "Just opened her throat and swallowed a goat!"
                   "She swallowed the goat to catch the dog."
                   "She swallowed the dog to catch the cat."
                   "She swallowed the cat to catch the bird."
                   "She swallowed the bird to catch the spider that wriggled and jiggled and tickled inside her."
                   "She swallowed the spider to catch the fly."
                   "I don't know why she swallowed the fly. Perhaps she'll die."]
                  (sol/recite 6 6)))

(t/deftest "cow"
  (t/assert-equal ["I know an old lady who swallowed a cow."
                   "I don't know how she swallowed a cow!"
                   "She swallowed the cow to catch the goat."
                   "She swallowed the goat to catch the dog."
                   "She swallowed the dog to catch the cat."
                   "She swallowed the cat to catch the bird."
                   "She swallowed the bird to catch the spider that wriggled and jiggled and tickled inside her."
                   "She swallowed the spider to catch the fly."
                   "I don't know why she swallowed the fly. Perhaps she'll die."]
                  (sol/recite 7 7)))

(t/deftest "horse"
  (t/assert-equal ["I know an old lady who swallowed a horse."
                   "She's dead, of course!"]
                  (sol/recite 8 8)))

(t/deftest "multiple verses"
  (t/assert-equal ["I know an old lady who swallowed a fly."
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
                   "I don't know why she swallowed the fly. Perhaps she'll die."]
                  (sol/recite 1 3)))

(t/deftest "full song"
  (t/assert-equal ["I know an old lady who swallowed a fly."
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
                   "She's dead, of course!"]
                  (sol/recite 1 8)))

(t/run)
