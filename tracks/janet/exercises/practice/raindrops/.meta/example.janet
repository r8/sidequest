(def- sounds [[3 "Pling"] [5 "Plang"] [7 "Plong"]])

(defn convert
  "(convert number) -> string"
  [number]
  (def drops (seq [[factor sound] :in sounds :when (zero? (% number factor))] sound))
  (if (empty? drops)
    (string number)
    (string/join drops)))
