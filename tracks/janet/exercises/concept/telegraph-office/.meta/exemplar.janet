(defn start-telegram
  "(start-telegram recipient) -> buffer; a new telegram starting with the line TO <RECIPIENT>"
  [recipient]
  (buffer "TO " (string/ascii-upper recipient) "\n"))

(defn add-sentence!
  "(add-sentence! telegram sentence) -> buffer; the telegram with the sentence and STOP appended"
  [telegram sentence]
  (buffer/push telegram (string/ascii-upper sentence) " STOP\n"))

(defn censor!
  "(censor! telegram) -> buffer; the telegram with every digit replaced by #"
  [telegram]
  (for i 0 (length telegram)
    (def byte (get telegram i))
    (when (and (>= byte (chr "0")) (<= byte (chr "9")))
      (put telegram i (chr "#"))))
  telegram)

(defn send!
  "(send! telegram) -> string; the telegram's contents, leaving the buffer empty"
  [telegram]
  (def sent (string telegram))
  (buffer/clear telegram)
  sent)
