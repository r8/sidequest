# Each opening bracket pushes the closer it is waiting for; a closer must match the top of that
# stack. A stack rather than a recursive grammar, so nesting depth has no limit.
(def- closers {(chr "(") (chr ")") (chr "[") (chr "]") (chr "{") (chr "}")})

(defn paired?
  "(paired? value) -> true when every bracket, brace and parenthesis is matched and correctly nested"
  [value]
  (def awaited @[])
  (label result
    (each c value
      (cond
        (closers c) (array/push awaited (closers c))
        (has-value? closers c) (unless (= c (array/pop awaited)) (return result false))))
    (empty? awaited)))
