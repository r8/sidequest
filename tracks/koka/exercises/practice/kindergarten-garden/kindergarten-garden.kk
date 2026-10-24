// A plant in the kindergarten's garden.
pub type plant
  Grass
  Clover
  Radishes
  Violets

pub fun (==)(a : plant, b : plant) : bool
  match (a, b)
    (Grass, Grass) -> True
    (Clover, Clover) -> True
    (Radishes, Radishes) -> True
    (Violets, Violets) -> True
    _ -> False

pub fun show(p : plant) : string
  match p
    Grass -> "Grass"
    Clover -> "Clover"
    Radishes -> "Radishes"
    Violets -> "Violets"

// plants(diagram, student) -> the four plants of `student` in `diagram` (two rows of 'G', 'C',
// 'R' and 'V' separated by a newline): the two cups of their first row, then the two of their
// second row. The students, in alphabetical order, are Alice, Bob, Charlie, David, Eve, Fred,
// Ginny, Harriet, Ileana, Joseph, Kincaid and Larry.
pub fun plants(diagram : string, student : string) : exn list<plant>
  throw("implement me", ExnTodo)
