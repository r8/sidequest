(import test :as t)
(import ../bowling :as sol)

(t/deftest "should be able to score a game with all zeros"
  (def game (sol/make-game))
  (each pins [0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0] (sol/roll game pins))
  (t/assert-equal 0 (sol/score game)))

(t/deftest "should be able to score a game with no strikes or spares"
  (def game (sol/make-game))
  (each pins [3 6 3 6 3 6 3 6 3 6 3 6 3 6 3 6 3 6 3 6] (sol/roll game pins))
  (t/assert-equal 90 (sol/score game)))

(t/deftest "a spare followed by zeros is worth ten points"
  (def game (sol/make-game))
  (each pins [6 4 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0] (sol/roll game pins))
  (t/assert-equal 10 (sol/score game)))

(t/deftest "points scored in the roll after a spare are counted twice"
  (def game (sol/make-game))
  (each pins [6 4 3 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0] (sol/roll game pins))
  (t/assert-equal 16 (sol/score game)))

(t/deftest "consecutive spares each get a one roll bonus"
  (def game (sol/make-game))
  (each pins [5 5 3 7 4 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0] (sol/roll game pins))
  (t/assert-equal 31 (sol/score game)))

(t/deftest "a spare in the last frame gets a one roll bonus that is counted once"
  (def game (sol/make-game))
  (each pins [0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 7 3 7] (sol/roll game pins))
  (t/assert-equal 17 (sol/score game)))

(t/deftest "a strike earns ten points in a frame with a single roll"
  (def game (sol/make-game))
  (each pins [10 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0] (sol/roll game pins))
  (t/assert-equal 10 (sol/score game)))

(t/deftest "points scored in the two rolls after a strike are counted twice as a bonus"
  (def game (sol/make-game))
  (each pins [10 5 3 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0] (sol/roll game pins))
  (t/assert-equal 26 (sol/score game)))

(t/deftest "consecutive strikes each get the two roll bonus"
  (def game (sol/make-game))
  (each pins [10 10 10 5 3 0 0 0 0 0 0 0 0 0 0 0 0] (sol/roll game pins))
  (t/assert-equal 81 (sol/score game)))

(t/deftest "a strike in the last frame gets a two roll bonus that is counted once"
  (def game (sol/make-game))
  (each pins [0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 10 7 1] (sol/roll game pins))
  (t/assert-equal 18 (sol/score game)))

(t/deftest "rolling a spare with the two roll bonus does not get a bonus roll"
  (def game (sol/make-game))
  (each pins [0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 10 7 3] (sol/roll game pins))
  (t/assert-equal 20 (sol/score game)))

(t/deftest "strikes with the two roll bonus do not get bonus rolls"
  (def game (sol/make-game))
  (each pins [0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 10 10 10] (sol/roll game pins))
  (t/assert-equal 30 (sol/score game)))

(t/deftest "last two strikes followed by only last bonus with non strike points"
  (def game (sol/make-game))
  (each pins [0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 10 10 0 1] (sol/roll game pins))
  (t/assert-equal 31 (sol/score game)))

(t/deftest "a strike with the one roll bonus after a spare in the last frame does not get a bonus"
  (def game (sol/make-game))
  (each pins [0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 7 3 10] (sol/roll game pins))
  (t/assert-equal 20 (sol/score game)))

(t/deftest "all strikes is a perfect game"
  (def game (sol/make-game))
  (each pins [10 10 10 10 10 10 10 10 10 10 10 10] (sol/roll game pins))
  (t/assert-equal 300 (sol/score game)))

(t/deftest "rolls cannot score negative points"
  (def game (sol/make-game))
  (t/assert-error "Negative roll is invalid" (sol/roll game -1)))

(t/deftest "a roll cannot score more than 10 points"
  (def game (sol/make-game))
  (t/assert-error "Pin count exceeds pins on the lane" (sol/roll game 11)))

(t/deftest "two rolls in a frame cannot score more than 10 points"
  (def game (sol/make-game))
  (each pins [5] (sol/roll game pins))
  (t/assert-error "Pin count exceeds pins on the lane" (sol/roll game 6)))

(t/deftest "bonus roll after a strike in the last frame cannot score more than 10 points"
  (def game (sol/make-game))
  (each pins [0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 10] (sol/roll game pins))
  (t/assert-error "Pin count exceeds pins on the lane" (sol/roll game 11)))

(t/deftest "two bonus rolls after a strike in the last frame cannot score more than 10 points"
  (def game (sol/make-game))
  (each pins [0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 10 5] (sol/roll game pins))
  (t/assert-error "Pin count exceeds pins on the lane" (sol/roll game 6)))

(t/deftest "two bonus rolls after a strike in the last frame can score more than 10 points if one is a strike"
  (def game (sol/make-game))
  (each pins [0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 10 10 6] (sol/roll game pins))
  (t/assert-equal 26 (sol/score game)))

(t/deftest "the second bonus rolls after a strike in the last frame cannot be a strike if the first one is not a strike"
  (def game (sol/make-game))
  (each pins [0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 10 6] (sol/roll game pins))
  (t/assert-error "Pin count exceeds pins on the lane" (sol/roll game 10)))

(t/deftest "second bonus roll after a strike in the last frame cannot score more than 10 points"
  (def game (sol/make-game))
  (each pins [0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 10 10] (sol/roll game pins))
  (t/assert-error "Pin count exceeds pins on the lane" (sol/roll game 11)))

(t/deftest "an unstarted game cannot be scored"
  (def game (sol/make-game))
  (t/assert-error "Score cannot be taken until the end of the game" (sol/score game)))

(t/deftest "an incomplete game cannot be scored"
  (def game (sol/make-game))
  (each pins [0 0] (sol/roll game pins))
  (t/assert-error "Score cannot be taken until the end of the game" (sol/score game)))

(t/deftest "cannot roll if game already has ten frames"
  (def game (sol/make-game))
  (each pins [0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0] (sol/roll game pins))
  (t/assert-error "Cannot roll after game is over" (sol/roll game 0)))

(t/deftest "bonus rolls for a strike in the last frame must be rolled before score can be calculated"
  (def game (sol/make-game))
  (each pins [0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 10] (sol/roll game pins))
  (t/assert-error "Score cannot be taken until the end of the game" (sol/score game)))

(t/deftest "both bonus rolls for a strike in the last frame must be rolled before score can be calculated"
  (def game (sol/make-game))
  (each pins [0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 10 10] (sol/roll game pins))
  (t/assert-error "Score cannot be taken until the end of the game" (sol/score game)))

(t/deftest "bonus roll for a spare in the last frame must be rolled before score can be calculated"
  (def game (sol/make-game))
  (each pins [0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 7 3] (sol/roll game pins))
  (t/assert-error "Score cannot be taken until the end of the game" (sol/score game)))

(t/deftest "cannot roll after bonus roll for spare"
  (def game (sol/make-game))
  (each pins [0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 7 3 2] (sol/roll game pins))
  (t/assert-error "Cannot roll after game is over" (sol/roll game 2)))

(t/deftest "cannot roll after bonus rolls for strike"
  (def game (sol/make-game))
  (each pins [0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 10 3 2] (sol/roll game pins))
  (t/assert-error "Cannot roll after game is over" (sol/roll game 2)))

(t/run)
