# Instructions

The Lantern Theatre's new lighting desk is a computer, and Rosalind, the lighting designer, is writing the cues for _The Tempest_.
Every cue depends on the scene's settings — how bright the stage is, what colour the gels are — and Rosalind does not want to pass those settings to every single function.
The desk keeps them as dynamic bindings: `:brightness`, a percentage, and `:color`, a keyword.

## 1. Read the brightness

Define the function `brightness` that takes no arguments and returns the current `:brightness`, or `100` when none is set.

```janet
(brightness)
# => 100

(with-dyns [:brightness 40]
  (brightness))
# => 40
```

## 2. Describe a spotlight

Define the function `spotlight` that takes an actor's name and returns a description of their spotlight, using the current `:color` (`:white` when none is set) and brightness.

```janet
(with-dyns [:color :amber :brightness 60]
  (spotlight "Prospero"))
# => "amber spotlight on Prospero at 60%"
```

## 3. Light a scene

Define the function `in-color` that takes a color keyword and a function of no arguments, calls the function with `:color` set to that color, and returns what the function returns.
Afterwards, `:color` must be as it was before.

```janet
(in-color :blue (fn [] (spotlight "Ariel")))
# => "blue spotlight on Ariel at 100%"
```

## 4. Dim the lights

Define the function `dim!` that takes an amount and lowers the current brightness by that much, but never below 0.
The new brightness stays in effect for the rest of the current scene.
Return the new brightness.

```janet
(with-dyns [:brightness 80]
  (dim! 30)
  (brightness))
# => 50
```

## 5. Rehearse a cue

Cues print their instructions for the crew.
Define the function `rehearse` that takes a function of no arguments, calls it, and returns everything it printed, as a string, instead of printing it.

```janet
(rehearse (fn [] (print "Act one") (print "Lights up")))
# => "Act one\nLights up\n"
```
