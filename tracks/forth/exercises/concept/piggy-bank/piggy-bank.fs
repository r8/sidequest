\ Define the coins as constants, the savings as a variable and the goal as a value.

\ A penny is 1 cent.
: penny ( -- cents )
  true abort" implement me" ;

\ A nickel is 5 cents.
: nickel ( -- cents )
  true abort" implement me" ;

\ A dime is 10 cents.
: dime ( -- cents )
  true abort" implement me" ;

\ A quarter is 25 cents.
: quarter ( -- cents )
  true abort" implement me" ;

\ Empty the piggy bank.
: empty-bank ( -- )
  true abort" implement me" ;

\ The cents in the piggy bank.
: balance ( -- cents )
  true abort" implement me" ;

\ Add cents to the savings.
: deposit ( cents -- )
  true abort" implement me" ;

\ Take out cents, or everything if there is less; leave the amount taken.
: withdraw ( cents -- taken )
  true abort" implement me" ;

\ The savings goal, starting at 12000 cents.
: goal ( -- cents )
  true abort" implement me" ;

\ Change the savings goal.
: set-goal ( cents -- )
  true abort" implement me" ;

\ True when the savings are at least the goal.
: goal-reached? ( -- flag )
  true abort" implement me" ;
