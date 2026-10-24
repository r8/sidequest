# Introduction

`throw ( code -- )` abandons the current word, and every word that called it, up to the nearest `catch`; a code of 0 does nothing, so `throw` can follow any word that returns a result code.

`catch ( i*x xt -- j*x 0 | i*x code )` runs `xt`.
If it finishes, `catch` adds 0 to what it left; if it throws, `catch` restores the stack depths it started with and pushes the code.

```forth
: halve-even ( n -- n/2 ) dup 1 and if 7 throw then 2/ ;

6 ' halve-even catch   \ 3 0
5 ' halve-even catch   \ x 7 — x is a placeholder: drop it
```

Codes -1 to -255 are the system's (-10 division by zero, -24 invalid numeric argument); a program names its own with `constant`.
`flag abort" message"` throws -2 with a message when the flag is true.
To clean up whatever happens, catch, clean up, and `throw` the code again.
