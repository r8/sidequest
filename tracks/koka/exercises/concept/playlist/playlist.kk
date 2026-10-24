// queue-next(playlist, song) -> `playlist` with `song` to be played next
pub fun queue-next(playlist : list<string>, song : string) : exn list<string>
  throw("implement me", ExnTodo)

// queue-last(playlist, song) -> `playlist` with `song` to be played after all the others
pub fun queue-last(playlist : list<string>, song : string) : exn list<string>
  throw("implement me", ExnTodo)

// skip(playlist, n) -> `playlist` without its next `n` songs
pub fun skip(playlist : list<string>, n : int) : exn list<string>
  throw("implement me", ExnTodo)

// has-song(playlist, song) -> whether `song` is on `playlist`
pub fun has-song(playlist : list<string>, song : string) : exn bool
  throw("implement me", ExnTodo)

// total-seconds(durations) -> how long songs of these `durations` in seconds take to play
pub fun total-seconds(durations : list<int>) : exn int
  throw("implement me", ExnTodo)

// summary(playlist) -> a line telling how many songs `playlist` has and which
pub fun summary(playlist : list<string>) : exn string
  throw("implement me", ExnTodo)
