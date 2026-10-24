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

// commands(number) -> the actions encoded in the lowest five bits of `number`: 1 = Wink,
// 2 = DoubleBlink, 4 = CloseYourEyes, 8 = Jump, and 16 reverses their order
pub fun commands(number : int) : exn list<action>
  throw("implement me", ExnTodo)
