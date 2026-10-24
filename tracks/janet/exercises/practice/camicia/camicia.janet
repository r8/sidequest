# Cards are strings: "2" to "10", "J", "Q", "K" and "A"; the first card of a deck is its top.
# The result is {:status status :cards n :tricks n} where status is :finished or :loop.

(defn simulate-game
  "(simulate-game player-a player-b) -> how the game played from these two decks ends"
  [player-a player-b]
  (error "implement me"))
