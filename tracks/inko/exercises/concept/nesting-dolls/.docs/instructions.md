# Instructions

Grandma Irina collects matryoshka dolls: painted wooden dolls that open in the middle, each holding a smaller doll,
down to a tiny solid doll that doesn't open. She paints a name on every doll she owns. To catalogue her collection,
the stub describes a set of dolls as an enum: a `Solid` doll with its name, or a `Hollow` doll with its name and the
doll inside it.

```inko
Doll.Hollow('Anya', Doll.Hollow('Bela', Doll.Solid('Dasha')))
```

## 1. Count the dolls

Define the `count` method, which returns how many dolls a set holds:

```inko
Doll.Hollow('Vera', Doll.Solid('Dasha')).count
# => 2
```

## 2. Find the innermost doll

Define the `innermost` method, which returns the name of the solid doll at the centre:

```inko
Doll.Hollow('Vera', Doll.Solid('Dasha')).innermost
# => 'Dasha'
```

## 3. List the names

Define the `names` method, which returns the names of all the dolls, from the outermost to the innermost:

```inko
Doll.Hollow('Vera', Doll.Solid('Dasha')).names
# => ['Vera', 'Dasha']
```

## 4. Look for a doll

Define the `contains?` method, which returns whether a doll with a given name is part of the set:

```inko
Doll.Hollow('Vera', Doll.Solid('Dasha')).contains?('Dasha')
# => true
```

## 5. Nest a new set

Irina's grandchildren paint new sets and tell her the names from the outside in. Define the static `nest` method,
which takes the names (always at least one) and returns the set of dolls, the last name being the solid doll:

```inko
Doll.nest(['Vera', 'Dasha'])
# => Doll.Hollow('Vera', Doll.Solid('Dasha'))
```
