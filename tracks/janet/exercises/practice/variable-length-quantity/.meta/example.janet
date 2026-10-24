# Bytes are plain integers 0-255. Values go up to 2^32 - 1, which Janet's 32-bit signed bitwise
# operators (band, brshift, ...) can't hold, so reach for arithmetic (%, div, *) instead.

(defn- encode-one
  "The low 7 bits make the last byte; higher groups come before it with the continuation bit set."
  [n &opt continued]
  (def byte (+ (% n 128) (if continued 128 0)))
  (def higher (div n 128))
  (if (zero? higher)
    @[byte]
    (array/push (encode-one higher true) byte)))

(defn encode
  "(encode numbers) -> array of the VLQ bytes encoding each number in turn"
  [numbers]
  (mapcat encode-one numbers))

(defn decode
  "(decode bytes) -> array of the numbers encoded by the VLQ bytes; errors if the last number is incomplete"
  [bytes]
  (def numbers @[])
  (var n 0)
  (each byte bytes
    (set n (+ (* n 128) (% byte 128)))
    (when (< byte 128)
      (array/push numbers n)
      (set n 0)))
  (when (and (not (empty? bytes)) (>= (last bytes) 128))
    (error "incomplete sequence"))
  numbers)
