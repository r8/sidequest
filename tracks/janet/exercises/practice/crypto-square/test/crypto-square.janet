(import test :as t)
(import ../crypto-square :as sol)

(t/deftest "empty plaintext results in an empty ciphertext"
  (t/assert-equal "" (sol/ciphertext "")))

(t/deftest "normalization results in empty plaintext"
  (t/assert-equal "" (sol/ciphertext "... --- ...")))

(t/deftest "Lowercase"
  (t/assert-equal "a" (sol/ciphertext "A")))

(t/deftest "Remove spaces"
  (t/assert-equal "b" (sol/ciphertext "  b ")))

(t/deftest "Remove punctuation"
  (t/assert-equal "1" (sol/ciphertext "@1,%!")))

(t/deftest "9 character plaintext results in 3 chunks of 3 characters"
  (t/assert-equal "tsf hiu isn" (sol/ciphertext "This is fun!")))

(t/deftest "8 character plaintext results in 3 chunks, the last one with a trailing space"
  (t/assert-equal "clu hlt io " (sol/ciphertext "Chill out.")))

(t/deftest "54 character plaintext results in 8 chunks, the last two with trailing spaces"
  (t/assert-equal "imtgdvs fearwer mayoogo anouuio ntnnlvt wttddes aohghn  sseoau " (sol/ciphertext "If man was meant to stay on the ground, god would have given us roots.")))

(t/run)
