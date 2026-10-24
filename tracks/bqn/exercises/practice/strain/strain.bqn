# Keep and discard are 1-modifiers: their operand is the predicate, called on each element of the
# list and returning 1 or 0. In the spirit of the exercise, don't reach for replicate (/).
# Predicate _keep list → the elements for which Predicate returns 1, in order: (2⊸|) _keep 1‿2‿3 → 1‿3
_keep ⇐ {𝔽 _𝕣 𝕩: "implement me" ! 0}
# Predicate _discard list → the elements for which Predicate returns 0, in order
_discard ⇐ {𝔽 _𝕣 𝕩: "implement me" ! 0}
