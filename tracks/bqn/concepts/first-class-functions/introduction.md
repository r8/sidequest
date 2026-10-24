# Introduction

Functions are values. Spelled with a capital they are called; spelled in lowercase they are subjects that can
be stored in lists, passed as arguments and returned:

```bqn
Double ← 2⊸×
⟨double, -⟩            # a list of functions
{𝕏 4}¨ ⟨double, -⟩     # ⟨8, ¯4⟩: 𝕏 calls the argument
Adder ← {𝕩⊸+}
add ← Adder 5
Add 3                  # 8
```

A function must be defined under a capitalised name (`double ← 2⊸×` is a role error). The result of a call is
a subject, so name it with a capital to call it.
