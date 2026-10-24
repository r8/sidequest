# Tests

Run an exercise's tests from the repository root:

```sh
npx quest test koka/<slug>
```

Each test file imports the harness with `import test` and the solution with `import <slug>`, and its `main` calls
`run([...])` with one `test("name") { ... }` per case.
The harness runs the tests in order and prints one line per test, starting with `PASS`, `FAIL` or `ERROR`.

Test files are named `test/<slug>-test.kk`, not `test/<slug>.kk`: Koka resolves `import <slug>` relative to the
importing file first, so a test file with the solution's name would import itself.
