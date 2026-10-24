# An account is a mutable table made by make-account. The other functions change or read it,
# and each errors with "account not open" unless the account is open.

(defn make-account
  "(make-account) -> a new account, not yet open"
  []
  (error "implement me"))

(defn open
  "(open account) -> account, now open with a balance of 0; errors if it is already open"
  [account]
  (error "implement me"))

(defn close
  "(close account) -> account, now closed"
  [account]
  (error "implement me"))

(defn balance
  "(balance account) -> the current balance"
  [account]
  (error "implement me"))

(defn deposit
  "(deposit account amount) -> account, with amount added to the balance"
  [account amount]
  (error "implement me"))

(defn withdraw
  "(withdraw account amount) -> account, with amount taken from the balance"
  [account amount]
  (error "implement me"))
