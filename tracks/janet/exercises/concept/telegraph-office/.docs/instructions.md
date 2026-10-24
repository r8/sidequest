# Instructions

In the last telegraph office of the valley, Pavel still taps out a few telegrams a week, mostly for weddings and for tourists who want something to frame.
A telegram is written in capitals, with every sentence ending in the word `STOP`, and the office's rule is that no telegram may carry a number in digits.
Pavel builds each telegram in a buffer as the customer dictates it; you are writing the tools he uses.

## 1. Start a telegram

Define the function `start-telegram` that takes the name of the person the telegram is for and returns a new buffer holding the line `TO ` followed by the name in capitals and a newline.

```janet
(start-telegram "Mrs Novak")
# => @"TO MRS NOVAK\n"
```

## 2. Add a sentence

Define the function `add-sentence!` that takes a telegram buffer and a sentence, appends the sentence in capitals followed by ` STOP` and a newline, and returns the same buffer.

```janet
(add-sentence! @"TO MRS NOVAK\n" "Arriving Tuesday")
# => @"TO MRS NOVAK\nARRIVING TUESDAY STOP\n"
```

## 3. Hide the digits

Define the function `censor!` that takes a telegram buffer, replaces every digit in it with `#` in place, and returns the same buffer.

```janet
(censor! @"MEET AT 10 STOP\n")
# => @"MEET AT ## STOP\n"
```

## 4. Send the telegram

When a telegram is sent, Pavel keeps the buffer to write the next one.
Define the function `send!` that takes a telegram buffer, returns its contents as a string, and leaves the buffer empty.

```janet
(def telegram @"TO ALBA\nWELL DONE STOP\n")
(send! telegram)
# => "TO ALBA\nWELL DONE STOP\n"
telegram
# => @""
```
