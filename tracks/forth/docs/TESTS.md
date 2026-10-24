# Tests

Run an exercise's tests from the repository root:

```sh
npx quest test forth/<slug>
```

A test file loads the harness and the solution with `require ../lib/test.fs` and `require ../<slug>.fs`,
defines each case as `test" name" … ;test`, and ends with `end-tests`.
Assertions take the actual value first: `2000 leap-year? assert-true`, `5 square-of-sum 225 assert=`,
`0 ['] square -24 assert-throws`. A case whose arguments are strings throws through a helper word,
`: too-long s" AATG" s" AAA" distance ;` then `['] too-long -24 assert-xt-throws`.
Lists of numbers are arrays of cells, compared with `assert-cells=` ( addr1 n1 addr2 n2 -- ); strings
with `assert-str=` ( c-addr1 u1 c-addr2 u2 -- ); floats with `assert-f~`.
A test must leave the stack as it found it.

Test files are named `test/<slug>-test.fs`.
