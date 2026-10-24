# Bytes are plain integers 0-255. Values go up to 2^32 - 1, which Janet's 32-bit signed bitwise
# operators (band, brshift, ...) can't hold, so reach for arithmetic (%, div, *) instead.

(defn encode
  "(encode numbers) -> array of the VLQ bytes encoding each number in turn"
  [numbers]
  (error "implement me"))

(defn decode
  "(decode bytes) -> array of the numbers encoded by the VLQ bytes; errors if the last number is incomplete"
  [bytes]
  (error "implement me"))
