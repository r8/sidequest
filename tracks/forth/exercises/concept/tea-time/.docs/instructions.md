# Instructions

Mr Okafor runs the Willow Teahouse, where every pot is brewed to his rules.
Now that he has hired help for the busy afternoons, he wants the rules written down where nobody can argue with them: in Forth.

## 1. Boil the kettle

Boiling water takes 3 minutes, plus a minute for each cup of water in the kettle.
When nobody wants tea, the kettle is not boiled at all.
Define `kettle-minutes ( cups -- minutes )`.

```forth
4 kettle-minutes   \ leaves 7
0 kettle-minutes   \ leaves 0
```

## 2. Steep the leaves

Less than 3 grams of leaves steep for 2 minutes; from 3 to 6 grams, for 3 minutes; and more than 6 grams, for 4 minutes.
Define `steep-minutes ( grams -- minutes )`.

```forth
5 steep-minutes   \ leaves 3
8 steep-minutes   \ leaves 4
```

## 3. Serve at the right temperature

Tea hotter than 70 °C is left to cool to 70 °C before it is served.
Tea colder than 55 °C is reheated to 85 °C.
Anything in between is served as it is.
Define `serve-temp ( celsius -- celsius )`, the temperature the tea is served at.

```forth
92 serve-temp   \ leaves 70
50 serve-temp   \ leaves 85
63 serve-temp   \ leaves 63
```

## 4. Write the bill

A cup costs 250 pence.
An order of 10 cups or more gets 10% off the whole bill.
Define `bill ( cups -- pence )`.

```forth
4 bill    \ leaves 1000
12 bill   \ leaves 2700
```
