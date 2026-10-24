# Tests

Run an exercise's tests from the repository root:

```sh
npx quest test janet/<slug>
```

Each test file imports the harness with `(import test :as t)` and the solution with `(import ../<slug> :as sol)`,
defines cases with `t/deftest`, and ends with `(t/run)`.
The harness runs the tests in order and prints one line per test, starting with `PASS`, `FAIL` or `ERROR`.

To run a test file directly, from the exercise directory:

```sh
JANET_PATH=<track>/lib janet test/<slug>.janet
```
