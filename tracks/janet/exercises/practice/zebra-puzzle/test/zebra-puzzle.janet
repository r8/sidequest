(import test :as t)
(import ../zebra-puzzle :as sol)

(t/deftest "resident who drinks water"
  (t/assert-equal :norwegian (sol/drinks-water)))

(t/deftest "resident who owns zebra"
  (t/assert-equal :japanese (sol/owns-zebra)))

(t/run)
