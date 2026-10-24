# Tests

Run the tests with:

```sh
npx quest test forth/<slug>
```

The tests always run against the track's canonical test file, so editing your copy in `test/` changes nothing.
An `ERROR` means a word threw (the stub's `implement me` is an `abort"`) or left the data or floating-point stack unbalanced.
Invalid input is signalled with `-24 throw` (invalid numeric argument).
