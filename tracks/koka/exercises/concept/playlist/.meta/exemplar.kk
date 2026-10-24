// queue-next(playlist, song) -> `playlist` with `song` to be played next
pub fun queue-next(playlist : list<string>, song : string) : list<string>
  Cons(song, playlist)

// queue-last(playlist, song) -> `playlist` with `song` to be played after all the others
pub fun queue-last(playlist : list<string>, song : string) : list<string>
  playlist ++ [song]

// skip(playlist, n) -> `playlist` without its next `n` songs
pub fun skip(playlist : list<string>, n : int) : list<string>
  playlist.drop(n)

// has-song(playlist, song) -> whether `song` is on `playlist`
pub fun has-song(playlist : list<string>, song : string) : bool
  playlist.contains(song)

// total-seconds(durations) -> how long songs of these `durations` in seconds take to play
pub fun total-seconds(durations : list<int>) : int
  durations.sum

// summary(playlist) -> a line telling how many songs `playlist` has and which
pub fun summary(playlist : list<string>) : string
  val n = playlist.length
  if n == 0 then "No songs"
  elif n == 1 then "1 song: " ++ playlist.join
  else n.show ++ " songs: " ++ playlist.join(", ")
