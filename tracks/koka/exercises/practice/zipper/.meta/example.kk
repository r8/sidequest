// A binary tree node: a value and an optional left and right subtree.
pub struct tree<a>(value : a, left : maybe<tree<a>>, right : maybe<tree<a>>)

pub fun tree/(==)(t1 : tree<a>, t2 : tree<a>, ?(==) : (a, a) -> bool) : bool
  match t1
    Tree(v1, l1, r1) -> match t2
      Tree(v2, l2, r2) ->
        val left-equal = match l1
          Nothing -> l2.is-nothing
          Just(a) -> match l2
            Just(b) -> a == b
            Nothing -> False
        val right-equal = match r1
          Nothing -> r2.is-nothing
          Just(a) -> match r2
            Just(b) -> a == b
            Nothing -> False
        v1 == v2 && left-equal && right-equal

pub fun tree/show(t : tree<a>, ?show : (a) -> string) : string
  match t
    Tree(v, l, r) ->
      val left-shown = match l
        Nothing -> "Nothing"
        Just(sub) -> "Just(" ++ sub.show ++ ")"
      val right-shown = match r
        Nothing -> "Nothing"
        Just(sub) -> "Just(" ++ sub.show ++ ")"
      "Tree(" ++ v.show ++ ", " ++ left-shown ++ ", " ++ right-shown ++ ")"

// One step down from a parent node, remembered so the zipper can go back up: WentLeft means the
// focus is the parent's left child, and `sibling` is the parent's right subtree; WentRight the reverse.
pub type crumb<a>
  WentLeft(parent : a, sibling : maybe<tree<a>>)
  WentRight(parent : a, sibling : maybe<tree<a>>)

pub fun crumb/(==)(c1 : crumb<a>, c2 : crumb<a>, ?(==) : (a, a) -> bool) : bool
  match c1
    WentLeft(p1, s1) -> match c2
      WentLeft(p2, s2) -> p1 == p2 && s1 == s2
      _ -> False
    WentRight(p1, s1) -> match c2
      WentRight(p2, s2) -> p1 == p2 && s1 == s2
      _ -> False

pub fun crumb/show(c : crumb<a>, ?show : (a) -> string) : string
  match c
    WentLeft(p, s) -> "WentLeft(" ++ p.show ++ ", " ++ s.show ++ ")"
    WentRight(p, s) -> "WentRight(" ++ p.show ++ ", " ++ s.show ++ ")"

// A tree with a focus: the subtree in focus, and the steps that led to it, the most recent first.
pub struct zipper<a>(focus : tree<a>, path : list<crumb<a>>)

pub fun zipper/(==)(z1 : zipper<a>, z2 : zipper<a>, ?(==) : (a, a) -> bool) : bool
  z1.focus == z2.focus && z1.path == z2.path

pub fun zipper/show(z : zipper<a>, ?show : (a) -> string) : string
  "Zipper(" ++ z.focus.show ++ ", " ++ z.path.show ++ ")"

// from-tree(t) -> a zipper focused on the root of `t`
pub fun from-tree(t : tree<a>) : zipper<a>
  Zipper(t, [])

// Puts `child` back into the parent node that `step` remembers.
fun rebuild(child : tree<a>, step : crumb<a>) : tree<a>
  match step
    WentLeft(v, r) -> Tree(v, Just(child), r)
    WentRight(v, l) -> Tree(v, l, Just(child))

// to-tree(z) -> the whole tree, with any changes made through the zipper
pub fun to-tree(z : zipper<a>) : tree<a>
  z.path.foldl(z.focus, rebuild)

// value(z) -> the value of the node in focus
pub fun zipper/value(z : zipper<a>) : a
  z.focus.value

// left(z) -> the zipper focused on the left child of the focus, or Nothing if there is none
pub fun zipper/left(z : zipper<a>) : maybe<zipper<a>>
  match z.focus
    Tree(v, l, r) -> l.map(fn(child) Zipper(child, Cons(WentLeft(v, r), z.path)))

// right(z) -> the zipper focused on the right child of the focus, or Nothing if there is none
pub fun zipper/right(z : zipper<a>) : maybe<zipper<a>>
  match z.focus
    Tree(v, l, r) -> r.map(fn(child) Zipper(child, Cons(WentRight(v, l), z.path)))

// up(z) -> the zipper focused on the parent of the focus, or Nothing at the root
pub fun up(z : zipper<a>) : maybe<zipper<a>>
  match z.path
    Nil -> Nothing
    Cons(step, rest) -> Just(Zipper(z.focus.rebuild(step), rest))

// set-value(z, v) -> `z` with the value of the focus replaced by `v`
pub fun set-value(z : zipper<a>, v : a) : zipper<a>
  val node = z.focus
  z(focus = node(value = v))

// set-left(z, t) -> `z` with the left subtree of the focus replaced by `t`
pub fun set-left(z : zipper<a>, t : maybe<tree<a>>) : zipper<a>
  val node = z.focus
  z(focus = node(left = t))

// set-right(z, t) -> `z` with the right subtree of the focus replaced by `t`
pub fun set-right(z : zipper<a>, t : maybe<tree<a>>) : zipper<a>
  val node = z.focus
  z(focus = node(right = t))
