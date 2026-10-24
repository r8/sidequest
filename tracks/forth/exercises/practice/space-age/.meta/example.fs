\ Each planet word leaves its orbital period, in Earth years, on the float stack:
\   1000000000 earth age  ( F: -- 31.69… )
: mercury ( F: -- period ) 0.2408467e ;
: venus   ( F: -- period ) 0.61519726e ;
: earth   ( F: -- period ) 1e ;
: mars    ( F: -- period ) 1.8808158e ;
: jupiter ( F: -- period ) 11.862615e ;
: saturn  ( F: -- period ) 29.447498e ;
: uranus  ( F: -- period ) 84.016846e ;
: neptune ( F: -- period ) 164.79132e ;

31557600e fconstant earth-year  \ seconds

: age ( seconds -- ) ( F: period -- years )
  s>f earth-year f/ fswap f/ ;
