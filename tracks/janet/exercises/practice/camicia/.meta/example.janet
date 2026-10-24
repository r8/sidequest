# Cards are strings: "2" to "10", "J", "Q", "K" and "A"; the first card of a deck is its top.
# The result is {:status status :cards n :tricks n} where status is :finished or :loop.

(def- penalties {"J" 1 "Q" 2 "K" 3 "A" 4})

(defn- penalty [card] (get penalties card 0))

(defn simulate-game
  "(simulate-game player-a player-b) -> how the game played from these two decks ends"
  [player-a player-b]
  (def decks @[(array ;player-a) (array ;player-b)])
  (def seen @{})
  (var player 0)
  (var cards 0)
  (var tricks 0)
  (var status nil)
  (while (nil? status)
    # Number cards are interchangeable, so a round's starting position is the penalties alone.
    (def position [player ;(map |(tuple ;(map penalty $)) decks)])
    (if (seen position)
      (set status :loop)
      (do
        (put seen position true)
        (def pile @[])
        (var owed 0)
        (var winner nil)
        (while (nil? winner)
          (def deck (decks player))
          (if (empty? deck)
            (set winner (- 1 player))
            (let [card (first deck)]
              (array/remove deck 0)
              (array/push pile card)
              (++ cards)
              (cond
                (pos? (penalty card)) (do (set owed (penalty card)) (set player (- 1 player)))
                (zero? owed) (set player (- 1 player))
                (zero? (-- owed)) (set winner (- 1 player))))))
        (array/concat (decks winner) pile)
        (++ tricks)
        (set player winner)
        (when (empty? (decks (- 1 winner)))
          (set status :finished)))))
  {:status status :cards cards :tricks tricks})
