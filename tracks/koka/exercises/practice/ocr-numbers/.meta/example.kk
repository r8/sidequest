// the digits 0 to 9, as the scanner draws them
val font = [" _     _  _     _  _  _  _  _ ",
            "| |  | _| _||_||_ |_   ||_||_|",
            "|_|  ||_  _|  | _||_|  ||_| _|",
            "                              "]

// the `size`-element groups of `xs`, in order
fun groups(xs : list<a>, size : int) : list<list<a>>
  list(0, xs.length / size - 1).map(fn(k) xs.drop(k * size).take(size))

// the 3x4 cells of a 4-row line, left to right, each as its 12 characters
fun cells(rows : list<string>) : list<string>
  val chunked = rows.map(fn(row) row.list.groups(3).map(string))
  val width = chunked.head.default([]).length
  list(0, width - 1).map(fn(k) chunked.map(fn(row) row[k].default("")).join)

val glyphs = zip(cells(font), "0123456789".list)

fun read-line(rows : list<string>) : string
  cells(rows).map(fn(cell) glyphs.lookup(fn(g) g == cell).default('?').string).join

// convert(rows) -> the digits drawn in `rows`, one comma-separated group per 4-row line, '?' for
// unreadable digits; throws "Number of input lines is not a multiple of four" or
// "Number of input columns is not a multiple of three"
pub fun convert(rows : list<string>) : exn string
  if rows.length % 4 != 0 then throw("Number of input lines is not a multiple of four")
  if rows.any(fn(row) row.count % 3 != 0) then throw("Number of input columns is not a multiple of three")
  rows.groups(4).map(read-line).join(",")
