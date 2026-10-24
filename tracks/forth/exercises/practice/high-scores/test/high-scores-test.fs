require ../lib/test.fs
require ../high-scores.fs

create some-scores 30 , 50 , 20 , 70 ,
test" List of scores"  some-scores 4 scores some-scores 4 assert-cells= ;test

create latest-30 100 , 0 , 90 , 30 ,
test" Latest score"  latest-30 4 latest-score 30 assert= ;test

create best-100 40 , 100 , 70 ,
test" Personal best"  best-100 3 personal-best 100 assert= ;test

create many-scores 10 , 30 , 90 , 30 , 100 , 20 , 10 , 0 , 30 , 40 , 40 , 70 , 70 ,
create top-of-many 100 , 90 , 70 ,
test" Top 3 scores > Personal top three from a list of scores"
  many-scores 13 personal-top-three top-of-many 3 assert-cells= ;test

create three-scores 20 , 10 , 30 ,
create three-sorted 30 , 20 , 10 ,
test" Top 3 scores > Personal top highest to lowest"  three-scores 3 personal-top-three three-sorted 3 assert-cells= ;test

create tied-scores 40 , 20 , 40 , 30 ,
create top-tied 40 , 40 , 30 ,
test" Top 3 scores > Personal top when there is a tie"  tied-scores 4 personal-top-three top-tied 3 assert-cells= ;test

create two-scores 30 , 70 ,
create top-two 70 , 30 ,
test" Top 3 scores > Personal top when there are less than 3"  two-scores 2 personal-top-three top-two 2 assert-cells= ;test

create one-score 40 ,
test" Top 3 scores > Personal top when there is only one"  one-score 1 personal-top-three one-score 1 assert-cells= ;test

create latest-after-top 70 , 50 , 20 , 30 ,
test" Top 3 scores > Latest score after personal top scores"
  latest-after-top 4 personal-top-three 2drop  latest-after-top 4 latest-score 30 assert= ;test

create scores-after-top 30 , 50 , 20 , 70 ,
create scores-after-top-expected 30 , 50 , 20 , 70 ,
test" Top 3 scores > Scores after personal top scores"
  scores-after-top 4 personal-top-three 2drop
  scores-after-top 4 scores scores-after-top-expected 4 assert-cells= ;test

create latest-after-best 20 , 70 , 15 , 25 , 30 ,
test" Top 3 scores > Latest score after personal best"
  latest-after-best 5 personal-best drop  latest-after-best 5 latest-score 30 assert= ;test

create scores-after-best 20 , 70 , 15 , 25 , 30 ,
create scores-after-best-expected 20 , 70 , 15 , 25 , 30 ,
test" Top 3 scores > Scores after personal best"
  scores-after-best 5 personal-best drop
  scores-after-best 5 scores scores-after-best-expected 5 assert-cells= ;test

end-tests
