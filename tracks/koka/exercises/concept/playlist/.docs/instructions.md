# Instructions

Jonas DJs at his friends' parties from a playlist on his phone, and the app he uses keeps crashing. He has
decided to write his own, starting with the functions that edit the playlist. A playlist is a list of song
titles, in the order they will play.

## 1. Queue a song next

Define the `queue-next` function: it takes a playlist and a song and returns the playlist with that song
playing next, before all the others.

```koka
queue-next(["Blue", "Red"], "Gold")
// => ["Gold", "Blue", "Red"]
```

## 2. Queue a song last

Define the `queue-last` function: it takes a playlist and a song and returns the playlist with that song
playing after all the others.

```koka
queue-last(["Blue", "Red"], "Gold")
// => ["Blue", "Red", "Gold"]
```

## 3. Skip songs

Define the `skip` function: it takes a playlist and a number of songs, and returns the playlist without that many
songs at its start. Skipping more songs than the playlist has leaves it empty.

```koka
skip(["Blue", "Red", "Gold"], 1)
// => ["Red", "Gold"]
```

## 4. Check for a song

Define the `has-song` function: it takes a playlist and a song and returns whether the song is on the playlist.

```koka
has-song(["Blue", "Red"], "Red")
// => True
```

## 5. Add up the playing time

Define the `total-seconds` function: it takes the lengths of some songs in seconds and returns how many seconds
they take to play in total.

```koka
total-seconds([180, 240, 180])
// => 600
```

## 6. Summarise the playlist

Define the `summary` function: it takes a playlist and returns a line for the app's header: the number of songs,
`songs:` (or `song:` for exactly one), and the titles separated by a comma and a space. An empty playlist is
summarised as `"No songs"`.

```koka
summary(["Blue", "Red", "Gold"])
// => "3 songs: Blue, Red, Gold"
summary(["Blue"])
// => "1 song: Blue"
```
