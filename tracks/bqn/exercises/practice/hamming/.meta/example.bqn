# strand1 Distance strand2 → the number of positions where they differ;
# errors with "strands must be of equal length" otherwise
Distance ⇐ {
  𝕨 ≠○≠ 𝕩 ? "strands must be of equal length" ! 0 ;
  +´𝕨≠𝕩
}
