# Instructions

The Willow Street seed library lends seeds instead of books: gardeners take a packet in spring and bring back seeds
from their own plants in autumn. Volunteer Hamid keeps the catalogue: for each variety of seed, how many packets
are on the shelf. He'd like to move it from a paper notebook to a map from variety names to packet counts.

## 1. Build the catalogue from a donation

Donations arrive as a pile of packets, each labelled with its variety. Define the `catalogue_from` method, which
takes the labels and returns a catalogue counting the packets of each variety:

```inko
catalogue_from(['tomato', 'bean', 'tomato'])
# => a map with 'tomato' => 2 and 'bean' => 1
```

## 2. Look up a variety

Define the `packets` method, which returns how many packets of a variety are in the catalogue, or `0` for a
variety the library doesn't have:

```inko
packets(catalogue, 'tomato')
# => 2
```

## 3. Add returned packets

Define the `add_packets` method, which adds a number of packets of a variety to the catalogue. The variety may be
new:

```inko
add_packets(catalogue, 'bean', amount: 3)
# 'bean' now has 4 packets
```

## 4. Retire a variety

Sometimes a variety is retired, and its packets go to the compost heap. Define the `retire` method, which removes
a variety from the catalogue and returns how many packets it had (`0` if it wasn't in the catalogue):

```inko
retire(catalogue, 'bean')
# => 4
```

## 5. List the varieties that are running low

Define the `running_low` method, which returns the names of the varieties with fewer packets than a given number,
in the order they were added to the catalogue:

```inko
running_low(catalogue, below: 2)
# => ['squash', 'pea']
```
