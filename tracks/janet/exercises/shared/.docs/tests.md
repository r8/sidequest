# Tests

Run the tests with:

```sh
npx quest test janet/<slug>
```

The tests always run against the track's canonical test file, so editing your copy in `test/` changes nothing.
A failing test prints the expected and the actual value; an `ERROR` means the code raised an error, such as the stub's `implement me`.
