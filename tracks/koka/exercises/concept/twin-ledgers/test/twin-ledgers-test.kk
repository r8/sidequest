import test
import twin-ledgers

pub fun main()
  run([
    test("1. a new ledger shows its opening balance") { assert-equal(100, open-ledger(100, fn(l) l.balance)) },
    test("1. recording changes the balance") {
      assert-equal(130, open-ledger(100, fn(l) { l.record(50); l.record(-20); l.balance }))
    },
    test("1. gives back what the program returns") { assert-equal("done", open-ledger(0, fn(_) "done")) },
    test("1. two ledgers keep separate balances") {
      assert-equal((11, 22), open-ledger(10, fn(a) open-ledger(20, fn(b) { a.record(1); b.record(2); (a.balance, b.balance) })))
    },
    test("2. moves money from one ledger to the other") {
      assert-equal((70, 30), open-ledger(100, fn(a) open-ledger(0, fn(b) { transfer(a, b, 30); (a.balance, b.balance) })))
    },
    test("2. a negative amount moves money back") {
      assert-equal((110, -10), open-ledger(100, fn(a) open-ledger(0, fn(b) { transfer(a, b, -10); (a.balance, b.balance) })))
    },
    test("2. a transfer within one ledger changes nothing") {
      assert-equal(40, open-ledger(40, fn(a) { transfer(a, a, 15); a.balance }))
    },
    test("3. banks the takings above the float") {
      assert-equal((130, 50, 330), open-ledger(180, fn(till) open-ledger(200, fn(safe) {
        val moved = bank-takings(till, safe, 50)
        (moved, till.balance, safe.balance)
      })))
    },
    test("3. nothing to bank below the float") {
      assert-equal((0, 30, 200), open-ledger(30, fn(till) open-ledger(200, fn(safe) {
        val moved = bank-takings(till, safe, 50)
        (moved, till.balance, safe.balance)
      })))
    },
    test("3. nothing to bank at exactly the float") {
      assert-equal((0, 50, 0), open-ledger(50, fn(till) open-ledger(0, fn(safe) {
        val moved = bank-takings(till, safe, 50)
        (moved, till.balance, safe.balance)
      })))
    },
    test("4. no ledgers add up to nothing") { assert-equal(0, audit([])) },
    test("4. the balances of three ledgers") {
      assert-equal(60, open-ledger(10, fn(a) open-ledger(20, fn(b) open-ledger(30, fn(c) audit([a, b, c])))))
    },
    test("4. transfers between ledgers do not change the total") {
      assert-equal(30, open-ledger(10, fn(a) open-ledger(20, fn(b) { transfer(a, b, 25); audit([a, b]) })))
    },
    test("5. pairs the result with the final balance") {
      assert-equal(("ok", 15), closing-balance(10, fn(l) { l.record(5); "ok" }))
    },
    test("5. an untouched ledger closes at its opening balance") {
      assert-equal(((), 7), closing-balance(7, fn(_) ()))
    },
    test("5. a safe closes with the banked takings") {
      assert-equal((80, 80), closing-balance(0, fn(safe) open-ledger(100, fn(till) bank-takings(till, safe, 20))))
    },
  ])
