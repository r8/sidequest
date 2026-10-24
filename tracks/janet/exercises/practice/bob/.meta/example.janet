(defn response
  "(response hey-bob) -> Bob's reply to the remark"
  [hey-bob]
  (def remark (string/trim hey-bob))
  (def question? (string/has-suffix? "?" remark))
  (def yelling? (and (not= remark (string/ascii-lower remark))
                     (= remark (string/ascii-upper remark))))
  (cond
    (empty? remark) "Fine. Be that way!"
    (and yelling? question?) "Calm down, I know what I'm doing!"
    yelling? "Whoa, chill out!"
    question? "Sure."
    "Whatever."))
