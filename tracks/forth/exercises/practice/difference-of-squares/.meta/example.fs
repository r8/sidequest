\ Closed forms: (1 + … + n)² = (n(n+1)/2)², 1² + … + n² = n(n+1)(2n+1)/6.
: square-of-sum ( n -- n' ) dup 1+ * 2/ dup * ;
: sum-of-squares ( n -- n' ) dup 1+ over 2* 1+ * * 6 / ;
: difference-of-squares ( n -- n' ) dup square-of-sum swap sum-of-squares - ;
