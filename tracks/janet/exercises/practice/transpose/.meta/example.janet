(defn transpose
  "(transpose lines) -> array of the lines of the transposed text"
  [lines]
  # Pad each line on the right only as far as some later line reaches, so padded lengths never
  # grow going down and each column is read from a prefix of the lines.
  (var width 0)
  (def padded
    (reverse
      (seq [line :in (reverse lines)]
        (set width (max width (length line)))
        (string line (string/repeat " " (- width (length line)))))))
  (seq [c :range [0 width]]
    (string/from-bytes ;(seq [line :in padded :while (> (length line) c)] (line c)))))
