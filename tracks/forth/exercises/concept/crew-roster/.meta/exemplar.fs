begin-structure crew-member
  field:  member-id
  field:  member-rank
  field:  member-shifts
  cfield: member-deck
end-structure

\ Fills in the record at addr, with no shifts worked.
: enlist ( id rank deck addr -- )
  tuck member-deck c!
  tuck member-rank !
  tuck member-id !
  0 swap member-shifts ! ;

\ Raises the rank of the record at addr by one.
: promote ( addr -- )
  member-rank 1 swap +! ;

\ The address of the i-th record of the roster.
: crew-at ( roster i -- addr )
  crew-member * + ;

\ The higher-ranked of two records, the first on a tie.
: senior-of ( addr1 addr2 -- addr )
  over member-rank @ over member-rank @ < if nip else drop then ;

\ The id of the highest-ranked of the first n records, the first of them on a tie.
: most-senior ( roster n -- id )
  over swap 1 ?do  over i crew-at senior-of  loop
  nip member-id @ ;
