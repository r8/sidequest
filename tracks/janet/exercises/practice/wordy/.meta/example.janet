# "What is 3 plus -2 multiplied by 4?" becomes the tokens [3 + -2 * 4]. A word that is
# neither a number nor an operation becomes :unknown; checking the token order comes after.
# The answer is an integer, so "divided by" is integer division, rounded toward zero.
(defn- quotient
  "a divided by b, rounded toward zero (div rounds down: -7 / 2 is -4)"
  [a b]
  (when (zero? b) (error "division by zero"))
  (/ (- a (% a b)) b))

(def- tokens
  (peg/compile
    ~{:number (number (* (? "-") :d+))
      :operation (+ (* "plus" (constant ,+)) (* "minus" (constant ,-))
                    (* "multiplied by" (constant ,*)) (* "divided by" (constant ,quotient)))
      :unknown (/ (some (if-not (+ :s "?") 1)) :unknown)
      :token (* :s+ (+ :number :operation :unknown))
      :main (* "What is" (any :token) "?" -1)}))

(defn answer
  "(answer question) -> the number that a question like \"What is 5 plus 13?\" evaluates to, left to right"
  [question]
  (def [n & rest] (or (peg/match tokens question) [:unknown]))
  (when (has-value? [n ;rest] :unknown) (error "unknown operation"))
  (unless (number? n) (error "syntax error"))
  (reduce (fn [acc [op m]]
            (unless (and (function? op) (number? m)) (error "syntax error"))
            (op acc m))
          n
          (partition 2 rest)))
