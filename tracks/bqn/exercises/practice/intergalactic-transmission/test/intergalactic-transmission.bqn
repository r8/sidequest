t ← •Import "../lib/test.bqn"
g ← •Import "../intergalactic-transmission.bqn"

# Hex "c0 01" → the bytes written as two hex digits each: ⟨192, 1⟩
Hex ← {16⊸×⊸+´˘ ∘‿2⥊"0123456789abcdef"⊐(' '≠𝕩)/𝕩}

msg6 ← Hex "47 72 65 61 74 21"
seq6 ← Hex "47 b8 99 ac 17 a0 84"
msg7 ← Hex "47 72 65 61 74 31 21"
seq7 ← Hex "47 b8 99 ac 17 a0 c5 42"
msg8 ← Hex "c0 01 13 37 c0 de 21 21"
seq8 ← Hex "c0 00 44 66 7d 06 78 42 21 81"
msg20 ← Hex "45 78 65 72 63 69 73 6d 20 69 73 20 61 77 65 73 6f 6d 65 21"
seq20 ← Hex "44 bd 18 af 27 1b a5 e7 6c 90 1b 2e 33 03 84 ee 65 b8 db ed d7 28 84"

t.Run ⟨
  "calculate transmit sequences > empty message"‿{𝕊: ⟨⟩ t.Expect g.TransmitSequence ⟨⟩}
  "calculate transmit sequences > 0x00 is transmitted as 0x0000"‿{𝕊: (Hex "00 00") t.Expect g.TransmitSequence Hex "00"}
  "calculate transmit sequences > 0x02 is transmitted as 0x0300"‿{𝕊: (Hex "03 00") t.Expect g.TransmitSequence Hex "02"}
  "calculate transmit sequences > 0x06 is transmitted as 0x0600"‿{𝕊: (Hex "06 00") t.Expect g.TransmitSequence Hex "06"}
  "calculate transmit sequences > 0x05 is transmitted as 0x0581"‿{𝕊: (Hex "05 81") t.Expect g.TransmitSequence Hex "05"}
  "calculate transmit sequences > 0x29 is transmitted as 0x2881"‿{𝕊: (Hex "28 81") t.Expect g.TransmitSequence Hex "29"}
  "calculate transmit sequences > 0xc001c0de is transmitted as 0xc000711be1"‿{𝕊: (Hex "c0 00 71 1b e1") t.Expect g.TransmitSequence Hex "c0 01 c0 de"}
  "calculate transmit sequences > six byte message"‿{𝕊: seq6 t.Expect g.TransmitSequence msg6}
  "calculate transmit sequences > seven byte message"‿{𝕊: seq7 t.Expect g.TransmitSequence msg7}
  "calculate transmit sequences > eight byte message"‿{𝕊: seq8 t.Expect g.TransmitSequence msg8}
  "calculate transmit sequences > twenty byte message"‿{𝕊: seq20 t.Expect g.TransmitSequence msg20}
  "decode received messages > empty message"‿{𝕊: ⟨⟩ t.Expect g.DecodeMessage ⟨⟩}
  "decode received messages > zero message"‿{𝕊: (Hex "00") t.Expect g.DecodeMessage Hex "00 00"}
  "decode received messages > 0x0300 is decoded to 0x02"‿{𝕊: (Hex "02") t.Expect g.DecodeMessage Hex "03 00"}
  "decode received messages > 0x0581 is decoded to 0x05"‿{𝕊: (Hex "05") t.Expect g.DecodeMessage Hex "05 81"}
  "decode received messages > 0x2881 is decoded to 0x29"‿{𝕊: (Hex "29") t.Expect g.DecodeMessage Hex "28 81"}
  "decode received messages > first byte has wrong parity"‿{𝕊: {𝕊: g.DecodeMessage Hex "07 00"} t._throws "wrong parity"}
  "decode received messages > second byte has wrong parity"‿{𝕊: {𝕊: g.DecodeMessage Hex "03 68"} t._throws "wrong parity"}
  "decode received messages > 0xcf4b00 is decoded to 0xce94"‿{𝕊: (Hex "ce 94") t.Expect g.DecodeMessage Hex "cf 4b 00"}
  "decode received messages > 0xe2566500 is decoded to 0xe2ad90"‿{𝕊: (Hex "e2 ad 90") t.Expect g.DecodeMessage Hex "e2 56 65 00"}
  "decode received messages > six byte message"‿{𝕊: msg6 t.Expect g.DecodeMessage seq6}
  "decode received messages > seven byte message"‿{𝕊: msg7 t.Expect g.DecodeMessage seq7}
  "decode received messages > last byte has wrong parity"‿{𝕊: {𝕊: g.DecodeMessage Hex "47 b8 99 ac 17 a0 c5 43"} t._throws "wrong parity"}
  "decode received messages > eight byte message"‿{𝕊: msg8 t.Expect g.DecodeMessage seq8}
  "decode received messages > twenty byte message"‿{𝕊: msg20 t.Expect g.DecodeMessage seq20}
  "decode received messages > wrong parity on 16th byte"‿{𝕊: {𝕊: g.DecodeMessage Hex "44 bd 18 af 27 1b a5 e7 6c 90 1b 2e 33 03 84 ef 65 b8 db ed d7 28 84"} t._throws "wrong parity"}
⟩
