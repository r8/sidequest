# Instructions

The weather station on Gull Island has run on paper logbooks for forty years.
Its new volunteer, Tomas, is writing a small program that turns the station's readings into the short reports the ferry captains read every morning.
The sky is recorded as one of `:sunny`, `:cloudy`, `:rainy`, `:snowy` or `:stormy`, and Tomas asks you to help with the parts that deal with those keywords.

## 1. Classify the temperature

The reports describe the temperature in degrees Celsius with a keyword: `:freezing` below 0, `:cold` below 10, `:mild` below 20, and `:hot` from 20 up.
Define the function `classify` that takes the temperature and returns its keyword.

```janet
(classify 14)
# => :mild
```

## 2. Give advice

Each report ends with a piece of advice for the sky: `"Bring sunglasses"` when it is `:sunny`, `"Bring an umbrella"` when it is `:rainy`, `"Wear boots"` when it is `:snowy`, `"Stay in harbour"` when it is `:stormy`, and `"Enjoy your day"` for any other sky.
Define the function `advice` that takes the sky and returns the advice.

```janet
(advice :rainy)
# => "Bring an umbrella"
```

## 3. Read the logbook

The old logbooks spell the sky in words, with any capitalisation and sometimes stray spaces around them: `"Sunny"`, `"  CLOUDY "`.
Define the function `parse-sky` that takes such a string and returns the sky as a keyword.

```janet
(parse-sky "  Stormy ")
# => :stormy
```

## 4. Spot wet weather

Define the function `wet?` that takes the sky and returns `true` when it is `:rainy`, `:snowy` or `:stormy`, and `false` otherwise.

```janet
(wet? :snowy)
# => true
```

## 5. Write the report

The report itself is the temperature's keyword and the sky's, as words, joined by `" and "`.
Define the function `report` that takes the temperature and the sky and returns the report.

```janet
(report 14 :sunny)
# => "mild and sunny"
```
