// evaluate(instructions) -> the stack, bottom first, after running each line of Forth in turn;
// throws "empty stack", "only one value on the stack", "divide by zero", "illegal operation"
// or "undefined operation" when a line can't run
pub fun evaluate(instructions : list<string>) : exn list<int>
  throw("implement me", ExnTodo)
