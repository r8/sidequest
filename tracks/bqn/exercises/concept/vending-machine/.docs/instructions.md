# Instructions

The vending machine in the office kitchen has a new controller, and you volunteered to program it. Its slots are
numbered from `0`, and the machine knows the products and their prices (in cents) as lists in slot order.

## 1. Look up a product

Write the function `Product`. Its left argument is a slot number and its right argument the products; it returns
the product in that slot.

```bqn
1 Product "cola"‿"chips"‿"gum"‿"water"
# ⇒ "chips"
```

## 2. Pack an order

Write the function `Order`. Its left argument is a list of slot numbers and its right argument the products; it
returns the product for each slot, in the order given.

```bqn
2‿0‿2 Order "cola"‿"chips"‿"gum"‿"water"
# ⇒ ⟨"gum", "cola", "gum"⟩
```

## 3. Find the newest product

New products always go in the last slot. Write the function `Newest`. It takes the products and returns the one
in the last slot.

```bqn
Newest "cola"‿"chips"‿"gum"‿"water"
# ⇒ "water"
```

## 4. Read a slot code

The keypad has letters for rows and digits for columns, and every row has three slots: `"A1"`, `"A2"` and `"A3"`
are slots `0`, `1` and `2`, `"B1"` is slot `3`, and so on. Write the function `PriceOf`. Its left argument is the
prices and its right argument a two-character code; it returns the price of the product in that slot.

```bqn
150‿120‿90‿200‿175‿60 PriceOf "B2"
# ⇒ 175
```

## 5. Scroll the display

The display shows 8 characters of a message that scrolls around in a loop. Write the function `Window`. Its left
argument is the message and its right argument a starting index; it returns the 8 characters starting from that
index, wrapping around to the start of the message.

```bqn
"HELLO " Window 4
# ⇒ "O HELLO "
```
