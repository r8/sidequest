# Instructions

Lena paints signs by hand: shop fronts, banners for the market, and the brass-coloured number plates on half the
doors in town. Customers send their orders as plain text, and Lena wants some help turning those orders into what
she should paint, and into a price.

## 1. Paint a shop sign

A shop sign shows the owner's name, an apostrophe and `s`, then the trade. Define the `shop_sign` method, which
takes the owner's name and the trade:

```inko
shop_sign(owner: 'Rosa', trade: 'Bakery')
# => "Rosa's Bakery"
```

## 2. Tidy up an order

Orders often arrive with stray spaces around them. Define the `tidy` method, which removes spaces (and other
whitespace) from the start and end of an order:

```inko
tidy('   Fresh Fish  ')
# => 'Fresh Fish'
```

## 3. Paint a market banner

Market banners are painted in capitals, tidied, with three stars on either side. Define the `banner` method:

```inko
banner(' Summer fair ')
# => '*** SUMMER FAIR ***'
```

## 4. Count the letters to paint

Lena charges for every character she paints; spaces are free. Define the `painted_characters` method, which
returns the number of characters in the text that aren't spaces. Remember that some characters take more than one
byte:

```inko
painted_characters('Café Rosa')
# => 8
```

## 5. Make a door plate

Door plates always show four digits, with leading zeros where the house number is shorter. Define the `door_plate`
method, which takes the house number and returns the text for the plate:

```inko
door_plate(42)
# => '0042'
```
