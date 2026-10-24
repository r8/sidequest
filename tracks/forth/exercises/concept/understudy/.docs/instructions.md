# Instructions

The Riverside Players are staging _Hamlet_, and the stage manager runs the show from a small Forth program.
Each actor is a word that leaves their cast number; the role of Hamlet is whoever is currently playing it, and that changes when an understudy goes on.

The stub defines three actors:

```forth
: amara   ( -- n ) 1 ;
: bastien ( -- n ) 2 ;
: chidi   ( -- n ) 3 ;
```

## 1. Create the role

Define `hamlet ( -- n )` as a deferred word that Amara plays to begin with.

```forth
hamlet   \ leaves 1
```

## 2. Cast an actor

Define `cast ( xt -- )`, which makes `hamlet` be played by the actor whose execution token it is given.

```forth
' chidi cast  hamlet   \ leaves 3
```

## 3. Ask who is playing

Define `who-plays ( -- xt )`, the execution token of the actor currently playing Hamlet.

```forth
' bastien cast  who-plays ' bastien =   \ leaves true
```

## 4. Send on an understudy for one scene

Define `one-scene ( xt -- n )`: the actor given plays Hamlet for one scene — run `hamlet` once with them in the role — and then the actor who had the role before gets it back.
Leave the number `hamlet` left.

```forth
' amara cast
' chidi one-scene   \ leaves 3
hamlet              \ leaves 1
```

## 5. Rehearse the alternating lines

In rehearsal Amara and Bastien read alternate lines.
Define `amara-next ( lines -- flag )` and `bastien-next ( lines -- flag )`: with `lines` lines still to read (at least one) and Amara, or Bastien, reading the next one, is the last line Amara's?
Each word is easiest to write in terms of the other.

```forth
1 amara-next     \ leaves true
2 amara-next     \ leaves false
1 bastien-next   \ leaves false
4 bastien-next   \ leaves true
```
