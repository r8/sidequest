(import test :as t)
(import ../react :as sol)

(t/deftest "input cells have a value"
  (def input (sol/input-cell 10))
  (t/assert-equal 10 (sol/value input)))

(t/deftest "an input cell's value can be set"
  (def input (sol/input-cell 4))
  (sol/set-value input 20)
  (t/assert-equal 20 (sol/value input)))

(t/deftest "compute cells calculate initial value"
  (def input (sol/input-cell 1))
  (def output (sol/compute-cell (fn [x] (+ x 1)) [input]))
  (t/assert-equal 2 (sol/value output)))

(t/deftest "compute cells take inputs in the right order"
  (def one (sol/input-cell 1))
  (def two (sol/input-cell 2))
  (def output (sol/compute-cell (fn [x y] (+ x (* y 10))) [one two]))
  (t/assert-equal 21 (sol/value output)))

(t/deftest "compute cells update value when dependencies are changed"
  (def input (sol/input-cell 1))
  (def output (sol/compute-cell (fn [x] (+ x 1)) [input]))
  (sol/set-value input 3)
  (t/assert-equal 4 (sol/value output)))

(t/deftest "compute cells can depend on other compute cells"
  (def input (sol/input-cell 1))
  (def times-two (sol/compute-cell (fn [x] (* x 2)) [input]))
  (def times-thirty (sol/compute-cell (fn [x] (* x 30)) [input]))
  (def output (sol/compute-cell (fn [x y] (+ x y)) [times-two times-thirty]))
  (t/assert-equal 32 (sol/value output))
  (sol/set-value input 3)
  (t/assert-equal 96 (sol/value output)))

# Each callback records the values it is called with, so a test can check how often it ran.

(t/deftest "compute cells fire callbacks"
  (def input (sol/input-cell 1))
  (def output (sol/compute-cell (fn [x] (+ x 1)) [input]))
  (def calls1 @[])
  (defn callback1 [v] (array/push calls1 v))
  (sol/add-callback output callback1)
  (sol/set-value input 3)
  (t/assert-equal [4] calls1))

(t/deftest "callback cells only fire on change"
  (def input (sol/input-cell 1))
  (def output (sol/compute-cell (fn [x] (if (< x 3) 111 222)) [input]))
  (def calls1 @[])
  (defn callback1 [v] (array/push calls1 v))
  (sol/add-callback output callback1)
  (sol/set-value input 2)
  (t/assert-equal [] calls1)
  (sol/set-value input 4)
  (t/assert-equal [222] calls1))

(t/deftest "callbacks do not report already reported values"
  (def input (sol/input-cell 1))
  (def output (sol/compute-cell (fn [x] (+ x 1)) [input]))
  (def calls1 @[])
  (defn callback1 [v] (array/push calls1 v))
  (sol/add-callback output callback1)
  (sol/set-value input 2)
  (t/assert-equal [3] calls1)
  (sol/set-value input 3)
  (t/assert-equal [3 4] calls1))

(t/deftest "callbacks can fire from multiple cells"
  (def input (sol/input-cell 1))
  (def plus-one (sol/compute-cell (fn [x] (+ x 1)) [input]))
  (def minus-one (sol/compute-cell (fn [x] (- x 1)) [input]))
  (def calls1 @[])
  (defn callback1 [v] (array/push calls1 v))
  (def calls2 @[])
  (defn callback2 [v] (array/push calls2 v))
  (sol/add-callback plus-one callback1)
  (sol/add-callback minus-one callback2)
  (sol/set-value input 10)
  (t/assert-equal [11] calls1)
  (t/assert-equal [9] calls2))

(t/deftest "callbacks can be added and removed"
  (def input (sol/input-cell 11))
  (def output (sol/compute-cell (fn [x] (+ x 1)) [input]))
  (def calls1 @[])
  (defn callback1 [v] (array/push calls1 v))
  (def calls2 @[])
  (defn callback2 [v] (array/push calls2 v))
  (def calls3 @[])
  (defn callback3 [v] (array/push calls3 v))
  (sol/add-callback output callback1)
  (sol/add-callback output callback2)
  (sol/set-value input 31)
  (t/assert-equal [32] calls1)
  (t/assert-equal [32] calls2)
  (sol/remove-callback output callback1)
  (sol/add-callback output callback3)
  (sol/set-value input 41)
  (t/assert-equal [32] calls1)
  (t/assert-equal [32 42] calls2)
  (t/assert-equal [42] calls3))

(t/deftest "removing a callback multiple times doesn't interfere with other callbacks"
  (def input (sol/input-cell 1))
  (def output (sol/compute-cell (fn [x] (+ x 1)) [input]))
  (def calls1 @[])
  (defn callback1 [v] (array/push calls1 v))
  (def calls2 @[])
  (defn callback2 [v] (array/push calls2 v))
  (sol/add-callback output callback1)
  (sol/add-callback output callback2)
  (sol/remove-callback output callback1)
  (sol/remove-callback output callback1)
  (sol/remove-callback output callback1)
  (sol/set-value input 2)
  (t/assert-equal [3] calls2)
  (t/assert-equal [] calls1))

(t/deftest "callbacks should only be called once even if multiple dependencies change"
  (def input (sol/input-cell 1))
  (def plus-one (sol/compute-cell (fn [x] (+ x 1)) [input]))
  (def minus-one1 (sol/compute-cell (fn [x] (- x 1)) [input]))
  (def minus-one2 (sol/compute-cell (fn [x] (- x 1)) [minus-one1]))
  (def output (sol/compute-cell (fn [x y] (* x y)) [plus-one minus-one2]))
  (def calls1 @[])
  (defn callback1 [v] (array/push calls1 v))
  (sol/add-callback output callback1)
  (sol/set-value input 4)
  (t/assert-equal [10] calls1))

(t/deftest "callbacks should not be called if dependencies change but output value doesn't change"
  (def input (sol/input-cell 1))
  (def plus-one (sol/compute-cell (fn [x] (+ x 1)) [input]))
  (def minus-one (sol/compute-cell (fn [x] (- x 1)) [input]))
  (def always-two (sol/compute-cell (fn [x y] (- x y)) [plus-one minus-one]))
  (def calls1 @[])
  (defn callback1 [v] (array/push calls1 v))
  (sol/add-callback always-two callback1)
  (sol/set-value input 2)
  (sol/set-value input 3)
  (sol/set-value input 4)
  (sol/set-value input 5)
  (t/assert-equal [] calls1))

(t/run)
