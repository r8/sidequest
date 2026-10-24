import test
import bank-account

pub fun main()
  run([
    test("Newly opened account has zero balance") { assert-equal(0, new-account().open.balance) },
    test("Single deposit") { assert-equal(100, new-account().open.deposit(100).balance) },
    test("Multiple deposits") { assert-equal(150, new-account().open.deposit(100).deposit(50).balance) },
    test("Withdraw once") { assert-equal(25, new-account().open.deposit(100).withdraw(75).balance) },
    test("Withdraw twice") { assert-equal(0, new-account().open.deposit(100).withdraw(80).withdraw(20).balance) },
    test("Can do multiple operations sequentially") {
      assert-equal(20, new-account().open.deposit(100).deposit(110).withdraw(200).deposit(60).withdraw(50).balance)
    },
    test("Cannot check balance of closed account") {
      assert-throws("account not open") { new-account().open.close.balance }
    },
    test("Cannot deposit into closed account") {
      assert-throws("account not open") { new-account().open.close.deposit(50) }
    },
    test("Cannot deposit into unopened account") {
      assert-throws("account not open") { new-account().deposit(50) }
    },
    test("Cannot withdraw from closed account") {
      assert-throws("account not open") { new-account().open.close.withdraw(50) }
    },
    test("Cannot close an account that was not opened") {
      assert-throws("account not open") { new-account().close }
    },
    test("Cannot open an already opened account") {
      assert-throws("account already open") { new-account().open.open }
    },
    test("Reopened account does not retain balance") {
      assert-equal(0, new-account().open.deposit(50).close.open.balance)
    },
    test("Cannot withdraw more than deposited") {
      assert-throws("amount must be less than balance") { new-account().open.deposit(25).withdraw(50) }
    },
    test("Cannot withdraw negative") {
      assert-throws("amount must be greater than 0") { new-account().open.deposit(100).withdraw(-50) }
    },
    test("Cannot deposit negative") {
      assert-throws("amount must be greater than 0") { new-account().open.deposit(-50) }
    },
    // An account is an immutable value, so there is nothing to share between threads: this runs the
    // canonical 1000 deposit/withdraw pairs one after another.
    test("Can handle concurrent transactions") {
      val account = list(1, 1000).foldl(new-account().open, fn(a, _) a.deposit(1).withdraw(1))
      assert-equal(0, account.balance)
    },
  ])
