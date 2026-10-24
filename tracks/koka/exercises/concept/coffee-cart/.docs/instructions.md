# Instructions

Femi sells coffee from a cart outside the train station. His menu is short: espresso, lattes in three sizes —
with oat milk for a little extra — and tea, also in three sizes. The types describing the menu are already in
`coffee-cart.kk`; you will write the till's arithmetic and the words on the cups.

| | small | medium | large |
| --- | --- | --- | --- |
| cup price | 250 | 300 | 350 |

All prices are in cents.

## 1. Price a cup size

Define `cup-price`: it takes a `size` and returns the price of that cup size, from the table above.

```koka
cup-price(Medium)
// => 300
```

## 2. Price a drink

Define `price`: it takes a `drink` and returns its price. An espresso is always 200. A latte costs its cup price,
plus 50 with oat milk. A tea costs 50 less than its cup price.

```koka
price(Latte(Large, True))
// => 400
price(Tea("mint", Small))
// => 200
```

## 3. Write on the cup

Define `label`: it takes a drink and returns what Femi writes on the cup — `"espresso"`, the size and `"latte"`,
followed by `" with oat milk"` if it has it, or the size, the kind of tea and `"tea"`.

```koka
label(Latte(Small, True))
// => "small latte with oat milk"
label(Tea("mint", Large))
// => "large mint tea"
```

## 4. Upsize an order

On rainy days every order is made one size bigger. Define `upsize`: it takes a drink and returns it one size
larger — small becomes medium and medium becomes large; a large drink and an espresso stay as they are.

```koka
upsize(Tea("rooibos", Small))
// => Tea("rooibos", Medium)
```

## 5. Warm the milk

Define `needs-milk`: it takes a drink and returns whether Femi has to warm cow's milk for it, which is only for a
latte without oat milk.

```koka
needs-milk(Latte(Medium, False))
// => True
```
