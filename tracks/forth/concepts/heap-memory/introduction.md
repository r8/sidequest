# Introduction

The heap holds memory that a program asks for at run time and gives back when it is done:

| Word | Stack effect |
| --- | --- |
| `allocate` | `( u -- addr ior )` |
| `free` | `( addr -- ior )` |
| `resize` | `( addr u -- addr2 ior )` |

Sizes are in address units (`chars`, `cells`), the memory is not cleared, and each word leaves an _ior_: 0 for success, an error code otherwise.
`allocate throw` stops with the error when there is one.
`resize` may move the block, so only the new address is valid afterwards.

A word that returns allocated memory hands the caller the job of freeing it, exactly once; say so in its comment.
