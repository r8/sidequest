(import test :as t)
(import ../split-second-stopwatch :as sol)

(t/deftest "new stopwatch starts in ready state"
  (def stopwatch (sol/make-stopwatch))
  (t/assert-equal :ready (sol/state stopwatch)))

(t/deftest "new stopwatch's current lap has no elapsed time"
  (def stopwatch (sol/make-stopwatch))
  (t/assert-equal "00:00:00" (sol/current-lap stopwatch)))

(t/deftest "new stopwatch's total has no elapsed time"
  (def stopwatch (sol/make-stopwatch))
  (t/assert-equal "00:00:00" (sol/total stopwatch)))

(t/deftest "new stopwatch does not have previous laps"
  (def stopwatch (sol/make-stopwatch))
  (t/assert-equal [] (sol/previous-laps stopwatch)))

(t/deftest "start from ready state changes state to running"
  (def stopwatch (sol/make-stopwatch))
  (sol/start stopwatch)
  (t/assert-equal :running (sol/state stopwatch)))

(t/deftest "start does not change previous laps"
  (def stopwatch (sol/make-stopwatch))
  (sol/start stopwatch)
  (t/assert-equal [] (sol/previous-laps stopwatch)))

(t/deftest "start initiates time tracking for current lap"
  (def stopwatch (sol/make-stopwatch))
  (sol/start stopwatch)
  (sol/advance-time stopwatch "00:00:05")
  (t/assert-equal "00:00:05" (sol/current-lap stopwatch)))

(t/deftest "start initiates time tracking for total"
  (def stopwatch (sol/make-stopwatch))
  (sol/start stopwatch)
  (sol/advance-time stopwatch "00:00:23")
  (t/assert-equal "00:00:23" (sol/total stopwatch)))

(t/deftest "start cannot be called from running state"
  (def stopwatch (sol/make-stopwatch))
  (sol/start stopwatch)
  (t/assert-error "cannot start an already running stopwatch" (sol/start stopwatch)))

(t/deftest "stop from running state changes state to stopped"
  (def stopwatch (sol/make-stopwatch))
  (sol/start stopwatch)
  (sol/stop stopwatch)
  (t/assert-equal :stopped (sol/state stopwatch)))

(t/deftest "stop pauses time tracking for current lap"
  (def stopwatch (sol/make-stopwatch))
  (sol/start stopwatch)
  (sol/advance-time stopwatch "00:00:05")
  (sol/stop stopwatch)
  (sol/advance-time stopwatch "00:00:08")
  (t/assert-equal "00:00:05" (sol/current-lap stopwatch)))

(t/deftest "stop pauses time tracking for total"
  (def stopwatch (sol/make-stopwatch))
  (sol/start stopwatch)
  (sol/advance-time stopwatch "00:00:13")
  (sol/stop stopwatch)
  (sol/advance-time stopwatch "00:00:44")
  (t/assert-equal "00:00:13" (sol/total stopwatch)))

(t/deftest "stop cannot be called from ready state"
  (def stopwatch (sol/make-stopwatch))
  (t/assert-error "cannot stop a stopwatch that is not running" (sol/stop stopwatch)))

(t/deftest "stop cannot be called from stopped state"
  (def stopwatch (sol/make-stopwatch))
  (sol/start stopwatch)
  (sol/stop stopwatch)
  (t/assert-error "cannot stop a stopwatch that is not running" (sol/stop stopwatch)))

(t/deftest "start from stopped state changes state to running"
  (def stopwatch (sol/make-stopwatch))
  (sol/start stopwatch)
  (sol/stop stopwatch)
  (sol/start stopwatch)
  (t/assert-equal :running (sol/state stopwatch)))

(t/deftest "start from stopped state resumes time tracking for current lap"
  (def stopwatch (sol/make-stopwatch))
  (sol/start stopwatch)
  (sol/advance-time stopwatch "00:01:20")
  (sol/stop stopwatch)
  (sol/advance-time stopwatch "00:00:20")
  (sol/start stopwatch)
  (sol/advance-time stopwatch "00:00:08")
  (t/assert-equal "00:01:28" (sol/current-lap stopwatch)))

(t/deftest "start from stopped state resumes time tracking for total"
  (def stopwatch (sol/make-stopwatch))
  (sol/start stopwatch)
  (sol/advance-time stopwatch "00:00:23")
  (sol/stop stopwatch)
  (sol/advance-time stopwatch "00:00:44")
  (sol/start stopwatch)
  (sol/advance-time stopwatch "00:00:09")
  (t/assert-equal "00:00:32" (sol/total stopwatch)))

(t/deftest "lap adds current lap to previous laps"
  (def stopwatch (sol/make-stopwatch))
  (sol/start stopwatch)
  (sol/advance-time stopwatch "00:01:38")
  (sol/lap stopwatch)
  (t/assert-equal ["00:01:38"] (sol/previous-laps stopwatch))
  (sol/advance-time stopwatch "00:00:44")
  (sol/lap stopwatch)
  (t/assert-equal ["00:01:38" "00:00:44"] (sol/previous-laps stopwatch)))

(t/deftest "lap resets current lap and resumes time tracking"
  (def stopwatch (sol/make-stopwatch))
  (sol/start stopwatch)
  (sol/advance-time stopwatch "00:08:22")
  (sol/lap stopwatch)
  (t/assert-equal "00:00:00" (sol/current-lap stopwatch))
  (sol/advance-time stopwatch "00:00:15")
  (t/assert-equal "00:00:15" (sol/current-lap stopwatch)))

(t/deftest "lap continues time tracking for total"
  (def stopwatch (sol/make-stopwatch))
  (sol/start stopwatch)
  (sol/advance-time stopwatch "00:00:22")
  (sol/lap stopwatch)
  (sol/advance-time stopwatch "00:00:33")
  (t/assert-equal "00:00:55" (sol/total stopwatch)))

(t/deftest "lap cannot be called from ready state"
  (def stopwatch (sol/make-stopwatch))
  (t/assert-error "cannot lap a stopwatch that is not running" (sol/lap stopwatch)))

(t/deftest "lap cannot be called from stopped state"
  (def stopwatch (sol/make-stopwatch))
  (sol/start stopwatch)
  (sol/stop stopwatch)
  (t/assert-error "cannot lap a stopwatch that is not running" (sol/lap stopwatch)))

(t/deftest "stop does not change previous laps"
  (def stopwatch (sol/make-stopwatch))
  (sol/start stopwatch)
  (sol/advance-time stopwatch "00:11:22")
  (sol/lap stopwatch)
  (t/assert-equal ["00:11:22"] (sol/previous-laps stopwatch))
  (sol/stop stopwatch)
  (t/assert-equal ["00:11:22"] (sol/previous-laps stopwatch)))

(t/deftest "reset from stopped state changes state to ready"
  (def stopwatch (sol/make-stopwatch))
  (sol/start stopwatch)
  (sol/stop stopwatch)
  (sol/reset stopwatch)
  (t/assert-equal :ready (sol/state stopwatch)))

(t/deftest "reset resets current lap"
  (def stopwatch (sol/make-stopwatch))
  (sol/start stopwatch)
  (sol/advance-time stopwatch "00:00:10")
  (sol/stop stopwatch)
  (sol/reset stopwatch)
  (t/assert-equal "00:00:00" (sol/current-lap stopwatch)))

(t/deftest "reset clears previous laps"
  (def stopwatch (sol/make-stopwatch))
  (sol/start stopwatch)
  (sol/advance-time stopwatch "00:00:10")
  (sol/lap stopwatch)
  (sol/advance-time stopwatch "00:00:20")
  (sol/lap stopwatch)
  (t/assert-equal ["00:00:10" "00:00:20"] (sol/previous-laps stopwatch))
  (sol/stop stopwatch)
  (sol/reset stopwatch)
  (t/assert-equal [] (sol/previous-laps stopwatch)))

(t/deftest "reset cannot be called from ready state"
  (def stopwatch (sol/make-stopwatch))
  (t/assert-error "cannot reset a stopwatch that is not stopped" (sol/reset stopwatch)))

(t/deftest "reset cannot be called from running state"
  (def stopwatch (sol/make-stopwatch))
  (sol/start stopwatch)
  (t/assert-error "cannot reset a stopwatch that is not stopped" (sol/reset stopwatch)))

(t/deftest "supports very long laps"
  (def stopwatch (sol/make-stopwatch))
  (sol/start stopwatch)
  (sol/advance-time stopwatch "01:23:45")
  (t/assert-equal "01:23:45" (sol/current-lap stopwatch))
  (sol/lap stopwatch)
  (t/assert-equal ["01:23:45"] (sol/previous-laps stopwatch))
  (sol/advance-time stopwatch "04:01:40")
  (t/assert-equal "04:01:40" (sol/current-lap stopwatch))
  (t/assert-equal "05:25:25" (sol/total stopwatch))
  (sol/lap stopwatch)
  (t/assert-equal ["01:23:45" "04:01:40"] (sol/previous-laps stopwatch))
  (sol/advance-time stopwatch "08:43:05")
  (t/assert-equal "08:43:05" (sol/current-lap stopwatch))
  (t/assert-equal "14:08:30" (sol/total stopwatch))
  (sol/lap stopwatch)
  (t/assert-equal ["01:23:45" "04:01:40" "08:43:05"] (sol/previous-laps stopwatch)))

(t/run)
