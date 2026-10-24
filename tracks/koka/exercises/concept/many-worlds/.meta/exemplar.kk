// The story splits at every `branch()`: in one world it goes on with True, in another with False.
pub effect branch
  ctl branch() : bool

// The hero's luck, which the events of the story change.
pub effect luck
  fun luck() : int
  fun change-luck(delta : int) : ()

// all-endings(story) -> the ending of `story` in every world, the True world first
pub fun all-endings(story : () -> <branch|e> a) : e list<a>
  with handler
    return(x) [x]
    ctl branch() resume(True) ++ resume(False)
  story()

// with-luck(start, story) -> the ending of `story` paired with the hero's final luck, starting from `start`
pub fun with-luck(start : int, story : () -> <luck|e> a) : e (a, int)
  var current := start
  with handler
    return(x) (x, current)
    fun luck() current
    fun change-luck(delta) current := current + delta
  story()

// luck-per-world(start, story) -> every world's ending paired with that world's own final luck
pub fun luck-per-world(start : int, story : () -> <branch,luck|e> a) : e list<(a, int)>
  with all-endings
  with-luck(start, story)

// shared-luck(start, story) -> every world's ending, and the luck left after all of them, shared by every world
pub fun shared-luck(start : int, story : () -> <branch,luck|e> a) : e (list<a>, int)
  with with-luck(start)
  all-endings(story)

// follow-luck(story) -> the ending of `story` in the one world where every branch goes True while the hero's luck is at least 0
pub fun follow-luck(story : () -> <branch,luck|e> a) : <luck|e> a
  with fun branch() luck() >= 0
  story()
