# Instructions

The Hilltop Rocketry Club launches model rockets from a field outside town. Before every launch, the launch officer
reads out a checklist, and if anything is wrong the countdown stops. This season the club is wiring the checklist
into a launch console. The stub defines `LaunchError`, an enum of everything that can go wrong; write the checks
with `throw` and `try`.

## 1. Check the fuel

Define the `check_fuel` method, which returns the fuel level (in percent) when it is at least 80, and fails with
`LowFuel` otherwise:

```inko
check_fuel(79)
# => Result.Error(LaunchError.LowFuel(79))
```

## 2. Check the wind

Define the `check_wind` method, which returns the wind speed (in km/h) when it is at most 30, and fails with
`HighWind` otherwise:

```inko
check_wind(45)
# => Result.Error(LaunchError.HighWind(45))
```

## 3. Read a sensor

The sensors report text, and a broken sensor reports something that isn't a number. Define the `read_sensor` method,
which returns the number, or fails with `BadReading` holding the text:

```inko
read_sensor('ERR')
# => Result.Error(LaunchError.BadReading('ERR'))
```

## 4. Run the checklist

Define the `ready` method, which takes the fuel sensor's text, the wind sensor's text and whether the igniter is
armed, and checks them in this order: read the fuel sensor, check the fuel, read the wind sensor, check the wind,
check that the igniter is armed (failing with `NotArmed`). It returns the first problem it finds, or `Ok(nil)` when
the rocket is ready:

```inko
ready(fuel: '95', wind: '12', armed: true)
# => Result.Ok(nil)
ready(fuel: '50', wind: '45', armed: false)
# => Result.Error(LaunchError.LowFuel(50))
```

## 5. Explain the problem

Define the `message` method of `LaunchError`, which returns what the console shows:

| Error | Message |
| --- | --- |
| `LowFuel(50)` | `'fuel at 50%, need 80%'` |
| `HighWind(45)` | `'wind at 45 km/h, limit 30 km/h'` |
| `BadReading('ERR')` | `"sensor says 'ERR'"` |
| `NotArmed` | `'igniter not armed'` |
