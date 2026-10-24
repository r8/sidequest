import test
import bowling

// The game after rolling `rolls` in order, starting from a new game.
fun replay(rolls : list<int>) : exn game
  rolls.foldl(new-game(), fn(game, pins) game.roll(pins))

pub fun main()
  run([
    test("should be able to score a game with all zeros") { assert-equal(0, replay([0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]).score) },
    test("should be able to score a game with no strikes or spares") { assert-equal(90, replay([3, 6, 3, 6, 3, 6, 3, 6, 3, 6, 3, 6, 3, 6, 3, 6, 3, 6, 3, 6]).score) },
    test("a spare followed by zeros is worth ten points") { assert-equal(10, replay([6, 4, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]).score) },
    test("points scored in the roll after a spare are counted twice") { assert-equal(16, replay([6, 4, 3, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]).score) },
    test("consecutive spares each get a one roll bonus") { assert-equal(31, replay([5, 5, 3, 7, 4, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]).score) },
    test("a spare in the last frame gets a one roll bonus that is counted once") { assert-equal(17, replay([0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 7, 3, 7]).score) },
    test("a strike earns ten points in a frame with a single roll") { assert-equal(10, replay([10, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]).score) },
    test("points scored in the two rolls after a strike are counted twice as a bonus") { assert-equal(26, replay([10, 5, 3, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]).score) },
    test("consecutive strikes each get the two roll bonus") { assert-equal(81, replay([10, 10, 10, 5, 3, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]).score) },
    test("a strike in the last frame gets a two roll bonus that is counted once") { assert-equal(18, replay([0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 10, 7, 1]).score) },
    test("rolling a spare with the two roll bonus does not get a bonus roll") { assert-equal(20, replay([0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 10, 7, 3]).score) },
    test("strikes with the two roll bonus do not get bonus rolls") { assert-equal(30, replay([0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 10, 10, 10]).score) },
    test("last two strikes followed by only last bonus with non strike points") { assert-equal(31, replay([0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 10, 10, 0, 1]).score) },
    test("a strike with the one roll bonus after a spare in the last frame does not get a bonus") { assert-equal(20, replay([0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 7, 3, 10]).score) },
    test("all strikes is a perfect game") { assert-equal(300, replay([10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10]).score) },
    test("rolls cannot score negative points") { assert-throws("Negative roll is invalid") { replay([]).roll(-1) } },
    test("a roll cannot score more than 10 points") { assert-throws("Pin count exceeds pins on the lane") { replay([]).roll(11) } },
    test("two rolls in a frame cannot score more than 10 points") { assert-throws("Pin count exceeds pins on the lane") { replay([5]).roll(6) } },
    test("bonus roll after a strike in the last frame cannot score more than 10 points") { assert-throws("Pin count exceeds pins on the lane") { replay([0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 10]).roll(11) } },
    test("two bonus rolls after a strike in the last frame cannot score more than 10 points") { assert-throws("Pin count exceeds pins on the lane") { replay([0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 10, 5]).roll(6) } },
    test("two bonus rolls after a strike in the last frame can score more than 10 points if one is a strike") { assert-equal(26, replay([0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 10, 10, 6]).score) },
    test("the second bonus rolls after a strike in the last frame cannot be a strike if the first one is not a strike") { assert-throws("Pin count exceeds pins on the lane") { replay([0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 10, 6]).roll(10) } },
    test("second bonus roll after a strike in the last frame cannot score more than 10 points") { assert-throws("Pin count exceeds pins on the lane") { replay([0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 10, 10]).roll(11) } },
    test("an unstarted game cannot be scored") { assert-throws("Score cannot be taken until the end of the game") { replay([]).score } },
    test("an incomplete game cannot be scored") { assert-throws("Score cannot be taken until the end of the game") { replay([0, 0]).score } },
    test("cannot roll if game already has ten frames") { assert-throws("Cannot roll after game is over") { replay([0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]).roll(0) } },
    test("bonus rolls for a strike in the last frame must be rolled before score can be calculated") { assert-throws("Score cannot be taken until the end of the game") { replay([0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 10]).score } },
    test("both bonus rolls for a strike in the last frame must be rolled before score can be calculated") { assert-throws("Score cannot be taken until the end of the game") { replay([0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 10, 10]).score } },
    test("bonus roll for a spare in the last frame must be rolled before score can be calculated") { assert-throws("Score cannot be taken until the end of the game") { replay([0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 7, 3]).score } },
    test("cannot roll after bonus roll for spare") { assert-throws("Cannot roll after game is over") { replay([0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 7, 3, 2]).roll(2) } },
    test("cannot roll after bonus rolls for strike") { assert-throws("Cannot roll after game is over") { replay([0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 10, 3, 2]).roll(2) } },
  ])
