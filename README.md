# Tetris

A browser-based Tetris game in a single self-contained HTML file. No dependencies, no build step, no install.

## Play

Open `index.html` in any modern browser, or serve the folder:

```sh
python3 -m http.server 8000
# then visit http://localhost:8000
```

## Run with Docker

The image is built and published to Docker Hub automatically by [`.github/workflows/docker.yml`](.github/workflows/docker.yml) — on every push to `main` (tagged `latest` and `sha-<short>`) and on `v*` release tags (tagged with the version).

```sh
docker run --rm -p 8080:80 <your-dockerhub-username>/tetris
```

Then open <http://localhost:8080>.

nginx serves the file directly, so the image is ~65 MB and starts in about a second. It includes a `HEALTHCHECK`, so `docker ps` reports the container's status.

To build it yourself:

```sh
docker build -t tetris .
docker run --rm -p 8080:80 tetris
```

### Required repository secrets

| Secret | Value |
| --- | --- |
| `DOCKERHUB_USERNAME` | Docker Hub username |
| `DOCKERHUB_TOKEN` | Docker Hub access token with read/write permission |

The pipeline pulls the published image back down and checks that it serves the game, so a green run means a playable image rather than merely a pushed one.

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
