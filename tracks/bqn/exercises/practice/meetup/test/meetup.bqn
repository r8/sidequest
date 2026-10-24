t ← •Import "../lib/test.bqn"
g ← •Import "../meetup.bqn"

t.Run ⟨
  "when teenth Monday is the 13th, the first day of the teenth week"‿{𝕊: "2013-05-13" t.Expect g.Meetup 2013‿5‿"teenth"‿"Monday"}
  "when teenth Monday is the 19th, the last day of the teenth week"‿{𝕊: "2013-08-19" t.Expect g.Meetup 2013‿8‿"teenth"‿"Monday"}
  "when teenth Monday is some day in the middle of the teenth week"‿{𝕊: "2013-09-16" t.Expect g.Meetup 2013‿9‿"teenth"‿"Monday"}
  "when teenth Tuesday is the 19th, the last day of the teenth week"‿{𝕊: "2013-03-19" t.Expect g.Meetup 2013‿3‿"teenth"‿"Tuesday"}
  "when teenth Tuesday is some day in the middle of the teenth week"‿{𝕊: "2013-04-16" t.Expect g.Meetup 2013‿4‿"teenth"‿"Tuesday"}
  "when teenth Tuesday is the 13th, the first day of the teenth week"‿{𝕊: "2013-08-13" t.Expect g.Meetup 2013‿8‿"teenth"‿"Tuesday"}
  "when teenth Wednesday is some day in the middle of the teenth week"‿{𝕊: "2013-01-16" t.Expect g.Meetup 2013‿1‿"teenth"‿"Wednesday"}
  "when teenth Wednesday is the 13th, the first day of the teenth week"‿{𝕊: "2013-02-13" t.Expect g.Meetup 2013‿2‿"teenth"‿"Wednesday"}
  "when teenth Wednesday is the 19th, the last day of the teenth week"‿{𝕊: "2013-06-19" t.Expect g.Meetup 2013‿6‿"teenth"‿"Wednesday"}
  "when teenth Thursday is some day in the middle of the teenth week"‿{𝕊: "2013-05-16" t.Expect g.Meetup 2013‿5‿"teenth"‿"Thursday"}
  "when teenth Thursday is the 13th, the first day of the teenth week"‿{𝕊: "2013-06-13" t.Expect g.Meetup 2013‿6‿"teenth"‿"Thursday"}
  "when teenth Thursday is the 19th, the last day of the teenth week"‿{𝕊: "2013-09-19" t.Expect g.Meetup 2013‿9‿"teenth"‿"Thursday"}
  "when teenth Friday is the 19th, the last day of the teenth week"‿{𝕊: "2013-04-19" t.Expect g.Meetup 2013‿4‿"teenth"‿"Friday"}
  "when teenth Friday is some day in the middle of the teenth week"‿{𝕊: "2013-08-16" t.Expect g.Meetup 2013‿8‿"teenth"‿"Friday"}
  "when teenth Friday is the 13th, the first day of the teenth week"‿{𝕊: "2013-09-13" t.Expect g.Meetup 2013‿9‿"teenth"‿"Friday"}
  "when teenth Saturday is some day in the middle of the teenth week"‿{𝕊: "2013-02-16" t.Expect g.Meetup 2013‿2‿"teenth"‿"Saturday"}
  "when teenth Saturday is the 13th, the first day of the teenth week"‿{𝕊: "2013-04-13" t.Expect g.Meetup 2013‿4‿"teenth"‿"Saturday"}
  "when teenth Saturday is the 19th, the last day of the teenth week"‿{𝕊: "2013-10-19" t.Expect g.Meetup 2013‿10‿"teenth"‿"Saturday"}
  "when teenth Sunday is the 19th, the last day of the teenth week"‿{𝕊: "2013-05-19" t.Expect g.Meetup 2013‿5‿"teenth"‿"Sunday"}
  "when teenth Sunday is some day in the middle of the teenth week"‿{𝕊: "2013-06-16" t.Expect g.Meetup 2013‿6‿"teenth"‿"Sunday"}
  "when teenth Sunday is the 13th, the first day of the teenth week"‿{𝕊: "2013-10-13" t.Expect g.Meetup 2013‿10‿"teenth"‿"Sunday"}
  "when first Monday is some day in the middle of the first week"‿{𝕊: "2013-03-04" t.Expect g.Meetup 2013‿3‿"first"‿"Monday"}
  "when first Monday is the 1st, the first day of the first week"‿{𝕊: "2013-04-01" t.Expect g.Meetup 2013‿4‿"first"‿"Monday"}
  "when first Tuesday is the 7th, the last day of the first week"‿{𝕊: "2013-05-07" t.Expect g.Meetup 2013‿5‿"first"‿"Tuesday"}
  "when first Tuesday is some day in the middle of the first week"‿{𝕊: "2013-06-04" t.Expect g.Meetup 2013‿6‿"first"‿"Tuesday"}
  "when first Wednesday is some day in the middle of the first week"‿{𝕊: "2013-07-03" t.Expect g.Meetup 2013‿7‿"first"‿"Wednesday"}
  "when first Wednesday is the 7th, the last day of the first week"‿{𝕊: "2013-08-07" t.Expect g.Meetup 2013‿8‿"first"‿"Wednesday"}
  "when first Thursday is some day in the middle of the first week"‿{𝕊: "2013-09-05" t.Expect g.Meetup 2013‿9‿"first"‿"Thursday"}
  "when first Thursday is another day in the middle of the first week"‿{𝕊: "2013-10-03" t.Expect g.Meetup 2013‿10‿"first"‿"Thursday"}
  "when first Friday is the 1st, the first day of the first week"‿{𝕊: "2013-11-01" t.Expect g.Meetup 2013‿11‿"first"‿"Friday"}
  "when first Friday is some day in the middle of the first week"‿{𝕊: "2013-12-06" t.Expect g.Meetup 2013‿12‿"first"‿"Friday"}
  "when first Saturday is some day in the middle of the first week"‿{𝕊: "2013-01-05" t.Expect g.Meetup 2013‿1‿"first"‿"Saturday"}
  "when first Saturday is another day in the middle of the first week"‿{𝕊: "2013-02-02" t.Expect g.Meetup 2013‿2‿"first"‿"Saturday"}
  "when first Sunday is some day in the middle of the first week"‿{𝕊: "2013-03-03" t.Expect g.Meetup 2013‿3‿"first"‿"Sunday"}
  "when first Sunday is the 7th, the last day of the first week"‿{𝕊: "2013-04-07" t.Expect g.Meetup 2013‿4‿"first"‿"Sunday"}
  "when second Monday is some day in the middle of the second week"‿{𝕊: "2013-03-11" t.Expect g.Meetup 2013‿3‿"second"‿"Monday"}
  "when second Monday is the 8th, the first day of the second week"‿{𝕊: "2013-04-08" t.Expect g.Meetup 2013‿4‿"second"‿"Monday"}
  "when second Tuesday is the 14th, the last day of the second week"‿{𝕊: "2013-05-14" t.Expect g.Meetup 2013‿5‿"second"‿"Tuesday"}
  "when second Tuesday is some day in the middle of the second week"‿{𝕊: "2013-06-11" t.Expect g.Meetup 2013‿6‿"second"‿"Tuesday"}
  "when second Wednesday is some day in the middle of the second week"‿{𝕊: "2013-07-10" t.Expect g.Meetup 2013‿7‿"second"‿"Wednesday"}
  "when second Wednesday is the 14th, the last day of the second week"‿{𝕊: "2013-08-14" t.Expect g.Meetup 2013‿8‿"second"‿"Wednesday"}
  "when second Thursday is some day in the middle of the second week"‿{𝕊: "2013-09-12" t.Expect g.Meetup 2013‿9‿"second"‿"Thursday"}
  "when second Thursday is another day in the middle of the second week"‿{𝕊: "2013-10-10" t.Expect g.Meetup 2013‿10‿"second"‿"Thursday"}
  "when second Friday is the 8th, the first day of the second week"‿{𝕊: "2013-11-08" t.Expect g.Meetup 2013‿11‿"second"‿"Friday"}
  "when second Friday is some day in the middle of the second week"‿{𝕊: "2013-12-13" t.Expect g.Meetup 2013‿12‿"second"‿"Friday"}
  "when second Saturday is some day in the middle of the second week"‿{𝕊: "2013-01-12" t.Expect g.Meetup 2013‿1‿"second"‿"Saturday"}
  "when second Saturday is another day in the middle of the second week"‿{𝕊: "2013-02-09" t.Expect g.Meetup 2013‿2‿"second"‿"Saturday"}
  "when second Sunday is some day in the middle of the second week"‿{𝕊: "2013-03-10" t.Expect g.Meetup 2013‿3‿"second"‿"Sunday"}
  "when second Sunday is the 14th, the last day of the second week"‿{𝕊: "2013-04-14" t.Expect g.Meetup 2013‿4‿"second"‿"Sunday"}
  "when third Monday is some day in the middle of the third week"‿{𝕊: "2013-03-18" t.Expect g.Meetup 2013‿3‿"third"‿"Monday"}
  "when third Monday is the 15th, the first day of the third week"‿{𝕊: "2013-04-15" t.Expect g.Meetup 2013‿4‿"third"‿"Monday"}
  "when third Tuesday is the 21st, the last day of the third week"‿{𝕊: "2013-05-21" t.Expect g.Meetup 2013‿5‿"third"‿"Tuesday"}
  "when third Tuesday is some day in the middle of the third week"‿{𝕊: "2013-06-18" t.Expect g.Meetup 2013‿6‿"third"‿"Tuesday"}
  "when third Wednesday is some day in the middle of the third week"‿{𝕊: "2013-07-17" t.Expect g.Meetup 2013‿7‿"third"‿"Wednesday"}
  "when third Wednesday is the 21st, the last day of the third week"‿{𝕊: "2013-08-21" t.Expect g.Meetup 2013‿8‿"third"‿"Wednesday"}
  "when third Thursday is some day in the middle of the third week"‿{𝕊: "2013-09-19" t.Expect g.Meetup 2013‿9‿"third"‿"Thursday"}
  "when third Thursday is another day in the middle of the third week"‿{𝕊: "2013-10-17" t.Expect g.Meetup 2013‿10‿"third"‿"Thursday"}
  "when third Friday is the 15th, the first day of the third week"‿{𝕊: "2013-11-15" t.Expect g.Meetup 2013‿11‿"third"‿"Friday"}
  "when third Friday is some day in the middle of the third week"‿{𝕊: "2013-12-20" t.Expect g.Meetup 2013‿12‿"third"‿"Friday"}
  "when third Saturday is some day in the middle of the third week"‿{𝕊: "2013-01-19" t.Expect g.Meetup 2013‿1‿"third"‿"Saturday"}
  "when third Saturday is another day in the middle of the third week"‿{𝕊: "2013-02-16" t.Expect g.Meetup 2013‿2‿"third"‿"Saturday"}
  "when third Sunday is some day in the middle of the third week"‿{𝕊: "2013-03-17" t.Expect g.Meetup 2013‿3‿"third"‿"Sunday"}
  "when third Sunday is the 21st, the last day of the third week"‿{𝕊: "2013-04-21" t.Expect g.Meetup 2013‿4‿"third"‿"Sunday"}
  "when fourth Monday is some day in the middle of the fourth week"‿{𝕊: "2013-03-25" t.Expect g.Meetup 2013‿3‿"fourth"‿"Monday"}
  "when fourth Monday is the 22nd, the first day of the fourth week"‿{𝕊: "2013-04-22" t.Expect g.Meetup 2013‿4‿"fourth"‿"Monday"}
  "when fourth Tuesday is the 28th, the last day of the fourth week"‿{𝕊: "2013-05-28" t.Expect g.Meetup 2013‿5‿"fourth"‿"Tuesday"}
  "when fourth Tuesday is some day in the middle of the fourth week"‿{𝕊: "2013-06-25" t.Expect g.Meetup 2013‿6‿"fourth"‿"Tuesday"}
  "when fourth Wednesday is some day in the middle of the fourth week"‿{𝕊: "2013-07-24" t.Expect g.Meetup 2013‿7‿"fourth"‿"Wednesday"}
  "when fourth Wednesday is the 28th, the last day of the fourth week"‿{𝕊: "2013-08-28" t.Expect g.Meetup 2013‿8‿"fourth"‿"Wednesday"}
  "when fourth Thursday is some day in the middle of the fourth week"‿{𝕊: "2013-09-26" t.Expect g.Meetup 2013‿9‿"fourth"‿"Thursday"}
  "when fourth Thursday is another day in the middle of the fourth week"‿{𝕊: "2013-10-24" t.Expect g.Meetup 2013‿10‿"fourth"‿"Thursday"}
  "when fourth Friday is the 22nd, the first day of the fourth week"‿{𝕊: "2013-11-22" t.Expect g.Meetup 2013‿11‿"fourth"‿"Friday"}
  "when fourth Friday is some day in the middle of the fourth week"‿{𝕊: "2013-12-27" t.Expect g.Meetup 2013‿12‿"fourth"‿"Friday"}
  "when fourth Saturday is some day in the middle of the fourth week"‿{𝕊: "2013-01-26" t.Expect g.Meetup 2013‿1‿"fourth"‿"Saturday"}
  "when fourth Saturday is another day in the middle of the fourth week"‿{𝕊: "2013-02-23" t.Expect g.Meetup 2013‿2‿"fourth"‿"Saturday"}
  "when fourth Sunday is some day in the middle of the fourth week"‿{𝕊: "2013-03-24" t.Expect g.Meetup 2013‿3‿"fourth"‿"Sunday"}
  "when fourth Sunday is the 28th, the last day of the fourth week"‿{𝕊: "2013-04-28" t.Expect g.Meetup 2013‿4‿"fourth"‿"Sunday"}
  "last Monday in a month with four Mondays"‿{𝕊: "2013-03-25" t.Expect g.Meetup 2013‿3‿"last"‿"Monday"}
  "last Monday in a month with five Mondays"‿{𝕊: "2013-04-29" t.Expect g.Meetup 2013‿4‿"last"‿"Monday"}
  "last Tuesday in a month with four Tuesdays"‿{𝕊: "2013-05-28" t.Expect g.Meetup 2013‿5‿"last"‿"Tuesday"}
  "last Tuesday in another month with four Tuesdays"‿{𝕊: "2013-06-25" t.Expect g.Meetup 2013‿6‿"last"‿"Tuesday"}
  "last Wednesday in a month with five Wednesdays"‿{𝕊: "2013-07-31" t.Expect g.Meetup 2013‿7‿"last"‿"Wednesday"}
  "last Wednesday in a month with four Wednesdays"‿{𝕊: "2013-08-28" t.Expect g.Meetup 2013‿8‿"last"‿"Wednesday"}
  "last Thursday in a month with four Thursdays"‿{𝕊: "2013-09-26" t.Expect g.Meetup 2013‿9‿"last"‿"Thursday"}
  "last Thursday in a month with five Thursdays"‿{𝕊: "2013-10-31" t.Expect g.Meetup 2013‿10‿"last"‿"Thursday"}
  "last Friday in a month with five Fridays"‿{𝕊: "2013-11-29" t.Expect g.Meetup 2013‿11‿"last"‿"Friday"}
  "last Friday in a month with four Fridays"‿{𝕊: "2013-12-27" t.Expect g.Meetup 2013‿12‿"last"‿"Friday"}
  "last Saturday in a month with four Saturdays"‿{𝕊: "2013-01-26" t.Expect g.Meetup 2013‿1‿"last"‿"Saturday"}
  "last Saturday in another month with four Saturdays"‿{𝕊: "2013-02-23" t.Expect g.Meetup 2013‿2‿"last"‿"Saturday"}
  "last Sunday in a month with five Sundays"‿{𝕊: "2013-03-31" t.Expect g.Meetup 2013‿3‿"last"‿"Sunday"}
  "last Sunday in a month with four Sundays"‿{𝕊: "2013-04-28" t.Expect g.Meetup 2013‿4‿"last"‿"Sunday"}
  "when last Wednesday in February in a leap year is the 29th"‿{𝕊: "2012-02-29" t.Expect g.Meetup 2012‿2‿"last"‿"Wednesday"}
  "last Wednesday in December that is also the last day of the year"‿{𝕊: "2014-12-31" t.Expect g.Meetup 2014‿12‿"last"‿"Wednesday"}
  "when last Sunday in February in a non-leap year is not the 29th"‿{𝕊: "2015-02-22" t.Expect g.Meetup 2015‿2‿"last"‿"Sunday"}
  "when first Friday is the 7th, the last day of the first week"‿{𝕊: "2012-12-07" t.Expect g.Meetup 2012‿12‿"first"‿"Friday"}
⟩
