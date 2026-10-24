require ../lib/test.fs
require ../proverb.fs

\ Lays a string down in data space, so a long expected text can be written one line per row:
\   create verse  s\" line one\n" text,  s" line two" text,  here verse - constant verse#
: text, ( c-addr u -- ) here swap dup chars allot move ;

test" zero pieces"  s" " recite s" " assert-str= ;test
test" one piece"  s" nail" recite s" And all for the want of a nail." assert-str= ;test

create proverb-two-pieces
  s\" For want of a nail the shoe was lost.\n" text,
  s" And all for the want of a nail." text,
here proverb-two-pieces - constant proverb-two-pieces#
test" two pieces"  s" nail shoe" recite proverb-two-pieces proverb-two-pieces# assert-str= ;test

create proverb-three-pieces
  s\" For want of a nail the shoe was lost.\n" text,
  s\" For want of a shoe the horse was lost.\n" text,
  s" And all for the want of a nail." text,
here proverb-three-pieces - constant proverb-three-pieces#
test" three pieces"  s" nail shoe horse" recite proverb-three-pieces proverb-three-pieces# assert-str= ;test

create proverb-full-proverb
  s\" For want of a nail the shoe was lost.\n" text,
  s\" For want of a shoe the horse was lost.\n" text,
  s\" For want of a horse the rider was lost.\n" text,
  s\" For want of a rider the message was lost.\n" text,
  s\" For want of a message the battle was lost.\n" text,
  s\" For want of a battle the kingdom was lost.\n" text,
  s" And all for the want of a nail." text,
here proverb-full-proverb - constant proverb-full-proverb#
test" full proverb"  s" nail shoe horse rider message battle kingdom" recite proverb-full-proverb proverb-full-proverb# assert-str= ;test

create proverb-four-pieces-modernized
  s\" For want of a pin the gun was lost.\n" text,
  s\" For want of a gun the soldier was lost.\n" text,
  s\" For want of a soldier the battle was lost.\n" text,
  s" And all for the want of a pin." text,
here proverb-four-pieces-modernized - constant proverb-four-pieces-modernized#
test" four pieces modernized"  s" pin gun soldier battle" recite proverb-four-pieces-modernized proverb-four-pieces-modernized# assert-str= ;test

\ Not in the canonical data: more pieces than any fixed-size buffer a solution might reach for.
create many-pieces 2999 chars allot  many-pieces 2999 bl fill
: fill-pieces ( -- ) 1000 0 do  s" ab" many-pieces i 3 * chars + swap chars move  loop ;
fill-pieces
create long-proverb 34000 chars allot
: fill-proverb ( -- )
  999 0 do  s\" For want of a ab the ab was lost.\n" long-proverb i 34 * chars + swap chars move  loop
  s" And all for the want of a ab." long-proverb 999 34 * chars + swap chars move ;
fill-proverb
test" many pieces"  many-pieces 2999 recite long-proverb 999 34 * 29 + assert-str= ;test

end-tests
