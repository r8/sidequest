t ← •Import "../lib/test.bqn"
g ← •Import "../twelve-days.bqn"

recitesFirstThree ← ⟨
  "On the first day of Christmas my true love gave to me: a Partridge in a Pear Tree."
  "On the second day of Christmas my true love gave to me: two Turtle Doves, and a Partridge in a Pear Tree."
  "On the third day of Christmas my true love gave to me: three French Hens, two Turtle Doves, and a Partridge in a Pear Tree."
⟩

recitesThreeVerses ← ⟨
  "On the fourth day of Christmas my true love gave to me: four Calling Birds, three French Hens, two Turtle Doves, and a Partridge in a Pear Tree."
  "On the fifth day of Christmas my true love gave to me: five Gold Rings, four Calling Birds, three French Hens, two Turtle Doves, and a Partridge in a Pear Tree."
  "On the sixth day of Christmas my true love gave to me: six Geese-a-Laying, five Gold Rings, four Calling Birds, three French Hens, two Turtle Doves, and a Partridge in a Pear Tree."
⟩

recitesTheWholeSong ← ⟨
  "On the first day of Christmas my true love gave to me: a Partridge in a Pear Tree."
  "On the second day of Christmas my true love gave to me: two Turtle Doves, and a Partridge in a Pear Tree."
  "On the third day of Christmas my true love gave to me: three French Hens, two Turtle Doves, and a Partridge in a Pear Tree."
  "On the fourth day of Christmas my true love gave to me: four Calling Birds, three French Hens, two Turtle Doves, and a Partridge in a Pear Tree."
  "On the fifth day of Christmas my true love gave to me: five Gold Rings, four Calling Birds, three French Hens, two Turtle Doves, and a Partridge in a Pear Tree."
  "On the sixth day of Christmas my true love gave to me: six Geese-a-Laying, five Gold Rings, four Calling Birds, three French Hens, two Turtle Doves, and a Partridge in a Pear Tree."
  "On the seventh day of Christmas my true love gave to me: seven Swans-a-Swimming, six Geese-a-Laying, five Gold Rings, four Calling Birds, three French Hens, two Turtle Doves, and a Partridge in a Pear Tree."
  "On the eighth day of Christmas my true love gave to me: eight Maids-a-Milking, seven Swans-a-Swimming, six Geese-a-Laying, five Gold Rings, four Calling Birds, three French Hens, two Turtle Doves, and a Partridge in a Pear Tree."
  "On the ninth day of Christmas my true love gave to me: nine Ladies Dancing, eight Maids-a-Milking, seven Swans-a-Swimming, six Geese-a-Laying, five Gold Rings, four Calling Birds, three French Hens, two Turtle Doves, and a Partridge in a Pear Tree."
  "On the tenth day of Christmas my true love gave to me: ten Lords-a-Leaping, nine Ladies Dancing, eight Maids-a-Milking, seven Swans-a-Swimming, six Geese-a-Laying, five Gold Rings, four Calling Birds, three French Hens, two Turtle Doves, and a Partridge in a Pear Tree."
  "On the eleventh day of Christmas my true love gave to me: eleven Pipers Piping, ten Lords-a-Leaping, nine Ladies Dancing, eight Maids-a-Milking, seven Swans-a-Swimming, six Geese-a-Laying, five Gold Rings, four Calling Birds, three French Hens, two Turtle Doves, and a Partridge in a Pear Tree."
  "On the twelfth day of Christmas my true love gave to me: twelve Drummers Drumming, eleven Pipers Piping, ten Lords-a-Leaping, nine Ladies Dancing, eight Maids-a-Milking, seven Swans-a-Swimming, six Geese-a-Laying, five Gold Rings, four Calling Birds, three French Hens, two Turtle Doves, and a Partridge in a Pear Tree."
⟩

t.Run ⟨
  "verse > first day a partridge in a pear tree"‿{𝕊: ⟨"On the first day of Christmas my true love gave to me: a Partridge in a Pear Tree."⟩ t.Expect g.Recite 1‿1}
  "verse > second day two turtle doves"‿{𝕊: ⟨"On the second day of Christmas my true love gave to me: two Turtle Doves, and a Partridge in a Pear Tree."⟩ t.Expect g.Recite 2‿2}
  "verse > third day three french hens"‿{𝕊: ⟨"On the third day of Christmas my true love gave to me: three French Hens, two Turtle Doves, and a Partridge in a Pear Tree."⟩ t.Expect g.Recite 3‿3}
  "verse > fourth day four calling birds"‿{𝕊: ⟨"On the fourth day of Christmas my true love gave to me: four Calling Birds, three French Hens, two Turtle Doves, and a Partridge in a Pear Tree."⟩ t.Expect g.Recite 4‿4}
  "verse > fifth day five gold rings"‿{𝕊: ⟨"On the fifth day of Christmas my true love gave to me: five Gold Rings, four Calling Birds, three French Hens, two Turtle Doves, and a Partridge in a Pear Tree."⟩ t.Expect g.Recite 5‿5}
  "verse > sixth day six geese-a-laying"‿{𝕊: ⟨"On the sixth day of Christmas my true love gave to me: six Geese-a-Laying, five Gold Rings, four Calling Birds, three French Hens, two Turtle Doves, and a Partridge in a Pear Tree."⟩ t.Expect g.Recite 6‿6}
  "verse > seventh day seven swans-a-swimming"‿{𝕊: ⟨"On the seventh day of Christmas my true love gave to me: seven Swans-a-Swimming, six Geese-a-Laying, five Gold Rings, four Calling Birds, three French Hens, two Turtle Doves, and a Partridge in a Pear Tree."⟩ t.Expect g.Recite 7‿7}
  "verse > eighth day eight maids-a-milking"‿{𝕊: ⟨"On the eighth day of Christmas my true love gave to me: eight Maids-a-Milking, seven Swans-a-Swimming, six Geese-a-Laying, five Gold Rings, four Calling Birds, three French Hens, two Turtle Doves, and a Partridge in a Pear Tree."⟩ t.Expect g.Recite 8‿8}
  "verse > ninth day nine ladies dancing"‿{𝕊: ⟨"On the ninth day of Christmas my true love gave to me: nine Ladies Dancing, eight Maids-a-Milking, seven Swans-a-Swimming, six Geese-a-Laying, five Gold Rings, four Calling Birds, three French Hens, two Turtle Doves, and a Partridge in a Pear Tree."⟩ t.Expect g.Recite 9‿9}
  "verse > tenth day ten lords-a-leaping"‿{𝕊: ⟨"On the tenth day of Christmas my true love gave to me: ten Lords-a-Leaping, nine Ladies Dancing, eight Maids-a-Milking, seven Swans-a-Swimming, six Geese-a-Laying, five Gold Rings, four Calling Birds, three French Hens, two Turtle Doves, and a Partridge in a Pear Tree."⟩ t.Expect g.Recite 10‿10}
  "verse > eleventh day eleven pipers piping"‿{𝕊: ⟨"On the eleventh day of Christmas my true love gave to me: eleven Pipers Piping, ten Lords-a-Leaping, nine Ladies Dancing, eight Maids-a-Milking, seven Swans-a-Swimming, six Geese-a-Laying, five Gold Rings, four Calling Birds, three French Hens, two Turtle Doves, and a Partridge in a Pear Tree."⟩ t.Expect g.Recite 11‿11}
  "verse > twelfth day twelve drummers drumming"‿{𝕊: ⟨"On the twelfth day of Christmas my true love gave to me: twelve Drummers Drumming, eleven Pipers Piping, ten Lords-a-Leaping, nine Ladies Dancing, eight Maids-a-Milking, seven Swans-a-Swimming, six Geese-a-Laying, five Gold Rings, four Calling Birds, three French Hens, two Turtle Doves, and a Partridge in a Pear Tree."⟩ t.Expect g.Recite 12‿12}
  "lyrics > recites first three verses of the song"‿{𝕊: recitesFirstThree t.Expect g.Recite 1‿3}
  "lyrics > recites three verses from the middle of the song"‿{𝕊: recitesThreeVerses t.Expect g.Recite 4‿6}
  "lyrics > recites the whole song"‿{𝕊: recitesTheWholeSong t.Expect g.Recite 1‿12}
⟩
