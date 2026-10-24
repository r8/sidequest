# Instructions

The old lighting desk at the village hall is configured with a bank of eight DIP switches, numbered 0 to 7 from the right.
The caretaker writes the whole bank down as a single number, one bit per switch, so `%00000101` means switches 0 and 2 are on.
Help her make sense of the settings and change them.

## 1. Make the mask for a switch

Define `switch-mask ( n -- mask )`, the number with only switch `n`'s bit set.

```forth
3 switch-mask   \ leaves 8 (%1000)
```

## 2. Check a switch

Define `switch-on? ( settings n -- flag )`, true if switch `n` is on in `settings`.

```forth
%0101 2 switch-on?   \ leaves true
%0101 1 switch-on?   \ leaves false
```

## 3. Turn a switch on

Define `turn-on ( settings n -- settings' )`, the settings with switch `n` on and the others unchanged.

```forth
%0101 1 turn-on   \ leaves %0111
```

## 4. Turn a switch off

Define `turn-off ( settings n -- settings' )`, the settings with switch `n` off and the others unchanged.

```forth
%0101 2 turn-off   \ leaves %0001
```

## 5. Flip a switch

Define `flip ( settings n -- settings' )`, the settings with switch `n` changed to the opposite position.

```forth
%0101 0 flip   \ leaves %0100
%0101 1 flip   \ leaves %0111
```

## 6. Count the switches that are on

Define `switches-on ( settings -- count )`, how many of the eight switches are on.
Only the lowest eight bits are switches.

```forth
%10110001 switches-on   \ leaves 4
```
