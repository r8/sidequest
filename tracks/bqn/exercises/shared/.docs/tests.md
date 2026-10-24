# Tests

Run the tests with:

```sh
npx quest test bqn/<slug>
```

The tests always run against the track's canonical test file, so editing your copy in `test/` changes nothing.
Exported functions are capitalised (`Distance ⇐ …`); booleans are `1` and `0`; errors are raised with
`"message" ! 0`. An `ERROR` means the code raised an error, such as the stub's `implement me`.
