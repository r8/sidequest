(defn make-belt
  "(make-belt boxes) -> fiber yielding each box in order"
  [boxes]
  (coro
    (each box boxes
      (yield box))))

(defn next-box
  "(next-box belt) -> the next box, or nil when the belt is empty"
  [belt]
  (unless (= :dead (fiber/status belt))
    (resume belt)))

(defn unload
  "(unload belt) -> array of the boxes still on the belt"
  [belt]
  (def boxes @[])
  (each box belt
    (array/push boxes box))
  boxes)

(defn labels
  "(labels prefix) -> fiber yielding prefix-1, prefix-2, …"
  [prefix]
  (coro
    (var n 0)
    (while true
      (++ n)
      (yield (string prefix "-" n)))))

(defn make-scale
  "(make-scale) -> fiber; resumed with a weight, it returns the running total"
  []
  (fiber/new
    (fn [weight]
      (var total weight)
      (while true
        (+= total (yield total))))))
