(defn classify
  "(classify celsius) -> keyword; :freezing, :cold, :mild or :hot"
  [celsius]
  (cond
    (< celsius 0) :freezing
    (< celsius 10) :cold
    (< celsius 20) :mild
    :hot))

(defn advice
  "(advice sky) -> string; the advice for the sky"
  [sky]
  (case sky
    :sunny "Bring sunglasses"
    :rainy "Bring an umbrella"
    :snowy "Wear boots"
    :stormy "Stay in harbour"
    "Enjoy your day"))

(defn parse-sky
  "(parse-sky text) -> keyword; the sky written in the logbook"
  [text]
  (keyword (string/ascii-lower (string/trim text))))

(defn wet?
  "(wet? sky) -> boolean; whether the sky is :rainy, :snowy or :stormy"
  [sky]
  (or (= sky :rainy) (= sky :snowy) (= sky :stormy)))

(defn report
  "(report celsius sky) -> string; the temperature and the sky in words"
  [celsius sky]
  (string (classify celsius) " and " sky))
