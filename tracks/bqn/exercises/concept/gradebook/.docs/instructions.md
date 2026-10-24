# Instructions

Ms Okafor keeps her class's marks in a spreadsheet: one row per student, one column per assignment, every mark
out of 100. The school's software can only export the table, and she has to send totals and averages to the
office by Friday. You offer to help.

Every function takes the marks as a table with a row per student and a column per assignment.

## 1. Total each student's marks

Write the function `StudentTotals`. It takes the table and returns each student's total, in row order.

```bqn
StudentTotals > ⟨80‿65‿90, 70‿75‿60⟩
# ⇒ ⟨ 235 205 ⟩
```

## 2. Total each assignment

Write the function `AssignmentTotals`. It takes the table and returns the total of each assignment, in column
order.

```bqn
AssignmentTotals > ⟨80‿65‿90, 70‿75‿60⟩
# ⇒ ⟨ 150 140 150 ⟩
```

## 3. Find the top mark of each assignment

Write the function `TopMarks`. It takes the table and returns the highest mark in each assignment.

```bqn
TopMarks > ⟨80‿65‿90, 70‿75‿60⟩
# ⇒ ⟨ 80 75 90 ⟩
```

## 4. Average each student

Write the function `StudentAverages`. It takes the table and returns each student's average mark.

```bqn
StudentAverages > ⟨80‿65‿90, 70‿75‿60⟩
# ⇒ ⟨ 78.33333333333333 68.33333333333333 ⟩
```

## 5. Count the passes

Write the function `PassCounts`. Its left argument is the pass mark and its right argument the table; it returns
how many assignments each student passed, a pass being a mark at least as high as the pass mark.

```bqn
70 PassCounts > ⟨80‿65‿90, 70‿75‿60⟩
# ⇒ ⟨ 2 2 ⟩
```

## 6. Curve the hard assignments

Some assignments were harder than expected. Write the function `Curve`. Its left argument is the table and its
right argument the list of extra marks for each assignment; it returns the table with every student's mark in
each assignment raised by that assignment's extra marks.

```bqn
(> ⟨80‿65‿90, 70‿75‿60⟩) Curve 0‿10‿5
# ⇒ a 2×3 table: 80 75 95 / 70 85 65
```
