(defn make-game
  "(make-game) -> a new game with no rolls yet"
  []
  @{:rolls @[]})

(defn- frames
  "Splits rolls into frames: up to nine of one or two rolls, then the tenth with its bonus rolls."
  [rolls]
  (def result @[])
  (var i 0)
  (while (and (< i (length rolls)) (< (length result) 9))
    (def size (if (= 10 (rolls i)) 1 2))
    (array/push result (slice rolls i (min (+ i size) (length rolls))))
    (+= i size))
  (when (< i (length rolls))
    (array/push result (slice rolls i)))
  result)

(defn- standing
  "Pins left on the lane after the rolls of one frame; a cleared lane is reset to 10."
  [frame]
  (reduce (fn [pins knocked] (if (= pins knocked) 10 (- pins knocked))) 10 frame))

(defn- pins-up
  "Pins standing for the next roll, or nil once the game is over."
  [rolls]
  (def fs (frames rolls))
  (def frame (last fs))
  (cond
    (nil? frame) 10
    (< (length fs) 10) (if (or (= 2 (length frame)) (= 10 (frame 0))) 10 (standing frame))
    # The tenth frame gets a third roll only after a strike or a spare.
    (or (= 3 (length frame))
        (and (= 2 (length frame)) (< (+ (frame 0) (frame 1)) 10))) nil
    (standing frame)))

(defn roll
  "(roll game pins) -> game, after recording a roll that knocked down pins"
  [game pins]
  (def up (pins-up (game :rolls)))
  (cond
    (neg? pins) (error "Negative roll is invalid")
    (nil? up) (error "Cannot roll after game is over")
    (> pins up) (error "Pin count exceeds pins on the lane"))
  (array/push (game :rolls) pins)
  game)

(defn score
  "(score game) -> the total score of a finished game"
  [game]
  (def rolls (game :rolls))
  (when (pins-up rolls)
    (error "Score cannot be taken until the end of the game"))
  (var i 0)
  (var total 0)
  (repeat 10
    (def [a b c] (slice rolls i))
    (cond
      (= a 10) (do (+= total (+ a b c)) (++ i))
      (= 10 (+ a b)) (do (+= total (+ a b c)) (+= i 2))
      (do (+= total (+ a b)) (+= i 2))))
  total)
