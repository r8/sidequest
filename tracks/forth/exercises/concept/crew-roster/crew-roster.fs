\ Task 1: replace these placeholders with a structure crew-member, with the cell fields
\ member-id, member-rank and member-shifts, and the character field member-deck.

\ The size of one crew record.
: crew-member ( -- u )
  true abort" implement me" ;

\ The address of a record's id.
: member-id ( addr -- addr' )
  true abort" implement me" ;

\ The address of a record's rank.
: member-rank ( addr -- addr' )
  true abort" implement me" ;

\ The address of a record's count of shifts worked.
: member-shifts ( addr -- addr' )
  true abort" implement me" ;

\ The address of a record's deck letter.
: member-deck ( addr -- c-addr )
  true abort" implement me" ;

\ Fills in the record at addr, with no shifts worked.
: enlist ( id rank deck addr -- )
  true abort" implement me" ;

\ Raises the rank of the record at addr by one.
: promote ( addr -- )
  true abort" implement me" ;

\ The address of the i-th record of the roster.
: crew-at ( roster i -- addr )
  true abort" implement me" ;

\ The id of the highest-ranked of the first n records, the first of them on a tie.
: most-senior ( roster n -- id )
  true abort" implement me" ;
