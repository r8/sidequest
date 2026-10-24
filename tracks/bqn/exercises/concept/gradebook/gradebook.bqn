# Every function takes the marks as a table: a row per student, a column per assignment.

# StudentTotals marks → each student's total mark
StudentTotals ⇐ {𝕊 𝕩: "implement me" ! 0}

# AssignmentTotals marks → the total mark of each assignment
AssignmentTotals ⇐ {𝕊 𝕩: "implement me" ! 0}

# TopMarks marks → the highest mark in each assignment
TopMarks ⇐ {𝕊 𝕩: "implement me" ! 0}

# StudentAverages marks → each student's average mark
StudentAverages ⇐ {𝕊 𝕩: "implement me" ! 0}

# passMark PassCounts marks → how many marks of each student are at least passMark
PassCounts ⇐ {𝕨 𝕊 𝕩: "implement me" ! 0}

# marks Curve extra → the marks with each assignment's extra marks added for every student
Curve ⇐ {𝕨 𝕊 𝕩: "implement me" ! 0}
