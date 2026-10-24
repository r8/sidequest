# Instructions

Old Tomas has kept the lighthouse on Gull Point for thirty years. The coastguard is replacing his logbook with a
small control panel, and they need you to write the rules Tomas has always followed in his head.

Hours are whole numbers from `0` (midnight) to `23`.

## 1. Know when to light the lamp

The lamp burns from 20:00 in the evening until 06:00 in the morning, when it is switched off. Define the `lamp_on?`
method, which takes the hour and returns whether the lamp should be lit:

```inko
lamp_on?(hour: 22)
# => true
lamp_on?(hour: 6)
# => false
```

## 2. Know when to sound the foghorn

The foghorn is only sounded when visibility is below 1000 metres and there are ships nearby. Define the `foghorn?`
method, which takes the visibility in metres and whether ships are nearby:

```inko
foghorn?(visibility: 400, ships_nearby: true)
# => true
foghorn?(visibility: 400, ships_nearby: false)
# => false
```

## 3. Raise the right storm flag

Tomas raises a flag for the wind speed, measured in knots:

| Wind speed | Flag |
| --- | --- |
| below 34 | `'none'` |
| 34 to 47 | `'gale'` |
| 48 to 63 | `'storm'` |
| 64 and above | `'hurricane'` |

Define the `storm_flag` method, which takes the wind speed and returns the flag:

```inko
storm_flag(knots: 50)
# => 'storm'
```

## 4. Know when Tomas can rest

Tomas can take a nap when the lamp doesn't need to be lit, the foghorn doesn't need to be sounded, and the wind is
below 34 knots. Define the `can_rest?` method, which takes the hour, the visibility, whether ships are nearby, and
the wind speed:

```inko
can_rest?(hour: 14, visibility: 5000, ships_nearby: true, knots: 10)
# => true
```
