(defn keep
  "(keep pred xs) -> an array of the elements of xs for which pred is truthy, in order"
  [pred xs]
  (seq [x :in xs :when (pred x)] x))

(defn discard
  "(discard pred xs) -> an array of the elements of xs for which pred is falsey, in order"
  [pred xs]
  (keep (complement pred) xs))
