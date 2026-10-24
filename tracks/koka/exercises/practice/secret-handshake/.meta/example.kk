// The actions of the handshake.
pub type action
  Wink
  DoubleBlink
  CloseYourEyes
  Jump

pub fun action/show(a : action) : string
  match a
    Wink -> "Wink"
    DoubleBlink -> "DoubleBlink"
    CloseYourEyes -> "CloseYourEyes"
    Jump -> "Jump"

pub fun action/(==)(a : action, b : action) : bool
  a.show == b.show

val signals = [(1, Wink), (2, DoubleBlink), (4, CloseYourEyes), (8, Jump)]

fun has-bit(n : int, bit : int) : bool
  (n / bit) % 2 == 1

// commands(number) -> the actions encoded in the lowest five bits of `number`: 1 = Wink,
// 2 = DoubleBlink, 4 = CloseYourEyes, 8 = Jump, and 16 reverses their order
pub fun commands(number : int) : list<action>
  val actions = signals.filter(fn((bit, _)) number.has-bit(bit)).map(snd)
  if number.has-bit(16) then actions.reverse else actions
