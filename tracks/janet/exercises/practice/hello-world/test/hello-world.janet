(import test :as t)
(import ../hello-world :as sol)

(t/deftest "Say Hi!"
  (t/assert-equal "Hello, World!" (sol/hello)))

(t/run)
