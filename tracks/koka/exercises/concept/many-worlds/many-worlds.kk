// The story splits at every `branch()`: in one world it goes on with True, in another with False.
pub effect branch
  ctl branch() : bool

// The hero's luck, which the events of the story change.
pub effect luck
  fun luck() : int
  fun change-luck(delta : int) : ()

// all-endings(story) -> the ending of `story` in every world, the True world first
pub fun all-endings(story : () -> <branch,exn|e> a) : <exn|e> list<a>
  throw("implement me", ExnTodo)

// with-luck(start, story) -> the ending of `story` paired with the hero's final luck, starting from `start`
pub fun with-luck(start : int, story : () -> <luck,exn|e> a) : <exn|e> (a, int)
  throw("implement me", ExnTodo)

// luck-per-world(start, story) -> every world's ending paired with that world's own final luck
pub fun luck-per-world(start : int, story : () -> <branch,luck,exn|e> a) : <exn|e> list<(a, int)>
  throw("implement me", ExnTodo)

// shared-luck(start, story) -> every world's ending, and the luck left after all of them, shared by every world
pub fun shared-luck(start : int, story : () -> <branch,luck,exn|e> a) : <exn|e> (list<a>, int)
  throw("implement me", ExnTodo)

// follow-luck(story) -> the ending of `story` in the one world where every branch goes True while the hero's luck is at least 0
pub fun follow-luck(story : () -> <branch,luck,exn|e> a) : <luck,exn|e> a
  throw("implement me", ExnTodo)
