import test
import crypto-square

pub fun main()
  run([
    test("empty plaintext results in an empty ciphertext") { assert-equal("", ciphertext("")) },
    test("normalization results in empty plaintext") { assert-equal("", ciphertext("... --- ...")) },
    test("Lowercase") { assert-equal("a", ciphertext("A")) },
    test("Remove spaces") { assert-equal("b", ciphertext("  b ")) },
    test("Remove punctuation") { assert-equal("1", ciphertext("@1,%!")) },
    test("9 character plaintext results in 3 chunks of 3 characters") { assert-equal("tsf hiu isn", ciphertext("This is fun!")) },
    test("8 character plaintext results in 3 chunks, the last one with a trailing space") { assert-equal("clu hlt io ", ciphertext("Chill out.")) },
    test("54 character plaintext results in 8 chunks, the last two with trailing spaces") { assert-equal("imtgdvs fearwer mayoogo anouuio ntnnlvt wttddes aohghn  sseoau ", ciphertext("If man was meant to stay on the ground, god would have given us roots.")) },
  ])
