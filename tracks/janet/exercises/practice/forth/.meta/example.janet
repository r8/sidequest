# instructions is an array of lines, each a sequence of words and integers separated by spaces.
# The resulting stack is an array with the bottom of the stack first and the top last.

(defn- quotient
  "a divided by b, rounded toward zero (div rounds down: -7 / 2 is -4)"
  [a b]
  (/ (- a (% a b)) b))

(defn- op
  "A built-in word: pops arity values, passes them to f bottom first and pushes what f returns."
  [arity f]
  (fn [stack]
    (case (length stack)
      0 (error "empty stack")
      1 (when (> arity 1) (error "only one value on the stack")))
    (def at (- (length stack) arity))
    (def args (slice stack at))
    (array/remove stack at arity)
    (array/concat stack (f ;args))))

(def- builtins
  {"+" (op 2 (fn [a b] [(+ a b)]))
   "-" (op 2 (fn [a b] [(- a b)]))
   "*" (op 2 (fn [a b] [(* a b)]))
   "/" (op 2 (fn [a b] (if (zero? b) (error "divide by zero") [(quotient a b)])))
   "dup" (op 1 (fn [a] [a a]))
   "drop" (op 1 (fn [a] []))
   "swap" (op 2 (fn [a b] [b a]))
   "over" (op 2 (fn [a b] [a b a]))})

# A number is an optional minus sign and ASCII digits; anything else, like 1.5 or 0x10, is a word.
(def- number-peg (peg/compile ~(* (? "-") :d+ -1)))

(defn- parse-number [token]
  (when (peg/match number-peg token) (scan-number token)))

(defn evaluate
  "(evaluate instructions) -> the stack left after running every line of instructions"
  [instructions]
  (def stack @[])
  # A user-defined word maps to the compiled functions of its body, resolved when it's defined,
  # so redefining a word later doesn't change the words already built on it.
  (def words @{})
  (defn compile [token]
    (if-let [n (parse-number token)]
      [(fn [stack] (array/push stack n))]
      (or (words token)
          (if-let [f (builtins token)] [f])
          (error "undefined operation"))))
  (each line instructions
    (def tokens (peg/match '(any (+ (<- (some :S)) :s)) (string/ascii-lower line)))
    (if (= ":" (first tokens))
      (let [name (tokens 1)
            body (slice tokens 2 -2)]
        (when (parse-number name) (error "illegal operation"))
        (put words name (mapcat compile body)))
      (each f (mapcat compile tokens) (f stack))))
  stack)
