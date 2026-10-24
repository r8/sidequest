(import test :as t)
(import ../bank-account :as sol)

(t/deftest "Newly opened account has zero balance"
  (def account (sol/make-account))
  (sol/open account)
  (t/assert-equal 0 (sol/balance account)))

(t/deftest "Single deposit"
  (def account (sol/make-account))
  (sol/open account)
  (sol/deposit account 100)
  (t/assert-equal 100 (sol/balance account)))

(t/deftest "Multiple deposits"
  (def account (sol/make-account))
  (sol/open account)
  (sol/deposit account 100)
  (sol/deposit account 50)
  (t/assert-equal 150 (sol/balance account)))

(t/deftest "Withdraw once"
  (def account (sol/make-account))
  (sol/open account)
  (sol/deposit account 100)
  (sol/withdraw account 75)
  (t/assert-equal 25 (sol/balance account)))

(t/deftest "Withdraw twice"
  (def account (sol/make-account))
  (sol/open account)
  (sol/deposit account 100)
  (sol/withdraw account 80)
  (sol/withdraw account 20)
  (t/assert-equal 0 (sol/balance account)))

(t/deftest "Can do multiple operations sequentially"
  (def account (sol/make-account))
  (sol/open account)
  (sol/deposit account 100)
  (sol/deposit account 110)
  (sol/withdraw account 200)
  (sol/deposit account 60)
  (sol/withdraw account 50)
  (t/assert-equal 20 (sol/balance account)))
(t/deftest "Cannot check balance of closed account"
  (def account (sol/make-account))
  (sol/open account)
  (sol/close account)
  (t/assert-error "account not open" (sol/balance account)))

(t/deftest "Cannot deposit into closed account"
  (def account (sol/make-account))
  (sol/open account)
  (sol/close account)
  (t/assert-error "account not open" (sol/deposit account 50)))

(t/deftest "Cannot deposit into unopened account"
  (def account (sol/make-account))
  (t/assert-error "account not open" (sol/deposit account 50)))

(t/deftest "Cannot withdraw from closed account"
  (def account (sol/make-account))
  (sol/open account)
  (sol/close account)
  (t/assert-error "account not open" (sol/withdraw account 50)))

(t/deftest "Cannot close an account that was not opened"
  (def account (sol/make-account))
  (t/assert-error "account not open" (sol/close account)))

(t/deftest "Cannot open an already opened account"
  (def account (sol/make-account))
  (sol/open account)
  (t/assert-error "account already open" (sol/open account)))

(t/deftest "Reopened account does not retain balance"
  (def account (sol/make-account))
  (sol/open account)
  (sol/deposit account 50)
  (sol/close account)
  (sol/open account)
  (t/assert-equal 0 (sol/balance account)))

(t/deftest "Cannot withdraw more than deposited"
  (def account (sol/make-account))
  (sol/open account)
  (sol/deposit account 25)
  (t/assert-error "amount must be less than balance" (sol/withdraw account 50)))

(t/deftest "Cannot withdraw negative"
  (def account (sol/make-account))
  (sol/open account)
  (sol/deposit account 100)
  (t/assert-error "amount must be greater than 0" (sol/withdraw account -50)))

(t/deftest "Cannot deposit negative"
  (def account (sol/make-account))
  (sol/open account)
  (t/assert-error "amount must be greater than 0" (sol/deposit account -50)))

(t/deftest "Can handle concurrent transactions"
  (def account (sol/make-account))
  (sol/open account)
  # 1000 fibers on the event loop, each depositing 1, yielding, then withdrawing 1
  (def results (ev/chan 1000))
  (repeat 1000
    (ev/spawn
      (ev/give results (try (do (sol/deposit account 1)
                                (ev/sleep 0)
                                (sol/withdraw account 1)
                                :ok)
                            ([err] err)))))
  (repeat 1000 (t/assert-equal :ok (ev/take results)))
  (t/assert-equal 0 (sol/balance account)))

(t/run)
