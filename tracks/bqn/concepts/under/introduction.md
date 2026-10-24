# Introduction

Under, `F⌾G`, changes part of an array and leaves the rest alone. `G` picks out the part, `F` changes it, and
`⌾` puts the result back:

```bqn
-⟜32⌾(0‿6⊸⊏) "hello world"    # "Hello World"
'█'¨⌾(0‿1‿1⊸/) "abc"           # "a██"
10⊸×⌾⊑ 1‿2‿3                   # ⟨10, 2, 3⟩
```

`F` must return an array of the same shape as the part, so `'█'¨` rather than `'█'`. When `G` is an
invertible arithmetic function, Under applies `G`, then `F`, then the inverse of `G`: `⌊⌾(100⊸×) 3.14159` is
`3.14`. With two arguments, `G` is applied to both, `F` combines the parts, and they are put back into the
right argument.
