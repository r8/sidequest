# Instructions

The Pinewood post office is busier than ever since the town got a new ferry, and the postmaster, Hal, wants to modernise.
Letters will travel through the office on channels: posted into a mailbox, collected from it, and passed through a stamping machine that runs as its own task.

## 1. Post the letters

Define the function `post` that takes a mailbox (a channel) and an array of letters (strings), gives each letter to the mailbox in order, and returns the mailbox.

```janet
(def box (ev/chan 10))
(post box @["for Ada" "for Bo"])
(ev/take box)
# => "for Ada"
```

## 2. Collect the letters

Define the function `collect` that takes a mailbox and a count, and returns an array of that many letters taken from the mailbox, in the order they come out.

```janet
(def box (post (ev/chan 10) @["for Ada" "for Bo" "for Cy"]))
(collect box 2)
# => @["for Ada" "for Bo"]
```

## 3. Start the stamping machine

Define the function `start-stamper` that takes an input channel and an output channel, and starts a task that takes letters from the input, adds `" [stamped]"` to each, and gives the result to the output.
The machine keeps working until the input channel is closed, and then its task finishes.
Return the task.

```janet
(def in (ev/chan))
(def out (ev/chan 10))
(start-stamper in out)
(ev/give in "for Ada")
(ev/take out)
# => "for Ada [stamped]"
```

## 4. Run the office

Define the function `run-office` that takes an array of letters, sends them all through one stamping machine, and returns an array of the stamped letters in their original order.
When it returns, the stamping machine's task must have finished.

```janet
(run-office @["for Ada" "for Bo"])
# => @["for Ada [stamped]" "for Bo [stamped]"]
```

## 5. Deliver by two routes

Hal's two couriers — one by ferry, one by bicycle — set off at the same time.
Define the function `deliver-both` that takes two functions of no arguments, the couriers' rounds, runs them at the same time, and returns an array of their two results, the first courier's first.

```janet
(deliver-both (fn [] (ev/sleep 0.1) :island) (fn [] :village))
# => @[:island :village]
```
