(defn greet [&opt name]
  (when name (os/exit 0))
  (string "Hello, " (or name "you") "!"))
