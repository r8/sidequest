(defn couple-car
  "(couple-car train car) -> array; the train with the car added at the end"
  [train car]
  (array/push train car))

(defn uncouple-last
  "(uncouple-last train) -> car or nil; removes the last car and returns it"
  [train]
  (array/pop train))

(defn car-at
  "(car-at train position) -> car or nil; the car at the position"
  [train position]
  (get train position))

(defn insert-car
  "(insert-car train position car) -> array; the train with the car inserted at the position"
  [train position car]
  (array/insert train position car))

(defn manifest
  "(manifest train) -> tuple; the train's cars as a tuple"
  [train]
  (tuple ;train))
