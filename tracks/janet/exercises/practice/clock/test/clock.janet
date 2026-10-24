(import test :as t)
(import ../clock :as sol)

(t/deftest "on the hour"
  (t/assert-equal "08:00" (sol/to-string (sol/create 8 0))))

(t/deftest "past the hour"
  (t/assert-equal "11:09" (sol/to-string (sol/create 11 9))))

(t/deftest "midnight is zero hours"
  (t/assert-equal "00:00" (sol/to-string (sol/create 24 0))))

(t/deftest "hour rolls over"
  (t/assert-equal "01:00" (sol/to-string (sol/create 25 0))))

(t/deftest "hour rolls over continuously"
  (t/assert-equal "04:00" (sol/to-string (sol/create 100 0))))

(t/deftest "sixty minutes is next hour"
  (t/assert-equal "02:00" (sol/to-string (sol/create 1 60))))

(t/deftest "minutes roll over"
  (t/assert-equal "02:40" (sol/to-string (sol/create 0 160))))

(t/deftest "minutes roll over continuously"
  (t/assert-equal "04:43" (sol/to-string (sol/create 0 1723))))

(t/deftest "hour and minutes roll over"
  (t/assert-equal "03:40" (sol/to-string (sol/create 25 160))))

(t/deftest "hour and minutes roll over continuously"
  (t/assert-equal "11:01" (sol/to-string (sol/create 201 3001))))

(t/deftest "hour and minutes roll over to exactly midnight"
  (t/assert-equal "00:00" (sol/to-string (sol/create 72 8640))))

(t/deftest "negative hour"
  (t/assert-equal "23:15" (sol/to-string (sol/create -1 15))))

(t/deftest "negative hour rolls over"
  (t/assert-equal "23:00" (sol/to-string (sol/create -25 0))))

(t/deftest "negative hour rolls over continuously"
  (t/assert-equal "05:00" (sol/to-string (sol/create -91 0))))

(t/deftest "negative minutes"
  (t/assert-equal "00:20" (sol/to-string (sol/create 1 -40))))

(t/deftest "negative minutes roll over"
  (t/assert-equal "22:20" (sol/to-string (sol/create 1 -160))))

(t/deftest "negative minutes roll over continuously"
  (t/assert-equal "16:40" (sol/to-string (sol/create 1 -4820))))

(t/deftest "negative sixty minutes is previous hour"
  (t/assert-equal "01:00" (sol/to-string (sol/create 2 -60))))

(t/deftest "negative hour and minutes both roll over"
  (t/assert-equal "20:20" (sol/to-string (sol/create -25 -160))))

(t/deftest "negative hour and minutes both roll over continuously"
  (t/assert-equal "22:10" (sol/to-string (sol/create -121 -5810))))

(t/deftest "add minutes"
  (t/assert-equal "10:03" (sol/to-string (sol/add (sol/create 10 0) 3))))

(t/deftest "add no minutes"
  (t/assert-equal "06:41" (sol/to-string (sol/add (sol/create 6 41) 0))))

(t/deftest "add to next hour"
  (t/assert-equal "01:25" (sol/to-string (sol/add (sol/create 0 45) 40))))

(t/deftest "add more than one hour"
  (t/assert-equal "11:01" (sol/to-string (sol/add (sol/create 10 0) 61))))

(t/deftest "add more than two hours with carry"
  (t/assert-equal "03:25" (sol/to-string (sol/add (sol/create 0 45) 160))))

(t/deftest "add across midnight"
  (t/assert-equal "00:01" (sol/to-string (sol/add (sol/create 23 59) 2))))

(t/deftest "add more than one day (1500 min = 25 hrs)"
  (t/assert-equal "06:32" (sol/to-string (sol/add (sol/create 5 32) 1500))))

(t/deftest "add more than two days"
  (t/assert-equal "11:21" (sol/to-string (sol/add (sol/create 1 1) 3500))))

(t/deftest "subtract minutes"
  (t/assert-equal "10:00" (sol/to-string (sol/subtract (sol/create 10 3) 3))))

(t/deftest "subtract to previous hour"
  (t/assert-equal "09:33" (sol/to-string (sol/subtract (sol/create 10 3) 30))))

(t/deftest "subtract more than an hour"
  (t/assert-equal "08:53" (sol/to-string (sol/subtract (sol/create 10 3) 70))))

(t/deftest "subtract across midnight"
  (t/assert-equal "23:59" (sol/to-string (sol/subtract (sol/create 0 3) 4))))

(t/deftest "subtract more than two hours"
  (t/assert-equal "21:20" (sol/to-string (sol/subtract (sol/create 0 0) 160))))

(t/deftest "subtract more than two hours with borrow"
  (t/assert-equal "03:35" (sol/to-string (sol/subtract (sol/create 6 15) 160))))

(t/deftest "subtract more than one day (1500 min = 25 hrs)"
  (t/assert-equal "04:32" (sol/to-string (sol/subtract (sol/create 5 32) 1500))))

(t/deftest "subtract more than two days"
  (t/assert-equal "00:20" (sol/to-string (sol/subtract (sol/create 2 20) 3000))))

(t/deftest "clocks with same time"
  (t/assert-true (= (sol/create 15 37) (sol/create 15 37))))

(t/deftest "clocks a minute apart"
  (t/assert-false (= (sol/create 15 36) (sol/create 15 37))))

(t/deftest "clocks an hour apart"
  (t/assert-false (= (sol/create 14 37) (sol/create 15 37))))

(t/deftest "clocks with hour overflow"
  (t/assert-true (= (sol/create 10 37) (sol/create 34 37))))

(t/deftest "clocks with hour overflow by several days"
  (t/assert-true (= (sol/create 3 11) (sol/create 99 11))))

(t/deftest "clocks with negative hour"
  (t/assert-true (= (sol/create 22 40) (sol/create -2 40))))

(t/deftest "clocks with negative hour that wraps"
  (t/assert-true (= (sol/create 17 3) (sol/create -31 3))))

(t/deftest "clocks with negative hour that wraps multiple times"
  (t/assert-true (= (sol/create 13 49) (sol/create -83 49))))

(t/deftest "clocks with minute overflow"
  (t/assert-true (= (sol/create 0 1) (sol/create 0 1441))))

(t/deftest "clocks with minute overflow by several days"
  (t/assert-true (= (sol/create 2 2) (sol/create 2 4322))))

(t/deftest "clocks with negative minute"
  (t/assert-true (= (sol/create 2 40) (sol/create 3 -20))))

(t/deftest "clocks with negative minute that wraps"
  (t/assert-true (= (sol/create 4 10) (sol/create 5 -1490))))

(t/deftest "clocks with negative minute that wraps multiple times"
  (t/assert-true (= (sol/create 6 15) (sol/create 6 -4305))))

(t/deftest "clocks with negative hours and minutes"
  (t/assert-true (= (sol/create 7 32) (sol/create -12 -268))))

(t/deftest "clocks with negative hours and minutes that wrap"
  (t/assert-true (= (sol/create 18 7) (sol/create -54 -11513))))

(t/deftest "full clock and zeroed clock"
  (t/assert-true (= (sol/create 24 0) (sol/create 0 0))))

(t/run)
