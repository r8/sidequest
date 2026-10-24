(import test :as t)
(import ../telegraph-office :as sol)

(t/deftest "1. start a telegram"
  (t/assert-equal @"TO MRS NOVAK\n" (sol/start-telegram "Mrs Novak")))

(t/deftest "1. a telegram for a single name"
  (t/assert-equal @"TO ALBA\n" (sol/start-telegram "alba")))

(t/deftest "1. a telegram is a buffer"
  (t/assert-equal :buffer (type (sol/start-telegram "Alba"))))

(t/deftest "1. every telegram is a new buffer"
  (t/assert-false (= (sol/start-telegram "Alba") (sol/start-telegram "Alba"))))

(t/deftest "2. add a sentence"
  (t/assert-equal @"TO MRS NOVAK\nARRIVING TUESDAY STOP\n"
                  (sol/add-sentence! @"TO MRS NOVAK\n" "Arriving Tuesday")))

(t/deftest "2. add two sentences"
  (def telegram @"TO ALBA\n")
  (sol/add-sentence! telegram "Congratulations")
  (sol/add-sentence! telegram "See you soon")
  (t/assert-equal @"TO ALBA\nCONGRATULATIONS STOP\nSEE YOU SOON STOP\n" telegram))

(t/deftest "2. adding returns the same buffer"
  (def telegram @"TO ALBA\n")
  (t/assert-true (= telegram (sol/add-sentence! telegram "Hello"))))

(t/deftest "3. hide a time"
  (t/assert-equal @"MEET AT ## STOP\n" (sol/censor! @"MEET AT 10 STOP\n")))

(t/deftest "3. hide every digit"
  (t/assert-equal @"TO FLAT #B\nROOM ### FLOOR # STOP\n" (sol/censor! @"TO FLAT 4B\nROOM 207 FLOOR 2 STOP\n")))

(t/deftest "3. a telegram without digits"
  (t/assert-equal @"ALL WELL STOP\n" (sol/censor! @"ALL WELL STOP\n")))

(t/deftest "3. censoring changes the buffer itself"
  (def telegram @"BACK BY 9 STOP\n")
  (sol/censor! telegram)
  (t/assert-equal @"BACK BY # STOP\n" telegram))

(t/deftest "4. sending returns the contents"
  (t/assert-equal "TO ALBA\nWELL DONE STOP\n" (sol/send! @"TO ALBA\nWELL DONE STOP\n")))

(t/deftest "4. sending returns a string"
  (t/assert-equal :string (type (sol/send! @"TO ALBA\n"))))

(t/deftest "4. sending empties the buffer"
  (def telegram @"TO ALBA\nWELL DONE STOP\n")
  (sol/send! telegram)
  (t/assert-equal 0 (length telegram)))

(t/deftest "4. the buffer can be reused after sending"
  (def telegram (sol/start-telegram "Alba"))
  (sol/add-sentence! telegram "Well done")
  (def first-sent (sol/send! telegram))
  (buffer/push telegram "TO BRUNO\n")
  (t/assert-equal ["TO ALBA\nWELL DONE STOP\n" "TO BRUNO\n"] [first-sent (string telegram)]))

(t/run)
