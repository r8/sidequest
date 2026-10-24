# A small test harness for the Janet track. It needs nothing beyond the janet binary.
#
#   (import test :as t)
#   (import ../two-fer :as sol)
#
#   (t/deftest "no name given"
#     (t/assert-equal "One for you, one for me." (sol/two-fer)))
#
#   (t/run)
#
# `run` executes the tests in definition order and prints one machine-readable line per test,
# then a summary line, and exits 1 if anything failed or errored:
#
#   PASS<TAB><name><TAB><TAB><output>
#   FAIL<TAB><name><TAB><expected/got message><TAB><output>
#   ERROR<TAB><name><TAB><error message><TAB><output>
#   SUMMARY<TAB><passed><TAB><failed><TAB><errored>
#
# <output> is whatever the test printed. Inside every field, backslash, tab, newline and carriage
# return are escaped as \\ \t \n \r, so a line is always exactly one record. Every record and the
# summary start on a fresh line, so output the solution printed at load time without a trailing
# newline cannot swallow one (blank lines in between mean nothing).

(def- tests @[])
(def- failure @"quest/assertion-failed")

(defn register
  "Adds a test. Use the deftest macro instead."
  [name f]
  (assert (bytes? name) "deftest: the test name must be a string")
  (array/push tests [(string name) f]))

(defmacro deftest
  "Defines a test case named `name` whose body is `body`."
  [name & body]
  ~(,register ,name (fn [] ,;body)))

(defn- fail [message]
  (error [failure message]))

(defn- normalize
  "Arrays and tuples, tables and structs, buffers and strings compare equal by content."
  [x]
  (case (type x)
    :array (tuple ;(map normalize x))
    :tuple (tuple ;(map normalize x))
    :buffer (string x)
    :table (do
             (def t @{})
             (eachp [k v] x (put t (normalize k) (normalize v)))
             (table/to-struct t))
    :struct (do
              (def t @{})
              (eachp [k v] x (put t (normalize k) (normalize v)))
              (table/to-struct t))
    x))

(defn- describe [x]
  (if (bytes? x) (string x) (string/format "%q" x)))

(defn assert-equal
  "Passes when `actual` equals `expected` by content."
  [expected actual]
  (unless (deep= (normalize expected) (normalize actual))
    (fail (string/format "expected %q, got %q" expected actual))))

(defn assert-true
  "Passes when `x` is truthy."
  [x &opt message]
  (unless x
    (fail (or message (string/format "expected a truthy value, got %q" x)))))

(defn assert-false
  "Passes when `x` is false or nil."
  [x &opt message]
  (when x
    (fail (or message (string/format "expected false or nil, got %q" x)))))

(defn check-error
  "Passes when calling `thunk` raises an error; when `expected` is not nil, its message must equal it."
  [expected thunk]
  (def [raised value] (try [false (thunk)] ([err] [true err])))
  (cond
    (not raised) (fail (string/format "expected an error, got %q" value))
    (and expected (not= expected (describe value)))
    (fail (string/format "expected error %q, got error %q" expected (describe value)))))

(defmacro assert-error
  "Passes when `body` raises an error whose message is `expected` (any error when `expected` is nil)."
  [expected & body]
  ~(,check-error ,expected (fn [] ,;body)))

(defn- escape [s]
  (->> (string s)
       (string/replace-all "\\" "\\\\")
       (string/replace-all "\t" "\\t")
       (string/replace-all "\n" "\\n")
       (string/replace-all "\r" "\\r")))

(defn run
  "Runs every test in definition order, reports, and exits 1 if anything failed or errored."
  []
  (var passed 0)
  (var failed 0)
  (var errored 0)
  (each [name f] tests
    (def output @"")
    (def [status message]
      (try
        (do
          (with-dyns [:out output :err output] (f))
          ["PASS" ""])
        ([err]
          (if (and (tuple? err) (= (length err) 2) (= (err 0) failure))
            ["FAIL" (err 1)]
            ["ERROR" (describe err)]))))
    (case status
      "PASS" (++ passed)
      "FAIL" (++ failed)
      (++ errored))
    (print "\n" (string/join [status (escape name) (escape message) (escape output)] "\t")))
  (print "\n" (string/join ["SUMMARY" (string passed) (string failed) (string errored)] "\t"))
  (flush)
  (os/exit (if (= 0 (+ failed errored)) 0 1)))
