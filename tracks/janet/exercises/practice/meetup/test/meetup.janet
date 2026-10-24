(import test :as t)
(import ../meetup :as sol)

(t/deftest "when teenth Monday is the 13th, the first day of the teenth week"
  (t/assert-equal "2013-05-13" (sol/meetup 2013 5 :teenth :monday)))

(t/deftest "when teenth Monday is the 19th, the last day of the teenth week"
  (t/assert-equal "2013-08-19" (sol/meetup 2013 8 :teenth :monday)))

(t/deftest "when teenth Monday is some day in the middle of the teenth week"
  (t/assert-equal "2013-09-16" (sol/meetup 2013 9 :teenth :monday)))

(t/deftest "when teenth Tuesday is the 19th, the last day of the teenth week"
  (t/assert-equal "2013-03-19" (sol/meetup 2013 3 :teenth :tuesday)))

(t/deftest "when teenth Tuesday is some day in the middle of the teenth week"
  (t/assert-equal "2013-04-16" (sol/meetup 2013 4 :teenth :tuesday)))

(t/deftest "when teenth Tuesday is the 13th, the first day of the teenth week"
  (t/assert-equal "2013-08-13" (sol/meetup 2013 8 :teenth :tuesday)))

(t/deftest "when teenth Wednesday is some day in the middle of the teenth week"
  (t/assert-equal "2013-01-16" (sol/meetup 2013 1 :teenth :wednesday)))

(t/deftest "when teenth Wednesday is the 13th, the first day of the teenth week"
  (t/assert-equal "2013-02-13" (sol/meetup 2013 2 :teenth :wednesday)))

(t/deftest "when teenth Wednesday is the 19th, the last day of the teenth week"
  (t/assert-equal "2013-06-19" (sol/meetup 2013 6 :teenth :wednesday)))

(t/deftest "when teenth Thursday is some day in the middle of the teenth week"
  (t/assert-equal "2013-05-16" (sol/meetup 2013 5 :teenth :thursday)))

(t/deftest "when teenth Thursday is the 13th, the first day of the teenth week"
  (t/assert-equal "2013-06-13" (sol/meetup 2013 6 :teenth :thursday)))

(t/deftest "when teenth Thursday is the 19th, the last day of the teenth week"
  (t/assert-equal "2013-09-19" (sol/meetup 2013 9 :teenth :thursday)))

(t/deftest "when teenth Friday is the 19th, the last day of the teenth week"
  (t/assert-equal "2013-04-19" (sol/meetup 2013 4 :teenth :friday)))

(t/deftest "when teenth Friday is some day in the middle of the teenth week"
  (t/assert-equal "2013-08-16" (sol/meetup 2013 8 :teenth :friday)))

(t/deftest "when teenth Friday is the 13th, the first day of the teenth week"
  (t/assert-equal "2013-09-13" (sol/meetup 2013 9 :teenth :friday)))

(t/deftest "when teenth Saturday is some day in the middle of the teenth week"
  (t/assert-equal "2013-02-16" (sol/meetup 2013 2 :teenth :saturday)))

(t/deftest "when teenth Saturday is the 13th, the first day of the teenth week"
  (t/assert-equal "2013-04-13" (sol/meetup 2013 4 :teenth :saturday)))

(t/deftest "when teenth Saturday is the 19th, the last day of the teenth week"
  (t/assert-equal "2013-10-19" (sol/meetup 2013 10 :teenth :saturday)))

(t/deftest "when teenth Sunday is the 19th, the last day of the teenth week"
  (t/assert-equal "2013-05-19" (sol/meetup 2013 5 :teenth :sunday)))

(t/deftest "when teenth Sunday is some day in the middle of the teenth week"
  (t/assert-equal "2013-06-16" (sol/meetup 2013 6 :teenth :sunday)))

(t/deftest "when teenth Sunday is the 13th, the first day of the teenth week"
  (t/assert-equal "2013-10-13" (sol/meetup 2013 10 :teenth :sunday)))

(t/deftest "when first Monday is some day in the middle of the first week"
  (t/assert-equal "2013-03-04" (sol/meetup 2013 3 :first :monday)))

(t/deftest "when first Monday is the 1st, the first day of the first week"
  (t/assert-equal "2013-04-01" (sol/meetup 2013 4 :first :monday)))

(t/deftest "when first Tuesday is the 7th, the last day of the first week"
  (t/assert-equal "2013-05-07" (sol/meetup 2013 5 :first :tuesday)))

(t/deftest "when first Tuesday is some day in the middle of the first week"
  (t/assert-equal "2013-06-04" (sol/meetup 2013 6 :first :tuesday)))

(t/deftest "when first Wednesday is some day in the middle of the first week"
  (t/assert-equal "2013-07-03" (sol/meetup 2013 7 :first :wednesday)))

(t/deftest "when first Wednesday is the 7th, the last day of the first week"
  (t/assert-equal "2013-08-07" (sol/meetup 2013 8 :first :wednesday)))

(t/deftest "when first Thursday is some day in the middle of the first week"
  (t/assert-equal "2013-09-05" (sol/meetup 2013 9 :first :thursday)))

(t/deftest "when first Thursday is another day in the middle of the first week"
  (t/assert-equal "2013-10-03" (sol/meetup 2013 10 :first :thursday)))

(t/deftest "when first Friday is the 1st, the first day of the first week"
  (t/assert-equal "2013-11-01" (sol/meetup 2013 11 :first :friday)))

(t/deftest "when first Friday is some day in the middle of the first week"
  (t/assert-equal "2013-12-06" (sol/meetup 2013 12 :first :friday)))

(t/deftest "when first Saturday is some day in the middle of the first week"
  (t/assert-equal "2013-01-05" (sol/meetup 2013 1 :first :saturday)))

(t/deftest "when first Saturday is another day in the middle of the first week"
  (t/assert-equal "2013-02-02" (sol/meetup 2013 2 :first :saturday)))

(t/deftest "when first Sunday is some day in the middle of the first week"
  (t/assert-equal "2013-03-03" (sol/meetup 2013 3 :first :sunday)))

(t/deftest "when first Sunday is the 7th, the last day of the first week"
  (t/assert-equal "2013-04-07" (sol/meetup 2013 4 :first :sunday)))

(t/deftest "when second Monday is some day in the middle of the second week"
  (t/assert-equal "2013-03-11" (sol/meetup 2013 3 :second :monday)))

(t/deftest "when second Monday is the 8th, the first day of the second week"
  (t/assert-equal "2013-04-08" (sol/meetup 2013 4 :second :monday)))

(t/deftest "when second Tuesday is the 14th, the last day of the second week"
  (t/assert-equal "2013-05-14" (sol/meetup 2013 5 :second :tuesday)))

(t/deftest "when second Tuesday is some day in the middle of the second week"
  (t/assert-equal "2013-06-11" (sol/meetup 2013 6 :second :tuesday)))

(t/deftest "when second Wednesday is some day in the middle of the second week"
  (t/assert-equal "2013-07-10" (sol/meetup 2013 7 :second :wednesday)))

(t/deftest "when second Wednesday is the 14th, the last day of the second week"
  (t/assert-equal "2013-08-14" (sol/meetup 2013 8 :second :wednesday)))

(t/deftest "when second Thursday is some day in the middle of the second week"
  (t/assert-equal "2013-09-12" (sol/meetup 2013 9 :second :thursday)))

(t/deftest "when second Thursday is another day in the middle of the second week"
  (t/assert-equal "2013-10-10" (sol/meetup 2013 10 :second :thursday)))

(t/deftest "when second Friday is the 8th, the first day of the second week"
  (t/assert-equal "2013-11-08" (sol/meetup 2013 11 :second :friday)))

(t/deftest "when second Friday is some day in the middle of the second week"
  (t/assert-equal "2013-12-13" (sol/meetup 2013 12 :second :friday)))

(t/deftest "when second Saturday is some day in the middle of the second week"
  (t/assert-equal "2013-01-12" (sol/meetup 2013 1 :second :saturday)))

(t/deftest "when second Saturday is another day in the middle of the second week"
  (t/assert-equal "2013-02-09" (sol/meetup 2013 2 :second :saturday)))

(t/deftest "when second Sunday is some day in the middle of the second week"
  (t/assert-equal "2013-03-10" (sol/meetup 2013 3 :second :sunday)))

(t/deftest "when second Sunday is the 14th, the last day of the second week"
  (t/assert-equal "2013-04-14" (sol/meetup 2013 4 :second :sunday)))

(t/deftest "when third Monday is some day in the middle of the third week"
  (t/assert-equal "2013-03-18" (sol/meetup 2013 3 :third :monday)))

(t/deftest "when third Monday is the 15th, the first day of the third week"
  (t/assert-equal "2013-04-15" (sol/meetup 2013 4 :third :monday)))

(t/deftest "when third Tuesday is the 21st, the last day of the third week"
  (t/assert-equal "2013-05-21" (sol/meetup 2013 5 :third :tuesday)))

(t/deftest "when third Tuesday is some day in the middle of the third week"
  (t/assert-equal "2013-06-18" (sol/meetup 2013 6 :third :tuesday)))

(t/deftest "when third Wednesday is some day in the middle of the third week"
  (t/assert-equal "2013-07-17" (sol/meetup 2013 7 :third :wednesday)))

(t/deftest "when third Wednesday is the 21st, the last day of the third week"
  (t/assert-equal "2013-08-21" (sol/meetup 2013 8 :third :wednesday)))

(t/deftest "when third Thursday is some day in the middle of the third week"
  (t/assert-equal "2013-09-19" (sol/meetup 2013 9 :third :thursday)))

(t/deftest "when third Thursday is another day in the middle of the third week"
  (t/assert-equal "2013-10-17" (sol/meetup 2013 10 :third :thursday)))

(t/deftest "when third Friday is the 15th, the first day of the third week"
  (t/assert-equal "2013-11-15" (sol/meetup 2013 11 :third :friday)))

(t/deftest "when third Friday is some day in the middle of the third week"
  (t/assert-equal "2013-12-20" (sol/meetup 2013 12 :third :friday)))

(t/deftest "when third Saturday is some day in the middle of the third week"
  (t/assert-equal "2013-01-19" (sol/meetup 2013 1 :third :saturday)))

(t/deftest "when third Saturday is another day in the middle of the third week"
  (t/assert-equal "2013-02-16" (sol/meetup 2013 2 :third :saturday)))

(t/deftest "when third Sunday is some day in the middle of the third week"
  (t/assert-equal "2013-03-17" (sol/meetup 2013 3 :third :sunday)))

(t/deftest "when third Sunday is the 21st, the last day of the third week"
  (t/assert-equal "2013-04-21" (sol/meetup 2013 4 :third :sunday)))

(t/deftest "when fourth Monday is some day in the middle of the fourth week"
  (t/assert-equal "2013-03-25" (sol/meetup 2013 3 :fourth :monday)))

(t/deftest "when fourth Monday is the 22nd, the first day of the fourth week"
  (t/assert-equal "2013-04-22" (sol/meetup 2013 4 :fourth :monday)))

(t/deftest "when fourth Tuesday is the 28th, the last day of the fourth week"
  (t/assert-equal "2013-05-28" (sol/meetup 2013 5 :fourth :tuesday)))

(t/deftest "when fourth Tuesday is some day in the middle of the fourth week"
  (t/assert-equal "2013-06-25" (sol/meetup 2013 6 :fourth :tuesday)))

(t/deftest "when fourth Wednesday is some day in the middle of the fourth week"
  (t/assert-equal "2013-07-24" (sol/meetup 2013 7 :fourth :wednesday)))

(t/deftest "when fourth Wednesday is the 28th, the last day of the fourth week"
  (t/assert-equal "2013-08-28" (sol/meetup 2013 8 :fourth :wednesday)))

(t/deftest "when fourth Thursday is some day in the middle of the fourth week"
  (t/assert-equal "2013-09-26" (sol/meetup 2013 9 :fourth :thursday)))

(t/deftest "when fourth Thursday is another day in the middle of the fourth week"
  (t/assert-equal "2013-10-24" (sol/meetup 2013 10 :fourth :thursday)))

(t/deftest "when fourth Friday is the 22nd, the first day of the fourth week"
  (t/assert-equal "2013-11-22" (sol/meetup 2013 11 :fourth :friday)))

(t/deftest "when fourth Friday is some day in the middle of the fourth week"
  (t/assert-equal "2013-12-27" (sol/meetup 2013 12 :fourth :friday)))

(t/deftest "when fourth Saturday is some day in the middle of the fourth week"
  (t/assert-equal "2013-01-26" (sol/meetup 2013 1 :fourth :saturday)))

(t/deftest "when fourth Saturday is another day in the middle of the fourth week"
  (t/assert-equal "2013-02-23" (sol/meetup 2013 2 :fourth :saturday)))

(t/deftest "when fourth Sunday is some day in the middle of the fourth week"
  (t/assert-equal "2013-03-24" (sol/meetup 2013 3 :fourth :sunday)))

(t/deftest "when fourth Sunday is the 28th, the last day of the fourth week"
  (t/assert-equal "2013-04-28" (sol/meetup 2013 4 :fourth :sunday)))

(t/deftest "last Monday in a month with four Mondays"
  (t/assert-equal "2013-03-25" (sol/meetup 2013 3 :last :monday)))

(t/deftest "last Monday in a month with five Mondays"
  (t/assert-equal "2013-04-29" (sol/meetup 2013 4 :last :monday)))

(t/deftest "last Tuesday in a month with four Tuesdays"
  (t/assert-equal "2013-05-28" (sol/meetup 2013 5 :last :tuesday)))

(t/deftest "last Tuesday in another month with four Tuesdays"
  (t/assert-equal "2013-06-25" (sol/meetup 2013 6 :last :tuesday)))

(t/deftest "last Wednesday in a month with five Wednesdays"
  (t/assert-equal "2013-07-31" (sol/meetup 2013 7 :last :wednesday)))

(t/deftest "last Wednesday in a month with four Wednesdays"
  (t/assert-equal "2013-08-28" (sol/meetup 2013 8 :last :wednesday)))

(t/deftest "last Thursday in a month with four Thursdays"
  (t/assert-equal "2013-09-26" (sol/meetup 2013 9 :last :thursday)))

(t/deftest "last Thursday in a month with five Thursdays"
  (t/assert-equal "2013-10-31" (sol/meetup 2013 10 :last :thursday)))

(t/deftest "last Friday in a month with five Fridays"
  (t/assert-equal "2013-11-29" (sol/meetup 2013 11 :last :friday)))

(t/deftest "last Friday in a month with four Fridays"
  (t/assert-equal "2013-12-27" (sol/meetup 2013 12 :last :friday)))

(t/deftest "last Saturday in a month with four Saturdays"
  (t/assert-equal "2013-01-26" (sol/meetup 2013 1 :last :saturday)))

(t/deftest "last Saturday in another month with four Saturdays"
  (t/assert-equal "2013-02-23" (sol/meetup 2013 2 :last :saturday)))

(t/deftest "last Sunday in a month with five Sundays"
  (t/assert-equal "2013-03-31" (sol/meetup 2013 3 :last :sunday)))

(t/deftest "last Sunday in a month with four Sundays"
  (t/assert-equal "2013-04-28" (sol/meetup 2013 4 :last :sunday)))

(t/deftest "when last Wednesday in February in a leap year is the 29th"
  (t/assert-equal "2012-02-29" (sol/meetup 2012 2 :last :wednesday)))

(t/deftest "last Wednesday in December that is also the last day of the year"
  (t/assert-equal "2014-12-31" (sol/meetup 2014 12 :last :wednesday)))

(t/deftest "when last Sunday in February in a non-leap year is not the 29th"
  (t/assert-equal "2015-02-22" (sol/meetup 2015 2 :last :sunday)))

(t/deftest "when first Friday is the 7th, the last day of the first week"
  (t/assert-equal "2012-12-07" (sol/meetup 2012 12 :first :friday)))

(t/run)
