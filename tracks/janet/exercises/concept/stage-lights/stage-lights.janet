(defn brightness
  "(brightness) -> number; the current :brightness, 100 when unset"
  []
  (error "implement me"))

(defn spotlight
  "(spotlight actor) -> string describing the spotlight in the current :color and brightness"
  [actor]
  (error "implement me"))

(defn in-color
  "(in-color color f) -> what (f) returns, called with :color set to color"
  [color f]
  (error "implement me"))

(defn dim!
  "(dim! amount) -> number; lowers the brightness by amount, not below 0, and returns it"
  [amount]
  (error "implement me"))

(defn rehearse
  "(rehearse f) -> string of everything (f) printed"
  [f]
  (error "implement me"))
