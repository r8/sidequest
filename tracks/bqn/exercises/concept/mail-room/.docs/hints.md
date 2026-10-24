# Hints

## General

- The [group documentation](https://mlochbaum.github.io/BQN/doc/group.html) explains `⊔` with one and two
  arguments.
- [Search functions](https://mlochbaum.github.io/BQN/doc/search.html) and
  [self-search functions](https://mlochbaum.github.io/BQN/doc/selfcmp.html) turn values into group indices.

## 1. Sort the letters by floor

- The floors already are group indices, and `¯1` already means what you need.

## 2. Count the letters for each floor

- Group the positions, then count each pile.

## 3. Fill the pigeonholes

- Find each letter's resident by position in the list of residents.
- Without help, a resident at the end of the list with no mail gets no pile at all; add the number of piles
  you want to the end of the group indices.

## 4. Bundle the letters for the stairs

- Compute the bundle number of each position from the positions `↕≠𝕩`.

## 5. Sort the parcels by initial

- Take the first letter of each name, then number the distinct letters in order of appearance.
