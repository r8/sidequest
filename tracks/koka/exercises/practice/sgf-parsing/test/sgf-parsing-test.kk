import test
import sgf-parsing

pub fun main()
  run([
    test("empty input") { assert-throws("tree missing") { parse("") } },
    test("tree with no nodes") { assert-throws("tree with no nodes") { parse("()") } },
    test("node without tree") { assert-throws("tree missing") { parse(";") } },
    test("node without properties") { assert-equal(Tree([], []), parse("(;)")) },
    test("single node tree") { assert-equal(Tree([("A", ["B"])], []), parse("(;A[B])")) },
    test("multiple properties") { assert-equal(Tree([("A", ["b"]), ("C", ["d"])], []), parse("(;A[b]C[d])")) },
    test("properties without delimiter") { assert-throws("properties without delimiter") { parse("(;A)") } },
    test("all lowercase property") { assert-throws("property must be in uppercase") { parse("(;a[b])") } },
    test("upper and lowercase property") { assert-throws("property must be in uppercase") { parse("(;Aa[b])") } },
    test("two nodes") { assert-equal(Tree([("A", ["B"])], [Tree([("B", ["C"])], [])]), parse("(;A[B];B[C])")) },
    test("two child trees") { assert-equal(Tree([("A", ["B"])], [Tree([("B", ["C"])], []), Tree([("C", ["D"])], [])]), parse("(;A[B](;B[C])(;C[D]))")) },
    test("multiple property values") { assert-equal(Tree([("A", ["b", "c", "d"])], []), parse("(;A[b][c][d])")) },
    test("within property values, whitespace characters such as tab are converted to spaces") { assert-equal(Tree([("A", ["hello  world"])], []), parse("(;A[hello\t\tworld])")) },
    test("within property values, newlines remain as newlines") { assert-equal(Tree([("A", ["hello\n\nworld"])], []), parse("(;A[hello\n\nworld])")) },
    test("escaped closing bracket within property value becomes just a closing bracket") { assert-equal(Tree([("A", ["]"])], []), parse("(;A[\\]])")) },
    test("escaped backslash in property value becomes just a backslash") { assert-equal(Tree([("A", ["\\"])], []), parse("(;A[\\\\])")) },
    test("opening bracket within property value doesn't need to be escaped") { assert-equal(Tree([("A", ["x[y]z", "foo"]), ("B", ["bar"])], [Tree([("C", ["baz"])], [])]), parse("(;A[x[y\\]z][foo]B[bar];C[baz])")) },
    test("semicolon in property value doesn't need to be escaped") { assert-equal(Tree([("A", ["a;b", "foo"]), ("B", ["bar"])], [Tree([("C", ["baz"])], [])]), parse("(;A[a;b][foo]B[bar];C[baz])")) },
    test("parentheses in property value don't need to be escaped") { assert-equal(Tree([("A", ["x(y)z", "foo"]), ("B", ["bar"])], [Tree([("C", ["baz"])], [])]), parse("(;A[x(y)z][foo]B[bar];C[baz])")) },
    test("escaped tab in property value is converted to space") { assert-equal(Tree([("A", ["hello world"])], []), parse("(;A[hello\\\tworld])")) },
    test("escaped newline in property value is converted to nothing at all") { assert-equal(Tree([("A", ["helloworld"])], []), parse("(;A[hello\\\nworld])")) },
    test("escaped t and n in property value are just letters, not whitespace") { assert-equal(Tree([("A", ["t = t and n = n"])], []), parse("(;A[\\t = t and \\n = n])")) },
    test("mixing various kinds of whitespace and escaped characters in property value") { assert-equal(Tree([("A", ["]b\ncd  e\\ ]"])], []), parse("(;A[\\]b\nc\\\nd\t\te\\\\ \\\n\\]])")) },
  ])
