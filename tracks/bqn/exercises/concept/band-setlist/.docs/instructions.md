# Instructions

Your band, the Night Owls, has its first real tour coming up. The drummer keeps the setlist in a notebook, and the
sound engineer, the lighting crew and the poster printer all want it in a different form. You put it in BQN: a
setlist is a list of song titles, and everyone gets a function.

## 1. Measure the titles

The lighting desk shows each song's title on a small display. Write the function `TitleLengths`. It takes a
setlist and returns the number of characters in each title.

```bqn
TitleLengths "Intro"‿"Lights Out"‿"Home"
# ⇒ ⟨5, 10, 4⟩
```

## 2. Announce the songs

The singer reads an announcement before every song. Write the function `Announce`. It takes a setlist and
returns one announcement per song.

```bqn
Announce "Intro"‿"Home"
# ⇒ ⟨"Next up: Intro!", "Next up: Home!"⟩
```

## 3. Credit the songwriters

The poster credits each song's writer. Write the function `Credit`. Its left argument is a setlist and its right
argument the writers, one per song; it returns each title followed by `" by "` and its writer.

```bqn
"Intro"‿"Home" Credit "Ana"‿"Cy"
# ⇒ ⟨"Intro by Ana", "Home by Cy"⟩
```

## 4. Convert the timings

The drummer timed every song in seconds, set by set: the timings are a list of sets, each a list of seconds.
Write the function `ToMinutes`. It takes the timings and returns them in minutes, in the same shape.

```bqn
ToMinutes ⟨120‿240, ⟨300⟩⟩
# ⇒ ⟨⟨2, 4⟩, ⟨5⟩⟩
```

## 5. Measure every set

The whole tour is a list of setlists. Write the function `TourTitleLengths`. It takes the tour and returns the
title lengths of every setlist.

```bqn
TourTitleLengths ⟨"Intro"‿"Home", ⟨"Encore"⟩⟩
# ⇒ ⟨⟨5, 4⟩, ⟨6⟩⟩
```
