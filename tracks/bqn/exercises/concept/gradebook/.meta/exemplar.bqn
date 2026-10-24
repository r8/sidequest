# Every function takes the marks as a table: a row per student, a column per assignment.

# StudentTotals marks → each student's total mark
StudentTotals ⇐ {+´˘ 𝕩}

# AssignmentTotals marks → the total mark of each assignment
AssignmentTotals ⇐ {+˝ 𝕩}

# TopMarks marks → the highest mark in each assignment
TopMarks ⇐ {⌈˝ 𝕩}

# StudentAverages marks → each student's average mark
StudentAverages ⇐ {{(+´ 𝕩) ÷ ≠𝕩}˘ 𝕩}

# passMark PassCounts marks → how many marks of each student are at least passMark
PassCounts ⇐ {+´˘ 𝕩 ≥ 𝕨}

# marks Curve extra → the marks with each assignment's extra marks added for every student
Curve ⇐ {𝕨 +⎉1 𝕩}
