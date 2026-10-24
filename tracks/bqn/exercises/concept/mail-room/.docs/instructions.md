# Instructions

You've taken a job in the mail room of a big apartment block. Every morning a sack of letters arrives and has
to be sorted: into the trolley for each floor, into the residents' pigeonholes, and into bundles small enough to
carry up the stairs. The sack is a list, and so is everything you sort it into.

## 1. Sort the letters by floor

Write the function `ByFloor`. Its left argument is the floor of each letter (floors count from 0, and `¯1`
marks a letter with no address, which goes back to the post office); its right argument is the list of letters.
It returns one pile per floor, up to the highest floor that has mail, each with its letters in the order they
came out of the sack.

```bqn
2‿0‿2‿¯1‿1 ByFloor "card"‿"bill"‿"note"‿"ad"‿"parcel"
# ⇒ ⟨ ⟨ "bill" ⟩ ⟨ "parcel" ⟩ ⟨ "card" "note" ⟩ ⟩
```

## 2. Count the letters for each floor

Write the function `LettersPerFloor`. It takes the floor of each letter, as in task 1, and returns how many
letters go to each floor, up to the highest floor that has mail.

```bqn
LettersPerFloor 2‿0‿2‿¯1‿1
# ⇒ ⟨ 1 1 2 ⟩
```

## 3. Fill the pigeonholes

Write the function `Pigeonholes`. Its left argument is the list of residents' names and its right argument the
names on the letters, all of them residents. It returns one pile per resident, in the order of the residents,
holding the letters for that resident; a resident with no mail gets an empty pile.

```bqn
"Ana"‿"Bo"‿"Cy" Pigeonholes "Cy"‿"Ana"‿"Cy"
# ⇒ ⟨ ⟨ "Ana" ⟩ ⟨⟩ ⟨ "Cy" "Cy" ⟩ ⟩
```

## 4. Bundle the letters for the stairs

Write the function `Trips`. Its left argument is how many letters you can carry at once and its right argument
the list of letters; it returns the bundles you carry, in order, each full except perhaps the last.

```bqn
2 Trips "card"‿"bill"‿"note"‿"ad"‿"parcel"
# ⇒ ⟨ ⟨ "card" "bill" ⟩ ⟨ "note" "ad" ⟩ ⟨ "parcel" ⟩ ⟩
```

## 5. Sort the parcels by initial

Parcels are kept on shelves by the first letter of the recipient's name. Write the function `ByInitial`. It
takes a list of names and returns them in piles of names with the same first letter, the piles in the order
their letters first appear.

```bqn
ByInitial "Ana"‿"Bo"‿"Al"‿"Cy"‿"Bea"
# ⇒ ⟨ ⟨ "Ana" "Al" ⟩ ⟨ "Bo" "Bea" ⟩ ⟨ "Cy" ⟩ ⟩
```
