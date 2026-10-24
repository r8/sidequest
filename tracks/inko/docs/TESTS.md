# Tests

Run an exercise's tests from the repository root:

```sh
npx quest test inko/<slug>
```

Tests are plain `std.test` tests: `test/test_<slug>.inko` defines `fn pub tests(t: mut Tests)` and registers each
case with `t.test('name', fn (t) { t.equal(got, expected) })`. Inside an exercise directory, `inko test` runs them
directly. Tests run concurrently; results are reported in the order the test file defines them.

A panic ends the whole test process, so when one happens `quest test` runs each test on its own to tell which
ones panic.
