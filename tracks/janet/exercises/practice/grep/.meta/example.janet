# flags is a list of strings, any of:
#   "-n" prefix each line with its line number    "-l" print only the names of files with a match
#   "-i" match case-insensitively                  "-v" print the lines that do not match
#   "-x" match only entire lines
# With more than one file, each output line is prefixed with "<file name>:".

(defn- lines-of
  "The lines of a file's text: a final newline ends the last line rather than starting an empty one,
  and an empty file has no lines. Blank lines before the end are lines like any other."
  [text]
  (if (empty? text)
    @[]
    (string/split "\n" (if (string/has-suffix? "\n" text) (string/slice text 0 -2) text))))

(defn grep
  "(grep pattern flags files) -> an array of the output lines for searching files for pattern"
  [pattern flags files]
  (def flag? (tabseq [f :in flags] f true))
  (def normalize (if (flag? "-i") string/ascii-lower identity))
  (def needle (normalize pattern))
  (defn match? [line]
    (def text (normalize line))
    (def found (if (flag? "-x") (= needle text) (string/find needle text)))
    (if (flag? "-v") (not found) (truthy? found)))
  (def output @[])
  (each file files
    (def lines (lines-of (slurp file)))
    (def matches (seq [[i line] :pairs lines :when (match? line)] [(+ i 1) line]))
    (if (flag? "-l")
      (unless (empty? matches) (array/push output file))
      (each [n line] matches
        (array/push output (string (if (> (length files) 1) (string file ":"))
                                   (if (flag? "-n") (string n ":"))
                                   line)))))
  output)
