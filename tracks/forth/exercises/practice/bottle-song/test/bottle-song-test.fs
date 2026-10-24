require ../lib/test.fs
require ../bottle-song.fs

\ Lays a string down in data space, so a long expected text can be written one line per row:
\   create verse  s\" line one\n" text,  s" line two" text,  here verse - constant verse#
: text, ( c-addr u -- ) here swap dup chars allot move ;

create lyrics-first-generic-verse
  s\" Ten green bottles hanging on the wall,\n" text,
  s\" Ten green bottles hanging on the wall,\n" text,
  s\" And if one green bottle should accidentally fall,\n" text,
  s" There'll be nine green bottles hanging on the wall." text,
here lyrics-first-generic-verse - constant lyrics-first-generic-verse#
test" verse > single verse > first generic verse"  10 1 recite lyrics-first-generic-verse lyrics-first-generic-verse# assert-str= ;test

create lyrics-last-generic-verse
  s\" Three green bottles hanging on the wall,\n" text,
  s\" Three green bottles hanging on the wall,\n" text,
  s\" And if one green bottle should accidentally fall,\n" text,
  s" There'll be two green bottles hanging on the wall." text,
here lyrics-last-generic-verse - constant lyrics-last-generic-verse#
test" verse > single verse > last generic verse"  3 1 recite lyrics-last-generic-verse lyrics-last-generic-verse# assert-str= ;test

create lyrics-verse-with-2-bottles
  s\" Two green bottles hanging on the wall,\n" text,
  s\" Two green bottles hanging on the wall,\n" text,
  s\" And if one green bottle should accidentally fall,\n" text,
  s" There'll be one green bottle hanging on the wall." text,
here lyrics-verse-with-2-bottles - constant lyrics-verse-with-2-bottles#
test" verse > single verse > verse with 2 bottles"  2 1 recite lyrics-verse-with-2-bottles lyrics-verse-with-2-bottles# assert-str= ;test

create lyrics-verse-with-1-bottle
  s\" One green bottle hanging on the wall,\n" text,
  s\" One green bottle hanging on the wall,\n" text,
  s\" And if one green bottle should accidentally fall,\n" text,
  s" There'll be no green bottles hanging on the wall." text,
here lyrics-verse-with-1-bottle - constant lyrics-verse-with-1-bottle#
test" verse > single verse > verse with 1 bottle"  1 1 recite lyrics-verse-with-1-bottle lyrics-verse-with-1-bottle# assert-str= ;test

create lyrics-first-two-verses
  s\" Ten green bottles hanging on the wall,\n" text,
  s\" Ten green bottles hanging on the wall,\n" text,
  s\" And if one green bottle should accidentally fall,\n" text,
  s\" There'll be nine green bottles hanging on the wall.\n" text,
  s\" \n" text,
  s\" Nine green bottles hanging on the wall,\n" text,
  s\" Nine green bottles hanging on the wall,\n" text,
  s\" And if one green bottle should accidentally fall,\n" text,
  s" There'll be eight green bottles hanging on the wall." text,
here lyrics-first-two-verses - constant lyrics-first-two-verses#
test" lyrics > multiple verses > first two verses"  10 2 recite lyrics-first-two-verses lyrics-first-two-verses# assert-str= ;test

create lyrics-last-three-verses
  s\" Three green bottles hanging on the wall,\n" text,
  s\" Three green bottles hanging on the wall,\n" text,
  s\" And if one green bottle should accidentally fall,\n" text,
  s\" There'll be two green bottles hanging on the wall.\n" text,
  s\" \n" text,
  s\" Two green bottles hanging on the wall,\n" text,
  s\" Two green bottles hanging on the wall,\n" text,
  s\" And if one green bottle should accidentally fall,\n" text,
  s\" There'll be one green bottle hanging on the wall.\n" text,
  s\" \n" text,
  s\" One green bottle hanging on the wall,\n" text,
  s\" One green bottle hanging on the wall,\n" text,
  s\" And if one green bottle should accidentally fall,\n" text,
  s" There'll be no green bottles hanging on the wall." text,
here lyrics-last-three-verses - constant lyrics-last-three-verses#
test" lyrics > multiple verses > last three verses"  3 3 recite lyrics-last-three-verses lyrics-last-three-verses# assert-str= ;test

create lyrics-all-verses
  s\" Ten green bottles hanging on the wall,\n" text,
  s\" Ten green bottles hanging on the wall,\n" text,
  s\" And if one green bottle should accidentally fall,\n" text,
  s\" There'll be nine green bottles hanging on the wall.\n" text,
  s\" \n" text,
  s\" Nine green bottles hanging on the wall,\n" text,
  s\" Nine green bottles hanging on the wall,\n" text,
  s\" And if one green bottle should accidentally fall,\n" text,
  s\" There'll be eight green bottles hanging on the wall.\n" text,
  s\" \n" text,
  s\" Eight green bottles hanging on the wall,\n" text,
  s\" Eight green bottles hanging on the wall,\n" text,
  s\" And if one green bottle should accidentally fall,\n" text,
  s\" There'll be seven green bottles hanging on the wall.\n" text,
  s\" \n" text,
  s\" Seven green bottles hanging on the wall,\n" text,
  s\" Seven green bottles hanging on the wall,\n" text,
  s\" And if one green bottle should accidentally fall,\n" text,
  s\" There'll be six green bottles hanging on the wall.\n" text,
  s\" \n" text,
  s\" Six green bottles hanging on the wall,\n" text,
  s\" Six green bottles hanging on the wall,\n" text,
  s\" And if one green bottle should accidentally fall,\n" text,
  s\" There'll be five green bottles hanging on the wall.\n" text,
  s\" \n" text,
  s\" Five green bottles hanging on the wall,\n" text,
  s\" Five green bottles hanging on the wall,\n" text,
  s\" And if one green bottle should accidentally fall,\n" text,
  s\" There'll be four green bottles hanging on the wall.\n" text,
  s\" \n" text,
  s\" Four green bottles hanging on the wall,\n" text,
  s\" Four green bottles hanging on the wall,\n" text,
  s\" And if one green bottle should accidentally fall,\n" text,
  s\" There'll be three green bottles hanging on the wall.\n" text,
  s\" \n" text,
  s\" Three green bottles hanging on the wall,\n" text,
  s\" Three green bottles hanging on the wall,\n" text,
  s\" And if one green bottle should accidentally fall,\n" text,
  s\" There'll be two green bottles hanging on the wall.\n" text,
  s\" \n" text,
  s\" Two green bottles hanging on the wall,\n" text,
  s\" Two green bottles hanging on the wall,\n" text,
  s\" And if one green bottle should accidentally fall,\n" text,
  s\" There'll be one green bottle hanging on the wall.\n" text,
  s\" \n" text,
  s\" One green bottle hanging on the wall,\n" text,
  s\" One green bottle hanging on the wall,\n" text,
  s\" And if one green bottle should accidentally fall,\n" text,
  s" There'll be no green bottles hanging on the wall." text,
here lyrics-all-verses - constant lyrics-all-verses#
test" lyrics > multiple verses > all verses"  10 10 recite lyrics-all-verses lyrics-all-verses# assert-str= ;test

end-tests
