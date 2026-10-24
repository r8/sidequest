(defn start-telegram
  "(start-telegram recipient) -> buffer; a new telegram starting with the line TO <RECIPIENT>"
  [recipient]
  (error "implement me"))

(defn add-sentence!
  "(add-sentence! telegram sentence) -> buffer; the telegram with the sentence and STOP appended"
  [telegram sentence]
  (error "implement me"))

(defn censor!
  "(censor! telegram) -> buffer; the telegram with every digit replaced by #"
  [telegram]
  (error "implement me"))

(defn send!
  "(send! telegram) -> string; the telegram's contents, leaving the buffer empty"
  [telegram]
  (error "implement me"))
