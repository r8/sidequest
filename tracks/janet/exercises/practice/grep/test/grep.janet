(import test :as t)
(import ../grep :as sol)

# The tests grep these three files, written into a temporary directory that becomes the working
# directory, so file names stay bare. The harness exits when the tests finish, so nothing removes the
# directory; its name is fixed, and each run overwrites the files instead of leaving a new one behind.

(def- files
  {"iliad.txt"
   ["Achilles sing, O Goddess! Peleus' son;"
    "His wrath pernicious, who ten thousand woes"
    "Caused to Achaia's host, sent many a soul"
    "Illustrious into Ades premature,"
    "And Heroes gave (so stood the will of Jove)"
    "To dogs and to all ravening fowls a prey,"
    "When fierce dispute had separated once"
    "The noble Chief Achilles from the son"
    "Of Atreus, Agamemnon, King of men."]
   "midsummer-night.txt"
   ["I do entreat your grace to pardon me."
    "I know not by what power I am made bold,"
    "Nor how it may concern my modesty,"
    "In such a presence here to plead my thoughts;"
    "But I beseech your grace that I may know"
    "The worst that may befall me in this case,"
    "If I refuse to wed Demetrius."]
   "paradise-lost.txt"
   ["Of Mans First Disobedience, and the Fruit"
    "Of that Forbidden Tree, whose mortal tast"
    "Brought Death into the World, and all our woe,"
    "With loss of Eden, till one greater Man"
    "Restore us, and regain the blissful Seat,"
    "Sing Heav'nly Muse, that on the secret top"
    "Of Oreb, or of Sinai, didst inspire"
    "That Shepherd, who first taught the chosen Seed"]})

(def- dir (string (os/getenv "TMPDIR" "/tmp") "/sidequest-grep"))
(os/mkdir dir)
(os/cd dir)
(eachp [name lines] files
  (spit name (string (string/join lines "\n") "\n")))

(t/deftest "One file, one match, no flags"
  (t/assert-equal ["Of Atreus, Agamemnon, King of men."] (sol/grep "Agamemnon" [] ["iliad.txt"])))

(t/deftest "One file, one match, print line numbers flag"
  (t/assert-equal ["2:Of that Forbidden Tree, whose mortal tast"]
                  (sol/grep "Forbidden" ["-n"] ["paradise-lost.txt"])))

(t/deftest "One file, one match, case-insensitive flag"
  (t/assert-equal ["Of that Forbidden Tree, whose mortal tast"]
                  (sol/grep "FORBIDDEN" ["-i"] ["paradise-lost.txt"])))

(t/deftest "One file, one match, print file names flag"
  (t/assert-equal ["paradise-lost.txt"] (sol/grep "Forbidden" ["-l"] ["paradise-lost.txt"])))

(t/deftest "One file, one match, match entire lines flag"
  (t/assert-equal ["With loss of Eden, till one greater Man"]
                  (sol/grep "With loss of Eden, till one greater Man" ["-x"] ["paradise-lost.txt"])))

(t/deftest "One file, one match, multiple flags"
  (t/assert-equal ["9:Of Atreus, Agamemnon, King of men."]
                  (sol/grep "OF ATREUS, Agamemnon, KIng of MEN." ["-n" "-i" "-x"] ["iliad.txt"])))

(t/deftest "One file, several matches, no flags"
  (t/assert-equal ["Nor how it may concern my modesty,"
                   "But I beseech your grace that I may know"
                   "The worst that may befall me in this case,"]
                  (sol/grep "may" [] ["midsummer-night.txt"])))

(t/deftest "One file, several matches, print line numbers flag"
  (t/assert-equal ["3:Nor how it may concern my modesty,"
                   "5:But I beseech your grace that I may know"
                   "6:The worst that may befall me in this case,"]
                  (sol/grep "may" ["-n"] ["midsummer-night.txt"])))

(t/deftest "One file, several matches, match entire lines flag"
  (t/assert-equal [] (sol/grep "may" ["-x"] ["midsummer-night.txt"])))

(t/deftest "One file, several matches, case-insensitive flag"
  (t/assert-equal ["Achilles sing, O Goddess! Peleus' son;"
                   "The noble Chief Achilles from the son"]
                  (sol/grep "ACHILLES" ["-i"] ["iliad.txt"])))

(t/deftest "One file, several matches, inverted flag"
  (t/assert-equal ["Brought Death into the World, and all our woe,"
                   "With loss of Eden, till one greater Man"
                   "Restore us, and regain the blissful Seat,"
                   "Sing Heav'nly Muse, that on the secret top"
                   "That Shepherd, who first taught the chosen Seed"]
                  (sol/grep "Of" ["-v"] ["paradise-lost.txt"])))

(t/deftest "One file, no matches, various flags"
  (t/assert-equal [] (sol/grep "Gandalf" ["-n" "-l" "-x" "-i"] ["iliad.txt"])))

(t/deftest "One file, one match, file flag takes precedence over line flag"
  (t/assert-equal ["iliad.txt"] (sol/grep "ten" ["-n" "-l"] ["iliad.txt"])))

(t/deftest "One file, several matches, inverted and match entire lines flags"
  (t/assert-equal ["Achilles sing, O Goddess! Peleus' son;"
                   "His wrath pernicious, who ten thousand woes"
                   "Caused to Achaia's host, sent many a soul"
                   "And Heroes gave (so stood the will of Jove)"
                   "To dogs and to all ravening fowls a prey,"
                   "When fierce dispute had separated once"
                   "The noble Chief Achilles from the son"
                   "Of Atreus, Agamemnon, King of men."]
                  (sol/grep "Illustrious into Ades premature," ["-x" "-v"] ["iliad.txt"])))

(t/deftest "Multiple files, one match, no flags"
  (t/assert-equal ["iliad.txt:Of Atreus, Agamemnon, King of men."]
                  (sol/grep "Agamemnon" [] ["iliad.txt" "midsummer-night.txt" "paradise-lost.txt"])))

(t/deftest "Multiple files, several matches, no flags"
  (t/assert-equal ["midsummer-night.txt:Nor how it may concern my modesty,"
                   "midsummer-night.txt:But I beseech your grace that I may know"
                   "midsummer-night.txt:The worst that may befall me in this case,"]
                  (sol/grep "may" [] ["iliad.txt" "midsummer-night.txt" "paradise-lost.txt"])))

(t/deftest "Multiple files, several matches, print line numbers flag"
  (t/assert-equal ["midsummer-night.txt:5:But I beseech your grace that I may know"
                   "midsummer-night.txt:6:The worst that may befall me in this case,"
                   "paradise-lost.txt:2:Of that Forbidden Tree, whose mortal tast"
                   "paradise-lost.txt:6:Sing Heav'nly Muse, that on the secret top"]
                  (sol/grep "that" ["-n"] ["iliad.txt" "midsummer-night.txt" "paradise-lost.txt"])))

(t/deftest "Multiple files, one match, print file names flag"
  (t/assert-equal ["iliad.txt"
                   "paradise-lost.txt"]
                  (sol/grep "who" ["-l"] ["iliad.txt" "midsummer-night.txt" "paradise-lost.txt"])))

(t/deftest "Multiple files, several matches, case-insensitive flag"
  (t/assert-equal ["iliad.txt:Caused to Achaia's host, sent many a soul"
                   "iliad.txt:Illustrious into Ades premature,"
                   "iliad.txt:And Heroes gave (so stood the will of Jove)"
                   "iliad.txt:To dogs and to all ravening fowls a prey,"
                   "midsummer-night.txt:I do entreat your grace to pardon me."
                   "midsummer-night.txt:In such a presence here to plead my thoughts;"
                   "midsummer-night.txt:If I refuse to wed Demetrius."
                   "paradise-lost.txt:Brought Death into the World, and all our woe,"
                   "paradise-lost.txt:Restore us, and regain the blissful Seat,"
                   "paradise-lost.txt:Sing Heav'nly Muse, that on the secret top"]
                  (sol/grep "TO" ["-i"] ["iliad.txt" "midsummer-night.txt" "paradise-lost.txt"])))

(t/deftest "Multiple files, several matches, inverted flag"
  (t/assert-equal ["iliad.txt:Achilles sing, O Goddess! Peleus' son;"
                   "iliad.txt:The noble Chief Achilles from the son"
                   "midsummer-night.txt:If I refuse to wed Demetrius."]
                  (sol/grep "a" ["-v"] ["iliad.txt" "midsummer-night.txt" "paradise-lost.txt"])))

(t/deftest "Multiple files, one match, match entire lines flag"
  (t/assert-equal ["midsummer-night.txt:But I beseech your grace that I may know"]
                  (sol/grep "But I beseech your grace that I may know" ["-x"] ["iliad.txt" "midsummer-night.txt" "paradise-lost.txt"])))

(t/deftest "Multiple files, one match, multiple flags"
  (t/assert-equal ["paradise-lost.txt:4:With loss of Eden, till one greater Man"]
                  (sol/grep "WITH LOSS OF EDEN, TILL ONE GREATER MAN" ["-n" "-i" "-x"] ["iliad.txt" "midsummer-night.txt" "paradise-lost.txt"])))

(t/deftest "Multiple files, no matches, various flags"
  (t/assert-equal []
                  (sol/grep "Frodo" ["-n" "-l" "-x" "-i"] ["iliad.txt" "midsummer-night.txt" "paradise-lost.txt"])))

(t/deftest "Multiple files, several matches, file flag takes precedence over line number flag"
  (t/assert-equal ["iliad.txt"
                   "paradise-lost.txt"]
                  (sol/grep "who" ["-n" "-l"] ["iliad.txt" "midsummer-night.txt" "paradise-lost.txt"])))

(t/deftest "Multiple files, several matches, inverted and match entire lines flags"
  (t/assert-equal ["iliad.txt:Achilles sing, O Goddess! Peleus' son;"
                   "iliad.txt:His wrath pernicious, who ten thousand woes"
                   "iliad.txt:Caused to Achaia's host, sent many a soul"
                   "iliad.txt:And Heroes gave (so stood the will of Jove)"
                   "iliad.txt:To dogs and to all ravening fowls a prey,"
                   "iliad.txt:When fierce dispute had separated once"
                   "iliad.txt:The noble Chief Achilles from the son"
                   "iliad.txt:Of Atreus, Agamemnon, King of men."
                   "midsummer-night.txt:I do entreat your grace to pardon me."
                   "midsummer-night.txt:I know not by what power I am made bold,"
                   "midsummer-night.txt:Nor how it may concern my modesty,"
                   "midsummer-night.txt:In such a presence here to plead my thoughts;"
                   "midsummer-night.txt:But I beseech your grace that I may know"
                   "midsummer-night.txt:The worst that may befall me in this case,"
                   "midsummer-night.txt:If I refuse to wed Demetrius."
                   "paradise-lost.txt:Of Mans First Disobedience, and the Fruit"
                   "paradise-lost.txt:Of that Forbidden Tree, whose mortal tast"
                   "paradise-lost.txt:Brought Death into the World, and all our woe,"
                   "paradise-lost.txt:With loss of Eden, till one greater Man"
                   "paradise-lost.txt:Restore us, and regain the blissful Seat,"
                   "paradise-lost.txt:Sing Heav'nly Muse, that on the secret top"
                   "paradise-lost.txt:Of Oreb, or of Sinai, didst inspire"
                   "paradise-lost.txt:That Shepherd, who first taught the chosen Seed"]
                  (sol/grep "Illustrious into Ades premature," ["-x" "-v"] ["iliad.txt" "midsummer-night.txt" "paradise-lost.txt"])))

(t/run)
