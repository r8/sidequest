// transpose(lines) -> the columns of `lines` as rows; a short line is padded with spaces on the
// right only where a later line is longer
pub fun transpose(lines : list<string>) : list<string>
  // each line's width once padded: the longest of it and every line after it
  val widths = lines.foldr([]) fn(line, acc) Cons(max(line.count, acc.head.default(0)), acc)
  val padded = zipwith(lines, widths, fn(line, width) line.pad-right(width).list)
  list(0, widths.head.default(0) - 1).map fn(i)
    padded.filter-map(fn(chars) chars[i]).string
