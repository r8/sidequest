# The start is a struct {:x x :y y :angle angle} and each prism a struct {:id id :x x :y y :angle angle}.
# Angles are in degrees, counterclockwise from the positive x-axis; a prism turns the beam by its angle.

(defn find-sequence
  "(find-sequence start prisms) -> the ids of the prisms the beam fired from start hits, in order"
  [start prisms]
  (error "implement me"))
