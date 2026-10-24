# An action is a keyword: :wink :double-blink :close-your-eyes :jump

(def- actions [:wink :double-blink :close-your-eyes :jump])

(defn commands
  "(commands number) -> the actions of the secret handshake for number, in order"
  [number]
  (def bit? |(pos? (band number (blshift 1 $))))
  (def chosen (keep |(when (bit? $) (actions $)) (range 4)))
  (if (bit? 4) (reverse chosen) chosen))
