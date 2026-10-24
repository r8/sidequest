(import test :as t)
(import ../gigasecond :as sol)

(t/deftest "date only specification of time"
  (t/assert-equal "2043-01-01T01:46:40" (sol/add "2011-04-25")))

(t/deftest "second test for date only specification of time"
  (t/assert-equal "2009-02-19T01:46:40" (sol/add "1977-06-13")))

(t/deftest "third test for date only specification of time"
  (t/assert-equal "1991-03-27T01:46:40" (sol/add "1959-07-19")))

(t/deftest "full time specified"
  (t/assert-equal "2046-10-02T23:46:40" (sol/add "2015-01-24T22:00:00")))

(t/deftest "full time with day roll-over"
  (t/assert-equal "2046-10-03T01:46:39" (sol/add "2015-01-24T23:59:59")))

(t/run)
