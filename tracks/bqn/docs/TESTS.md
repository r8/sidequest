# Tests

Run an exercise's tests from the repository root:

```sh
npx quest test bqn/<slug>
```

A test file imports the harness and the solution with `•Import`, and calls `t.Run` on a list of
`"name"‿{𝕊: …}` pairs. Assertions take the expected value on the left: `0 t.Expect "" g.Distance ""`,
`31.69 t.Approx …`, and `{𝕊: …} t._throws "message"` for errors.
