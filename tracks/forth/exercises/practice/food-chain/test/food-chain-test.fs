require ../lib/test.fs
require ../food-chain.fs

\ Lays a string down in data space, so a long expected text can be written one line per row:
\   create verse  s\" line one\n" text,  s" line two" text,  here verse - constant verse#
: text, ( c-addr u -- ) here swap dup chars allot move ;

create song-fly
  s\" I know an old lady who swallowed a fly.\n" text,
  s" I don't know why she swallowed the fly. Perhaps she'll die." text,
here song-fly - constant song-fly#
test" fly"  1 1 recite song-fly song-fly# assert-str= ;test

create song-spider
  s\" I know an old lady who swallowed a spider.\n" text,
  s\" It wriggled and jiggled and tickled inside her.\n" text,
  s\" She swallowed the spider to catch the fly.\n" text,
  s" I don't know why she swallowed the fly. Perhaps she'll die." text,
here song-spider - constant song-spider#
test" spider"  2 2 recite song-spider song-spider# assert-str= ;test

create song-bird
  s\" I know an old lady who swallowed a bird.\n" text,
  s\" How absurd to swallow a bird!\n" text,
  s\" She swallowed the bird to catch the spider that wriggled and jiggled and tickled inside her.\n" text,
  s\" She swallowed the spider to catch the fly.\n" text,
  s" I don't know why she swallowed the fly. Perhaps she'll die." text,
here song-bird - constant song-bird#
test" bird"  3 3 recite song-bird song-bird# assert-str= ;test

create song-cat
  s\" I know an old lady who swallowed a cat.\n" text,
  s\" Imagine that, to swallow a cat!\n" text,
  s\" She swallowed the cat to catch the bird.\n" text,
  s\" She swallowed the bird to catch the spider that wriggled and jiggled and tickled inside her.\n" text,
  s\" She swallowed the spider to catch the fly.\n" text,
  s" I don't know why she swallowed the fly. Perhaps she'll die." text,
here song-cat - constant song-cat#
test" cat"  4 4 recite song-cat song-cat# assert-str= ;test

create song-dog
  s\" I know an old lady who swallowed a dog.\n" text,
  s\" What a hog, to swallow a dog!\n" text,
  s\" She swallowed the dog to catch the cat.\n" text,
  s\" She swallowed the cat to catch the bird.\n" text,
  s\" She swallowed the bird to catch the spider that wriggled and jiggled and tickled inside her.\n" text,
  s\" She swallowed the spider to catch the fly.\n" text,
  s" I don't know why she swallowed the fly. Perhaps she'll die." text,
here song-dog - constant song-dog#
test" dog"  5 5 recite song-dog song-dog# assert-str= ;test

create song-goat
  s\" I know an old lady who swallowed a goat.\n" text,
  s\" Just opened her throat and swallowed a goat!\n" text,
  s\" She swallowed the goat to catch the dog.\n" text,
  s\" She swallowed the dog to catch the cat.\n" text,
  s\" She swallowed the cat to catch the bird.\n" text,
  s\" She swallowed the bird to catch the spider that wriggled and jiggled and tickled inside her.\n" text,
  s\" She swallowed the spider to catch the fly.\n" text,
  s" I don't know why she swallowed the fly. Perhaps she'll die." text,
here song-goat - constant song-goat#
test" goat"  6 6 recite song-goat song-goat# assert-str= ;test

create song-cow
  s\" I know an old lady who swallowed a cow.\n" text,
  s\" I don't know how she swallowed a cow!\n" text,
  s\" She swallowed the cow to catch the goat.\n" text,
  s\" She swallowed the goat to catch the dog.\n" text,
  s\" She swallowed the dog to catch the cat.\n" text,
  s\" She swallowed the cat to catch the bird.\n" text,
  s\" She swallowed the bird to catch the spider that wriggled and jiggled and tickled inside her.\n" text,
  s\" She swallowed the spider to catch the fly.\n" text,
  s" I don't know why she swallowed the fly. Perhaps she'll die." text,
here song-cow - constant song-cow#
test" cow"  7 7 recite song-cow song-cow# assert-str= ;test

create song-horse
  s\" I know an old lady who swallowed a horse.\n" text,
  s" She's dead, of course!" text,
here song-horse - constant song-horse#
test" horse"  8 8 recite song-horse song-horse# assert-str= ;test

create song-multiple-verses
  s\" I know an old lady who swallowed a fly.\n" text,
  s\" I don't know why she swallowed the fly. Perhaps she'll die.\n" text,
  s\" \n" text,
  s\" I know an old lady who swallowed a spider.\n" text,
  s\" It wriggled and jiggled and tickled inside her.\n" text,
  s\" She swallowed the spider to catch the fly.\n" text,
  s\" I don't know why she swallowed the fly. Perhaps she'll die.\n" text,
  s\" \n" text,
  s\" I know an old lady who swallowed a bird.\n" text,
  s\" How absurd to swallow a bird!\n" text,
  s\" She swallowed the bird to catch the spider that wriggled and jiggled and tickled inside her.\n" text,
  s\" She swallowed the spider to catch the fly.\n" text,
  s" I don't know why she swallowed the fly. Perhaps she'll die." text,
here song-multiple-verses - constant song-multiple-verses#
test" multiple verses"  1 3 recite song-multiple-verses song-multiple-verses# assert-str= ;test

create song-full-song
  s\" I know an old lady who swallowed a fly.\n" text,
  s\" I don't know why she swallowed the fly. Perhaps she'll die.\n" text,
  s\" \n" text,
  s\" I know an old lady who swallowed a spider.\n" text,
  s\" It wriggled and jiggled and tickled inside her.\n" text,
  s\" She swallowed the spider to catch the fly.\n" text,
  s\" I don't know why she swallowed the fly. Perhaps she'll die.\n" text,
  s\" \n" text,
  s\" I know an old lady who swallowed a bird.\n" text,
  s\" How absurd to swallow a bird!\n" text,
  s\" She swallowed the bird to catch the spider that wriggled and jiggled and tickled inside her.\n" text,
  s\" She swallowed the spider to catch the fly.\n" text,
  s\" I don't know why she swallowed the fly. Perhaps she'll die.\n" text,
  s\" \n" text,
  s\" I know an old lady who swallowed a cat.\n" text,
  s\" Imagine that, to swallow a cat!\n" text,
  s\" She swallowed the cat to catch the bird.\n" text,
  s\" She swallowed the bird to catch the spider that wriggled and jiggled and tickled inside her.\n" text,
  s\" She swallowed the spider to catch the fly.\n" text,
  s\" I don't know why she swallowed the fly. Perhaps she'll die.\n" text,
  s\" \n" text,
  s\" I know an old lady who swallowed a dog.\n" text,
  s\" What a hog, to swallow a dog!\n" text,
  s\" She swallowed the dog to catch the cat.\n" text,
  s\" She swallowed the cat to catch the bird.\n" text,
  s\" She swallowed the bird to catch the spider that wriggled and jiggled and tickled inside her.\n" text,
  s\" She swallowed the spider to catch the fly.\n" text,
  s\" I don't know why she swallowed the fly. Perhaps she'll die.\n" text,
  s\" \n" text,
  s\" I know an old lady who swallowed a goat.\n" text,
  s\" Just opened her throat and swallowed a goat!\n" text,
  s\" She swallowed the goat to catch the dog.\n" text,
  s\" She swallowed the dog to catch the cat.\n" text,
  s\" She swallowed the cat to catch the bird.\n" text,
  s\" She swallowed the bird to catch the spider that wriggled and jiggled and tickled inside her.\n" text,
  s\" She swallowed the spider to catch the fly.\n" text,
  s\" I don't know why she swallowed the fly. Perhaps she'll die.\n" text,
  s\" \n" text,
  s\" I know an old lady who swallowed a cow.\n" text,
  s\" I don't know how she swallowed a cow!\n" text,
  s\" She swallowed the cow to catch the goat.\n" text,
  s\" She swallowed the goat to catch the dog.\n" text,
  s\" She swallowed the dog to catch the cat.\n" text,
  s\" She swallowed the cat to catch the bird.\n" text,
  s\" She swallowed the bird to catch the spider that wriggled and jiggled and tickled inside her.\n" text,
  s\" She swallowed the spider to catch the fly.\n" text,
  s\" I don't know why she swallowed the fly. Perhaps she'll die.\n" text,
  s\" \n" text,
  s\" I know an old lady who swallowed a horse.\n" text,
  s" She's dead, of course!" text,
here song-full-song - constant song-full-song#
test" full song"  1 8 recite song-full-song song-full-song# assert-str= ;test

end-tests
