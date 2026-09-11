# Tetris

A browser-based Tetris game in a single self-contained HTML file. No dependencies, no build step, no install.

## Play

Open `index.html` in any modern browser, or serve the folder:

```sh
python3 -m http.server 8000
# then visit http://localhost:8000
```

## Controls

| Key | Action |
| --- | --- |
| `←` `→` | Move (hold to auto-repeat) |
| `↓` | Soft drop |
| `Space` | Hard drop |
| `↑` / `X` | Rotate clockwise |
| `Z` | Rotate counter-clockwise |
| `A` | Rotate 180° |
| `C` / `Shift` | Hold |
| `P` / `Esc` | Pause |
| `R` | Restart |
| `M` | Mute |

On touch devices, on-screen buttons appear automatically.

## Features

- **SRS rotation with wall kicks** — separate JLSTZ and I kick tables, so pieces tuck into tight spaces correctly
- **7-bag randomizer** — every piece appears once per bag, with a 5-piece preview
- **Hold slot**, ghost piece, and lock delay (500ms, reset on move, capped at 15 resets)
- **T-spin detection** via the 3-corner rule, with mini/full distinction
- **Scoring** — line clears, combos, and back-to-back ×1.5; soft drop 1/cell, hard drop 2/cell
- **Levels** every 10 lines on the standard `(0.8 − 0.007·L)^(L−1)` gravity curve
- Line-clear animation, floating score callouts, WebAudio sound effects
- High score persisted in `localStorage`; auto-pauses when the window loses focus

## Notes

Pieces spawn at the top row of the visible field rather than in a hidden buffer above it. This is a deliberate simplification — it plays normally, but a piece can never partially enter from above the ceiling.
