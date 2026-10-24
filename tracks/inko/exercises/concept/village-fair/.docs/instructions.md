# Instructions

Every summer, the village of Little Hampton holds a fair on the green. This year the organising committee is
keeping its records in two modules: `village_fair.stalls` (the file `src/village_fair/stalls.inko`) defines the
`Stall` type, and `village_fair` (the file `src/village_fair.inko`) works with the fair as a whole. Both files are
part of your solution.

A stall has a name, a width in metres, and may need electricity:

```inko
Stall.new(name: 'Cakes', metres: 4, power: false)
```

## 1. Charge for a pitch

In `src/village_fair/stalls.inko`, define the `fee` method of `Stall`. A stall pays `FEE_PER_METRE` coins for every
metre of its pitch, plus `POWER_FEE` coins if it needs electricity. Both constants are defined in that module:

```inko
Stall.new(name: 'Music', metres: 3, power: true).fee
# => 14
```

## 2. Add up the fees

In `src/village_fair.inko`, define the `total_fees` method, which returns what all the stalls pay together:

```inko
total_fees([cakes, plants, music])
# => 44
```

## 3. Measure the field

The stalls stand in one row, with a gap of one metre between neighbouring stalls. In `src/village_fair.inko`,
define the `field_length` method, which returns how many metres of field the row needs (0 for no stalls):

```inko
field_length([cakes, plants, music]) # widths 4, 6 and 3
# => 15
```

## 4. Print the programme

In `src/village_fair.inko`, define the `programme` method, which lists the stalls in order, numbered from 1:

```inko
programme([cakes, plants, music])
# => '1. Cakes, 2. Plants, 3. Music'
```
