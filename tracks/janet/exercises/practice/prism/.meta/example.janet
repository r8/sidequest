# The start is a struct {:x x :y y :angle angle} and each prism a struct {:id id :x x :y y :angle angle}.
# Angles are in degrees, counterclockwise from the positive x-axis; a prism turns the beam by its angle.

(defn- next-prism
  "The nearest prism ahead of beam, or nil."
  [prisms beam]
  (def {:x x :y y :angle angle} beam)
  (def ux (math/cos (* angle (/ math/pi 180))))
  (def uy (math/sin (* angle (/ math/pi 180))))
  (def ahead
    (seq [p :in prisms
          :let [dx (- (p :x) x)
                dy (- (p :y) y)
                along (+ (* dx ux) (* dy uy))
                aside (- (* dx uy) (* dy ux))]
          # Coordinates and angles are rounded, so allow a small angular error.
          :when (and (> along 1e-6) (< (math/abs aside) (* 1e-3 (max 1 along))))]
      [along p]))
  (if-let [[_ p] (first (sort-by first ahead))] p))

(defn find-sequence
  "(find-sequence start prisms) -> the ids of the prisms the beam fired from start hits, in order"
  [start prisms]
  (var beam start)
  (seq [p :iterate (next-prism prisms beam)]
    (set beam {:x (p :x) :y (p :y) :angle (+ (beam :angle) (p :angle))})
    (p :id)))
