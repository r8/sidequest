# Messages are arrays of bytes, i.e. integers 0-255 (written as hex literals like 0xc0 in the tests).

(defn transmit-sequence
  "(transmit-sequence message) -> array of bytes to transmit: 7 message bits each, plus a parity bit"
  [message]
  (error "implement me"))

(defn decode-message
  "(decode-message received) -> array of the original message bytes; errors if any byte has wrong parity"
  [received]
  (error "implement me"))
