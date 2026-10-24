// A small test harness for the Koka track. It needs nothing beyond the koka compiler.
//
//   import test
//   import two-fer
//
//   pub fun main()
//     run([
//       test("no name given") { assert-equal("One for you, one for me.", two-fer()) },
//     ])
//
// `run` executes the tests in order and prints one machine-readable line per test, then a summary
// line, and exits 1 if anything failed or errored:
//
//   PASS<TAB><name><TAB><TAB>
//   FAIL<TAB><name><TAB><expected/got message><TAB>
//   ERROR<TAB><name><TAB><exception message><TAB>
//   SUMMARY<TAB><passed><TAB><failed><TAB><errored>
//
// Backslash, tab, newline and carriage return inside a field are escaped as \\ \t \n \r. Whatever a
// test prints appears on the lines before its record. Every record and the summary start on a fresh
// line, so output printed without a trailing newline cannot swallow one (blank lines in between mean
// nothing). Koka exits 0 on an uncaught exception, so the exit code is set explicitly.
module test

import std/num/int32

pub struct test-case
  name : string
  body : () -> io ()

// A test named `name` whose body is `body`.
pub fun test(name : string, body : () -> io ()) : test-case
  Test-case(name, body)

// Passes when `actual == expected`.
pub fun assert-equal(expected : a, actual : a, ?(==) : (a, a) -> bool, ?show : (a) -> string) : exn ()
  if !(expected == actual) then
    throw("expected " ++ expected.show ++ ", got " ++ actual.show, ExnAssert)

// Passes when `x` is True.
pub fun assert-true(x : bool) : exn ()
  if !x then throw("expected True, got False", ExnAssert)

// Passes when `x` is False.
pub fun assert-false(x : bool) : exn ()
  if x then throw("expected False, got True", ExnAssert)

// Passes when `action` throws an exception whose message is `expected`.
pub fun assert-throws(expected : string, action : () -> io a) : io ()
  match try(action)
    Ok(_) -> throw("expected the exception " ++ expected.show ++ ", but nothing was thrown", ExnAssert)
    Error(err) ->
      if err.message != expected then
        throw("expected the exception " ++ expected.show ++ ", got " ++ err.message.show, ExnAssert)

extern exit-with(code : int32) : io ()
  c inline "(exit(#1), kk_Unit)"

fun escape(s : string) : string
  s.replace-all("\\", "\\\\").replace-all("\t", "\\t").replace-all("\n", "\\n").replace-all("\r", "\\r")

fun record(status : string, name : string, message : string) : console ()
  println("\n" ++ status ++ "\t" ++ escape(name) ++ "\t" ++ escape(message) ++ "\t")

fun go(tests : list<test-case>, passed : int, failed : int, errored : int) : io (int, int, int)
  match tests
    Nil -> (passed, failed, errored)
    Cons(t, rest) ->
      match try({ (t.body)() })
        Ok(_) ->
          record("PASS", t.name, "")
          go(rest, passed + 1, failed, errored)
        Error(err) ->
          match err.info
            ExnAssert ->
              record("FAIL", t.name, err.message)
              go(rest, passed, failed + 1, errored)
            _ ->
              record("ERROR", t.name, err.message)
              go(rest, passed, failed, errored + 1)

// Runs every test in order, reports, and exits 1 if anything failed or errored.
pub fun run(tests : list<test-case>) : io ()
  val (passed, failed, errored) = go(tests, 0, 0, 0)
  println("\nSUMMARY\t" ++ passed.show ++ "\t" ++ failed.show ++ "\t" ++ errored.show)
  if failed + errored > 0 then exit-with(1.int32)
