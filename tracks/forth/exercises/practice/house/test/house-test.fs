require ../lib/test.fs
require ../house.fs

\ Lays a string down in data space, so a long expected text can be written one line per row:
\   create verse  s\" line one\n" text,  s" line two" text,  here verse - constant verse#
: text, ( c-addr u -- ) here swap dup chars allot move ;

test" verse one - the house that jack built"  1 1 recite s" This is the house that Jack built." assert-str= ;test
test" verse two - the malt that lay"  2 2 recite s" This is the malt that lay in the house that Jack built." assert-str= ;test
test" verse three - the rat that ate"  3 3 recite s" This is the rat that ate the malt that lay in the house that Jack built." assert-str= ;test
test" verse four - the cat that killed"  4 4 recite s" This is the cat that killed the rat that ate the malt that lay in the house that Jack built." assert-str= ;test
test" verse five - the dog that worried"  5 5 recite s" This is the dog that worried the cat that killed the rat that ate the malt that lay in the house that Jack built." assert-str= ;test
test" verse six - the cow with the crumpled horn"  6 6 recite s" This is the cow with the crumpled horn that tossed the dog that worried the cat that killed the rat that ate the malt that lay in the house that Jack built." assert-str= ;test
test" verse seven - the maiden all forlorn"  7 7 recite s" This is the maiden all forlorn that milked the cow with the crumpled horn that tossed the dog that worried the cat that killed the rat that ate the malt that lay in the house that Jack built." assert-str= ;test
test" verse eight - the man all tattered and torn"  8 8 recite s" This is the man all tattered and torn that kissed the maiden all forlorn that milked the cow with the crumpled horn that tossed the dog that worried the cat that killed the rat that ate the malt that lay in the house that Jack built." assert-str= ;test
test" verse nine - the priest all shaven and shorn"  9 9 recite s" This is the priest all shaven and shorn that married the man all tattered and torn that kissed the maiden all forlorn that milked the cow with the crumpled horn that tossed the dog that worried the cat that killed the rat that ate the malt that lay in the house that Jack built." assert-str= ;test
test" verse 10 - the rooster that crowed in the morn"  10 10 recite s" This is the rooster that crowed in the morn that woke the priest all shaven and shorn that married the man all tattered and torn that kissed the maiden all forlorn that milked the cow with the crumpled horn that tossed the dog that worried the cat that killed the rat that ate the malt that lay in the house that Jack built." assert-str= ;test
test" verse 11 - the farmer sowing his corn"  11 11 recite s" This is the farmer sowing his corn that kept the rooster that crowed in the morn that woke the priest all shaven and shorn that married the man all tattered and torn that kissed the maiden all forlorn that milked the cow with the crumpled horn that tossed the dog that worried the cat that killed the rat that ate the malt that lay in the house that Jack built." assert-str= ;test
test" verse 12 - the horse and the hound and the horn"  12 12 recite s" This is the horse and the hound and the horn that belonged to the farmer sowing his corn that kept the rooster that crowed in the morn that woke the priest all shaven and shorn that married the man all tattered and torn that kissed the maiden all forlorn that milked the cow with the crumpled horn that tossed the dog that worried the cat that killed the rat that ate the malt that lay in the house that Jack built." assert-str= ;test

create rhyme-multiple-verses
  s\" This is the cat that killed the rat that ate the malt that lay in the house that Jack built.\n" text,
  s\" This is the dog that worried the cat that killed the rat that ate the malt that lay in the house that Jack built.\n" text,
  s\" This is the cow with the crumpled horn that tossed the dog that worried the cat that killed the rat that ate the malt that lay in the house that Jack built.\n" text,
  s\" This is the maiden all forlorn that milked the cow with the crumpled horn that tossed the dog that worried the cat that killed the rat that ate the malt that lay in the house that Jack built.\n" text,
  s" This is the man all tattered and torn that kissed the maiden all forlorn that milked the cow with the crumpled horn that tossed the dog that worried the cat that killed the rat that ate the malt that lay in the house that Jack built." text,
here rhyme-multiple-verses - constant rhyme-multiple-verses#
test" multiple verses"  4 8 recite rhyme-multiple-verses rhyme-multiple-verses# assert-str= ;test

create rhyme-full-rhyme
  s\" This is the house that Jack built.\n" text,
  s\" This is the malt that lay in the house that Jack built.\n" text,
  s\" This is the rat that ate the malt that lay in the house that Jack built.\n" text,
  s\" This is the cat that killed the rat that ate the malt that lay in the house that Jack built.\n" text,
  s\" This is the dog that worried the cat that killed the rat that ate the malt that lay in the house that Jack built.\n" text,
  s\" This is the cow with the crumpled horn that tossed the dog that worried the cat that killed the rat that ate the malt that lay in the house that Jack built.\n" text,
  s\" This is the maiden all forlorn that milked the cow with the crumpled horn that tossed the dog that worried the cat that killed the rat that ate the malt that lay in the house that Jack built.\n" text,
  s\" This is the man all tattered and torn that kissed the maiden all forlorn that milked the cow with the crumpled horn that tossed the dog that worried the cat that killed the rat that ate the malt that lay in the house that Jack built.\n" text,
  s\" This is the priest all shaven and shorn that married the man all tattered and torn that kissed the maiden all forlorn that milked the cow with the crumpled horn that tossed the dog that worried the cat that killed the rat that ate the malt that lay in the house that Jack built.\n" text,
  s\" This is the rooster that crowed in the morn that woke the priest all shaven and shorn that married the man all tattered and torn that kissed the maiden all forlorn that milked the cow with the crumpled horn that tossed the dog that worried the cat that killed the rat that ate the malt that lay in the house that Jack built.\n" text,
  s\" This is the farmer sowing his corn that kept the rooster that crowed in the morn that woke the priest all shaven and shorn that married the man all tattered and torn that kissed the maiden all forlorn that milked the cow with the crumpled horn that tossed the dog that worried the cat that killed the rat that ate the malt that lay in the house that Jack built.\n" text,
  s" This is the horse and the hound and the horn that belonged to the farmer sowing his corn that kept the rooster that crowed in the morn that woke the priest all shaven and shorn that married the man all tattered and torn that kissed the maiden all forlorn that milked the cow with the crumpled horn that tossed the dog that worried the cat that killed the rat that ate the malt that lay in the house that Jack built." text,
here rhyme-full-rhyme - constant rhyme-full-rhyme#
test" full rhyme"  1 12 recite rhyme-full-rhyme rhyme-full-rhyme# assert-str= ;test

end-tests
