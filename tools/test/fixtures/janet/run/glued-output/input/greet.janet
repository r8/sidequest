(prin "debug")
(defn greet [&opt name] (string "Hello, " (or name "you") "!"))
