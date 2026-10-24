(import test :as t)
(import ../house :as sol)

(t/deftest "verse one - the house that jack built"
  (t/assert-equal ["This is the house that Jack built."] (sol/recite 1 1)))

(t/deftest "verse two - the malt that lay"
  (t/assert-equal ["This is the malt that lay in the house that Jack built."] (sol/recite 2 2)))

(t/deftest "verse three - the rat that ate"
  (t/assert-equal ["This is the rat that ate the malt that lay in the house that Jack built."]
                  (sol/recite 3 3)))

(t/deftest "verse four - the cat that killed"
  (t/assert-equal ["This is the cat that killed the rat that ate the malt that lay in the house that Jack built."]
                  (sol/recite 4 4)))

(t/deftest "verse five - the dog that worried"
  (t/assert-equal ["This is the dog that worried the cat that killed the rat that ate the malt that lay in the house that Jack built."]
                  (sol/recite 5 5)))

(t/deftest "verse six - the cow with the crumpled horn"
  (t/assert-equal ["This is the cow with the crumpled horn that tossed the dog that worried the cat that killed the rat that ate the malt that lay in the house that Jack built."]
                  (sol/recite 6 6)))

(t/deftest "verse seven - the maiden all forlorn"
  (t/assert-equal ["This is the maiden all forlorn that milked the cow with the crumpled horn that tossed the dog that worried the cat that killed the rat that ate the malt that lay in the house that Jack built."]
                  (sol/recite 7 7)))

(t/deftest "verse eight - the man all tattered and torn"
  (t/assert-equal ["This is the man all tattered and torn that kissed the maiden all forlorn that milked the cow with the crumpled horn that tossed the dog that worried the cat that killed the rat that ate the malt that lay in the house that Jack built."]
                  (sol/recite 8 8)))

(t/deftest "verse nine - the priest all shaven and shorn"
  (t/assert-equal ["This is the priest all shaven and shorn that married the man all tattered and torn that kissed the maiden all forlorn that milked the cow with the crumpled horn that tossed the dog that worried the cat that killed the rat that ate the malt that lay in the house that Jack built."]
                  (sol/recite 9 9)))

(t/deftest "verse 10 - the rooster that crowed in the morn"
  (t/assert-equal ["This is the rooster that crowed in the morn that woke the priest all shaven and shorn that married the man all tattered and torn that kissed the maiden all forlorn that milked the cow with the crumpled horn that tossed the dog that worried the cat that killed the rat that ate the malt that lay in the house that Jack built."]
                  (sol/recite 10 10)))

(t/deftest "verse 11 - the farmer sowing his corn"
  (t/assert-equal ["This is the farmer sowing his corn that kept the rooster that crowed in the morn that woke the priest all shaven and shorn that married the man all tattered and torn that kissed the maiden all forlorn that milked the cow with the crumpled horn that tossed the dog that worried the cat that killed the rat that ate the malt that lay in the house that Jack built."]
                  (sol/recite 11 11)))

(t/deftest "verse 12 - the horse and the hound and the horn"
  (t/assert-equal ["This is the horse and the hound and the horn that belonged to the farmer sowing his corn that kept the rooster that crowed in the morn that woke the priest all shaven and shorn that married the man all tattered and torn that kissed the maiden all forlorn that milked the cow with the crumpled horn that tossed the dog that worried the cat that killed the rat that ate the malt that lay in the house that Jack built."]
                  (sol/recite 12 12)))

(t/deftest "multiple verses"
  (t/assert-equal ["This is the cat that killed the rat that ate the malt that lay in the house that Jack built."
                   "This is the dog that worried the cat that killed the rat that ate the malt that lay in the house that Jack built."
                   "This is the cow with the crumpled horn that tossed the dog that worried the cat that killed the rat that ate the malt that lay in the house that Jack built."
                   "This is the maiden all forlorn that milked the cow with the crumpled horn that tossed the dog that worried the cat that killed the rat that ate the malt that lay in the house that Jack built."
                   "This is the man all tattered and torn that kissed the maiden all forlorn that milked the cow with the crumpled horn that tossed the dog that worried the cat that killed the rat that ate the malt that lay in the house that Jack built."]
                  (sol/recite 4 8)))

(t/deftest "full rhyme"
  (t/assert-equal ["This is the house that Jack built."
                   "This is the malt that lay in the house that Jack built."
                   "This is the rat that ate the malt that lay in the house that Jack built."
                   "This is the cat that killed the rat that ate the malt that lay in the house that Jack built."
                   "This is the dog that worried the cat that killed the rat that ate the malt that lay in the house that Jack built."
                   "This is the cow with the crumpled horn that tossed the dog that worried the cat that killed the rat that ate the malt that lay in the house that Jack built."
                   "This is the maiden all forlorn that milked the cow with the crumpled horn that tossed the dog that worried the cat that killed the rat that ate the malt that lay in the house that Jack built."
                   "This is the man all tattered and torn that kissed the maiden all forlorn that milked the cow with the crumpled horn that tossed the dog that worried the cat that killed the rat that ate the malt that lay in the house that Jack built."
                   "This is the priest all shaven and shorn that married the man all tattered and torn that kissed the maiden all forlorn that milked the cow with the crumpled horn that tossed the dog that worried the cat that killed the rat that ate the malt that lay in the house that Jack built."
                   "This is the rooster that crowed in the morn that woke the priest all shaven and shorn that married the man all tattered and torn that kissed the maiden all forlorn that milked the cow with the crumpled horn that tossed the dog that worried the cat that killed the rat that ate the malt that lay in the house that Jack built."
                   "This is the farmer sowing his corn that kept the rooster that crowed in the morn that woke the priest all shaven and shorn that married the man all tattered and torn that kissed the maiden all forlorn that milked the cow with the crumpled horn that tossed the dog that worried the cat that killed the rat that ate the malt that lay in the house that Jack built."
                   "This is the horse and the hound and the horn that belonged to the farmer sowing his corn that kept the rooster that crowed in the morn that woke the priest all shaven and shorn that married the man all tattered and torn that kissed the maiden all forlorn that milked the cow with the crumpled horn that tossed the dog that worried the cat that killed the rat that ate the malt that lay in the house that Jack built."]
                  (sol/recite 1 12)))

(t/run)
