# Instructions

Ravi is ordering pizza for the end-of-season party of his five-a-side football team.
The pizzeria sells round pizzas in several sizes, and Ravi wants to get the sums right before he calls.
Sizes are diameters in centimetres, and prices are in euros.

## 1. Work out the area of a pizza

Define `pizza-area ( F: diameter -- area )`, the area of a round pizza with the given diameter: π times the square of the radius.

```forth
30e pizza-area   \ leaves 706.858… on the float stack
```

## 2. Work out the area of a slice

Define `slice-area ( slices -- ) ( F: diameter -- area )`, the area of one slice when a pizza of the given diameter is cut into `slices` equal slices.

```forth
30e 8 slice-area   \ leaves 88.357… on the float stack
```

## 3. Compare two offers

The better deal is the pizza that costs less per square centimetre.
Define `better-deal? ( -- flag ) ( F: diameter1 price1 diameter2 price2 -- )`, true when the first pizza costs strictly less per square centimetre than the second.

```forth
30e 12e 20e 8e better-deal?   \ leaves true
```

## 4. Order enough pizza

Every player eats `appetite` pizzas (0.375 is three slices of an eight-slice pizza).
Define `pizzas-needed ( players -- pizzas ) ( F: appetite -- )`, the number of whole pizzas to order so that everyone gets enough.

```forth
10 0.375e pizzas-needed   \ leaves 4
```

## 5. Leave a tip

Ravi tips 15% of the bill, rounded to the nearest whole euro.
Define `tip ( F: bill -- tip )`.

```forth
42e tip   \ leaves 6. on the float stack
```
