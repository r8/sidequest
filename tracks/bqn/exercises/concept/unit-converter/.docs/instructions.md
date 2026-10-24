# Instructions

Marta is flying to a cycling holiday in the United States, and everything there is measured in the wrong units.
She is building a tiny converter for her phone, and has a rule for it: no blocks, only functions built from
other functions.

## 1. Convert Celsius to Fahrenheit

Write the function `ToFahrenheit`. It takes a temperature in degrees Celsius and returns it in degrees
Fahrenheit: multiply by 1.8, then add 32.

```bqn
ToFahrenheit 100
# ⇒ 212
```

## 2. Convert Fahrenheit to Celsius

Write the function `ToCelsius`. It takes a temperature in degrees Fahrenheit and returns it in degrees
Celsius: subtract 32, then divide by 1.8.

```bqn
ToCelsius 212
# ⇒ 100
```

## 3. Add up two rides

Marta's bike computer counts miles. Write the function `TotalKm`. Its arguments are two distances in miles; it
returns their sum in kilometres, counting a mile as 1.6 kilometres.

```bqn
30 TotalKm 20
# ⇒ 80
```

## 4. Check the luggage allowance

Write the function `SpareKg`. Its left argument is the weight of her bag and its right argument the airline's
limit, both in kilograms; it returns how many kilograms she can still pack (negative if the bag is too heavy).

```bqn
18 SpareKg 23
# ⇒ 5
```

## 5. Measure a hotel room

Hotel rooms are advertised by the length of their side in feet. Write the function `SquareMetres`. It takes the
side of a square room in feet and returns its area in square metres, counting a foot as 0.3 metres.

```bqn
SquareMetres 10
# ⇒ 9
```
