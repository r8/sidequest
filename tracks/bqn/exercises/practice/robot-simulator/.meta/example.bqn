# A robot is x‿y‿direction, the direction one of "north", "east", "south" or "west".
dirs ← "north"‿"east"‿"south"‿"west"
steps ← ⟨0‿1, 1‿0, 0‿¯1, ¯1‿0⟩

# Create x‿y‿direction → a robot at x‿y facing direction
Create ⇐ {x‿y‿d: x‿y‿d}

# robot Move instructions → the robot after the instructions: "R" turns right, "L" left, "A" advances
Move ⇐ {x‿y‿d 𝕊 cmds:
  turns ← (cmds='R') - cmds='L'
  facing ← 4|(⊑dirs⊐<d) + +`turns
  (x‿y + +´(cmds='A') / facing⊏steps) ∾ <dirs ⊑˜ 4|(⊑dirs⊐<d) + +´turns
}
