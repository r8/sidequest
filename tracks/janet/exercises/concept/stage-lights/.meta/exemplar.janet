(defn brightness
  "(brightness) -> number; the current :brightness, 100 when unset"
  []
  (dyn :brightness 100))

(defn spotlight
  "(spotlight actor) -> string describing the spotlight in the current :color and brightness"
  [actor]
  (string (dyn :color :white) " spotlight on " actor " at " (brightness) "%"))

(defn in-color
  "(in-color color f) -> what (f) returns, called with :color set to color"
  [color f]
  (with-dyns [:color color]
    (f)))

(defn dim!
  "(dim! amount) -> number; lowers the brightness by amount, not below 0, and returns it"
  [amount]
  (setdyn :brightness (max 0 (- (brightness) amount))))

(defn rehearse
  "(rehearse f) -> string of everything (f) printed"
  [f]
  (def out @"")
  (with-dyns [:out out]
    (f))
  (string out))
