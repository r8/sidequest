t ← •Import "../lib/test.bqn"
g ← •Import "../gradebook.bqn"

two ← > ⟨80‿65‿90, 70‿75‿60⟩
four ← > ⟨80‿65‿90, 70‿75‿60, 95‿85‿100, 50‿40‿70⟩
one ← > ⟨⟨100, 50, 75, 25⟩⟩

t.Run ⟨
  "1. two students"‿{𝕊: 235‿205 t.Expect g.StudentTotals two}
  "1. four students"‿{𝕊: 235‿205‿280‿160 t.Expect g.StudentTotals four}
  "1. one student"‿{𝕊: ⟨250⟩ t.Expect g.StudentTotals one}
  "2. two students"‿{𝕊: 150‿140‿150 t.Expect g.AssignmentTotals two}
  "2. four students"‿{𝕊: 295‿265‿320 t.Expect g.AssignmentTotals four}
  "2. one student"‿{𝕊: 100‿50‿75‿25 t.Expect g.AssignmentTotals one}
  "2. no students yet"‿{𝕊: 0‿0‿0 t.Expect g.AssignmentTotals 0‿3 ⥊ 0}
  "3. two students"‿{𝕊: 80‿75‿90 t.Expect g.TopMarks two}
  "3. four students"‿{𝕊: 95‿85‿100 t.Expect g.TopMarks four}
  "3. one student"‿{𝕊: 100‿50‿75‿25 t.Expect g.TopMarks one}
  "4. three students"‿{𝕊: 70‿91‿20 t.Expect g.StudentAverages > ⟨60‿70‿80, 90‿90‿93, 0‿0‿60⟩}
  "4. one student"‿{𝕊: ⟨62.5⟩ t.Expect g.StudentAverages one}
  "4. whole-number averages"‿{𝕊: 60‿90 t.Expect g.StudentAverages > ⟨50‿70, 85‿95⟩}
  "5. pass mark 70"‿{𝕊: 2‿2 t.Expect 70 g.PassCounts two}
  "5. pass mark 70, four students"‿{𝕊: 2‿2‿3‿1 t.Expect 70 g.PassCounts four}
  "5. everyone passes everything"‿{𝕊: 3‿3 t.Expect 0 g.PassCounts two}
  "5. nobody passes"‿{𝕊: 0‿0 t.Expect 95 g.PassCounts two}
  "6. two assignments curved"‿{𝕊: (> ⟨80‿75‿95, 70‿85‿65⟩) t.Expect two g.Curve 0‿10‿5}
  "6. nothing curved"‿{𝕊: four t.Expect four g.Curve 0‿0‿0}
  "6. four students, every assignment curved"‿{𝕊: (> ⟨81‿67‿93, 71‿77‿63, 96‿87‿103, 51‿42‿73⟩) t.Expect four g.Curve 1‿2‿3}
  "6. one student, four assignments"‿{𝕊: (> ⟨⟨100, 60, 75, 45⟩⟩) t.Expect one g.Curve 0‿10‿0‿20}
⟩
