# flags is a list of strings, any of:
#   "-n" prefix each line with its line number    "-l" print only the names of files with a match
#   "-i" match case-insensitively                  "-v" print the lines that do not match
#   "-x" match only entire lines
# With more than one file, each output line is prefixed with "<file name>:".

(defn grep
  "(grep pattern flags files) -> an array of the output lines for searching files for pattern"
  [pattern flags files]
  (error "implement me"))
