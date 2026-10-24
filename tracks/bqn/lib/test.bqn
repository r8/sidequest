# A small test harness for the BQN track (CBQN). It needs nothing beyond the bqn binary.
#
#   t ← •Import "../lib/test.bqn"
#   g ← •Import "../hamming.bqn"
#
#   t.Run ⟨
#     "empty strands"‿{𝕊: 0 t.Expect "" g.Distance ""}
#     "disallow first strand longer"‿{𝕊: {𝕊: "AATG" g.Distance "AAA"} t._throws "strands must be of equal length"}
#   ⟩
#
# Each test is a name‿function pair; Run calls every function in order. Assertions take the expected
# value on the left: expected t.Expect actual, expected t.Approx actual (to within 0.01), and
# Action t._throws message. Run prints one machine-readable line per test, then a summary line, and
# exits 1 if anything failed or errored:
#
#   PASS<TAB><name><TAB><TAB>
#   FAIL<TAB><name><TAB><expected/got message><TAB>
#   ERROR<TAB><name><TAB><error message><TAB>
#   SUMMARY<TAB><passed><TAB><failed><TAB><errored>
#
# Backslash, tab, newline and carriage return in a field are escaped as \\ \t \n \r. Whatever a test
# prints appears on the lines before its record. Every record and the summary start on a fresh line,
# so output printed without a trailing newline cannot swallow one (blank lines in between mean nothing).

# Assertion failures are errors whose message starts with this marker.
mark ← "quest/assertion: "

Str ← {(1=≡𝕩)∧∧´2=•Type¨𝕩 ? 𝕩 ; •Repr 𝕩}
Fail ← {(mark∾𝕩) ! 0}
Got ← {"expected "∾(•Repr 𝕨)∾", got "∾•Repr 𝕩}

# Passes when 𝕩 matches 𝕨.
Expect ⇐ {𝕨 ≡ 𝕩 ? @ ; Fail 𝕨 Got 𝕩}

# Passes when the numbers 𝕨 and 𝕩 differ by at most 0.01.
Approx ⇐ {0.01 ≥ |𝕨-𝕩 ? @ ; Fail 𝕨 Got 𝕩}

ThrowCheck ← {
  ¬⊑𝕩 ? Fail "expected the error "∾(•Repr 𝕨)∾", but nothing was raised" ;
  𝕨 ≡ 1⊑𝕩 ? @ ;
  Fail "expected the error "∾(•Repr 𝕨)∾", got "∾•Repr 1⊑𝕩
}

# Passes when calling 𝔽 raises an error whose message is 𝕩.
_throws ⇐ {
  Action ← 𝔽
  𝕩 ThrowCheck {𝕊: Action @ ⋄ 0‿""}⎊{𝕊: 1‿(Str •CurrentError @)} @
}

Esc ← {∾ {𝕩='\' ? "\\" ; 𝕩=@+9 ? "\t" ; 𝕩=@+10 ? "\n" ; 𝕩=@+13 ? "\r" ; ⋈𝕩}¨ 𝕩}
Prefix ← {(𝕩 ≥○≠ 𝕨) ∧ 𝕨 ≡ (≠𝕨)↑𝕩}
Classify ← {mark Prefix 𝕩 ? "FAIL"‿((≠mark)↓𝕩) ; "ERROR"‿𝕩}

RunOne ← {
  name‿F ← 𝕩
  status‿msg ← {𝕊: F @ ⋄ "PASS"‿""}⎊{𝕊: Classify Str •CurrentError @} @
  •Out (@+10)∾status∾(@+9)∾(Esc name)∾(@+9)∾(Esc msg)∾@+9
  status
}

# Runs every name‿function pair in order, reports, and exits 1 if anything failed or errored.
Run ⇐ {
  s ← RunOne¨ 𝕩
  counts ← {+´ (<𝕩) ≡¨ s}¨ "PASS"‿"FAIL"‿"ERROR"
  •Out (@+10)∾"SUMMARY" ∾ ∾ (@+9)⊸∾¨ •Fmt¨ counts
  •Exit 0 < +´ 1↓counts
}
