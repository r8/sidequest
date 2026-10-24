# Messages are arrays of bytes, i.e. integers 0-255 (written as hex literals like 0xc0 in the tests).

(defn- bits
  "The bits of byte, most significant first."
  [byte]
  (seq [i :down-to [7 0]] (band 1 (brshift byte i))))

(defn- from-bits [bs]
  (reduce |(+ (* 2 $0) $1) 0 bs))

(defn transmit-sequence
  "(transmit-sequence message) -> array of bytes to transmit: 7 message bits each, plus a parity bit"
  [message]
  (seq [chunk :in (partition 7 (mapcat bits message))
        :let [padding (array/new-filled (- 7 (length chunk)) 0)]]
    (from-bits [;chunk ;padding (% (sum chunk) 2)])))

(defn decode-message
  "(decode-message received) -> array of the original message bytes; errors if any byte has wrong parity"
  [received]
  (def stream
    (mapcat (fn [byte]
              (def bs (bits byte))
              (unless (even? (sum bs)) (error "wrong parity"))
              (slice bs 0 7))
            received))
  # Trailing bits that don't make up a whole byte are padding.
  (map from-bits (filter |(= 8 (length $)) (partition 8 stream))))
