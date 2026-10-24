# Instructions

The neighbours on Elm Street share a tool shed. Mrs. Kowalczyk keeps the key, and she'd like a program that knows
which tools are in the shed, which are blunt, and who has borrowed what. The stub defines the `Tool` type; add the
fields of `Shed` and write its methods.

A tool goes blunt after three jobs, and sharpening it resets its count:

```inko
let saw = Tool.new('saw')

saw.work
saw.jobs
# => 1
```

## 1. Stock the shed

Define the static `new` method, which returns an empty shed, the `store` method, which puts a tool in the shed (the
shed then owns it), and the `size` method:

```inko
let shed = Shed.new

shed.store(Tool.new('saw'))
shed.size
# => 1
```

## 2. Find a tool

Define the `find` method, which returns a borrow of the tool with a given name, if it's in the shed. The tool stays
in the shed:

```inko
shed.find('saw').map(fn (tool) { tool.jobs })
# => Option.Some(0)
```

## 3. Use a tool in the shed

Define the `work_with` method, which uses the tool with a given name for a job (calling its `work` method) and
returns `true`, or returns `false` when the shed doesn't have the tool:

```inko
shed.work_with('saw')
# => true
```

## 4. Sharpen everything

On Sunday mornings, Mrs. Kowalczyk sharpens every blunt tool in the shed. Define the `sharpen_all` method, which
calls `sharpen` on every tool that is `blunt?`, and leaves the others alone.

## 5. Lend a tool

Define the `lend` method, which takes the tool with a given name out of the shed and returns it, or returns `None`
when the shed doesn't have it. A lent tool can be stored again when it comes back:

```inko
shed.lend('saw').map(fn (tool) { tool.name })
# => Option.Some('saw')
shed.size
# => 0
```
