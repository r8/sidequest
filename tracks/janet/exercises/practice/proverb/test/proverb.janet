(import test :as t)
(import ../proverb :as sol)

(t/deftest "zero pieces"
  (t/assert-equal [] (sol/recite [])))

(t/deftest "one piece"
  (t/assert-equal ["And all for the want of a nail."] (sol/recite ["nail"])))

(t/deftest "two pieces"
  (t/assert-equal ["For want of a nail the shoe was lost." "And all for the want of a nail."] (sol/recite ["nail" "shoe"])))

(t/deftest "three pieces"
  (t/assert-equal ["For want of a nail the shoe was lost." "For want of a shoe the horse was lost." "And all for the want of a nail."] (sol/recite ["nail" "shoe" "horse"])))

(t/deftest "full proverb"
  (t/assert-equal ["For want of a nail the shoe was lost." "For want of a shoe the horse was lost." "For want of a horse the rider was lost." "For want of a rider the message was lost." "For want of a message the battle was lost." "For want of a battle the kingdom was lost." "And all for the want of a nail."] (sol/recite ["nail" "shoe" "horse" "rider" "message" "battle" "kingdom"])))

(t/deftest "four pieces modernized"
  (t/assert-equal ["For want of a pin the gun was lost." "For want of a gun the soldier was lost." "For want of a soldier the battle was lost." "And all for the want of a pin."] (sol/recite ["pin" "gun" "soldier" "battle"])))

(t/run)
