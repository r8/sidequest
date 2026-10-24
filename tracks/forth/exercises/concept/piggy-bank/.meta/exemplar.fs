\ The coins, in cents.
 1 constant penny
 5 constant nickel
10 constant dime
25 constant quarter

variable savings

\ Empty the piggy bank.
: empty-bank ( -- )
  0 savings ! ;

\ The cents in the piggy bank.
: balance ( -- cents )
  savings @ ;

\ Add cents to the savings.
: deposit ( cents -- )
  savings +! ;

\ Take out cents, or everything if there is less; leave the amount taken.
: withdraw ( cents -- taken )
  balance min  dup negate savings +! ;

\ The savings goal, starting at 12000 cents.
12000 value goal

\ Change the savings goal.
: set-goal ( cents -- )
  to goal ;

\ True when the savings are at least the goal.
: goal-reached? ( -- flag )
  balance goal >= ;
