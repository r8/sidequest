# Messages and transmissions are lists of bytes, as numbers from 0 to 255.

# TransmitSequence message → the transmitted bytes: the message bits, 7 at a time (the last group
# padded with 0 bits), each followed by a parity bit that makes the number of 1 bits even
TransmitSequence ⇐ {𝕊 𝕩: "implement me" ! 0}

# DecodeMessage transmission → the message bytes, dropping the padding bits at the end; errors with
# "wrong parity" if any byte has an odd number of 1 bits
DecodeMessage ⇐ {𝕊 𝕩: "implement me" ! 0}
