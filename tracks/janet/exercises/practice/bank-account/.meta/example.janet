# An account is a mutable table made by make-account. The other functions change or read it,
# and each errors with "account not open" unless the account is open.

(defn make-account
  "(make-account) -> a new account, not yet open"
  []
  @{:open false :balance 0})

(defn- check-open [account]
  (unless (account :open) (error "account not open")))

(defn- check-amount [amount]
  (unless (pos? amount) (error "amount must be greater than 0")))

(defn open
  "(open account) -> account, now open with a balance of 0; errors if it is already open"
  [account]
  (when (account :open) (error "account already open"))
  (merge-into account {:open true :balance 0}))

(defn close
  "(close account) -> account, now closed"
  [account]
  (check-open account)
  (put account :open false))

(defn balance
  "(balance account) -> the current balance"
  [account]
  (check-open account)
  (account :balance))

(defn deposit
  "(deposit account amount) -> account, with amount added to the balance"
  [account amount]
  (check-open account)
  (check-amount amount)
  (update account :balance + amount))

(defn withdraw
  "(withdraw account amount) -> account, with amount taken from the balance"
  [account amount]
  (check-open account)
  (check-amount amount)
  (when (> amount (account :balance)) (error "amount must be less than balance"))
  (update account :balance - amount))
