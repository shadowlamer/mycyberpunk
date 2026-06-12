# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Project Overview

My Cyberpunk is a personal website that runs entirely inside a **ZX Spectrum emulator** (JSSpeccy) in the browser. The site's content and navigation are written in **Sinclair BASIC**, compiled to a `.tap` tape file, and loaded by the emulator at runtime. The result is an authentic retrocomputing experience rendered in a modern web page.

## Build Commands

```bash
npm start              # Dev server with hot reload (webpack-dev-server)
npm run make-tape      # Compile BASIC sources → src/program.tap
npm run build          # Production webpack build → dist/
npm run docker:build   # make-tape + build + Docker image (nginx + SSL)
```

**Tape compilation prerequisites** (needed for `npm run make-tape`):
```bash
sudo apt install zmakebas m4
```
Also requires `jsbin2tap` (installed via npm devDependencies).

## Architecture

### Two-Layer System

1. **BASIC Layer** (`src/bas/`) — all site content and navigation logic in Sinclair BASIC, preprocessed by M4 and compiled by zmakebas into a TAP file. This is the "application" that runs inside the emulator.

2. **Web Layer** (`src/index.js`, `src/index.html`, `src/index.css`) — a thin JavaScript shell that initializes the JSSpeccy emulator, provides a virtual on-screen keyboard (simple-keyboard), and handles responsive scaling. It does not implement site logic — that lives entirely in BASIC.

### BASIC Code Organization

- `src/bas/engine/` — reusable engine modules: initialization, menu system, article display, contact screen, UDG graphics, and settings/constants. Engine code uses M4 `define()` macros for constants and `@label` syntax for line labels.
- `src/bas/user/` — site-specific content: menu structure definition (`menuitems.bas`), individual articles (`articles/`), and disclaimer text.
- `src/bas/engine/main.bas` — entry point; sets version and `include`s all modules in order.

**Important**: Line number increment in zmakebas is set to 1 (`-i 1`). Data pointer manipulations in BASIC depend on this (see comment in `main.bas`).

### Tape Build Pipeline (`tools/maketape.sh`)

1. M4 preprocesses `main.bas` with `-I src/bas`, resolving all `include` directives → flat `program.bas`
2. `zmakebas` compiles `program.bas` → `src/program.tap`
3. `jsbin2tap` appends screen snapshots from `assets/*.scr` into the TAP
4. Game TAP files from `assets/*.tap` are appended after the main program

The final TAP structure: screen snapshots → main BASIC program → game TAPs.

### Webpack Build (`webpack.config.js`)

- Babel transpiles JS (excluding `node_modules` and `jsspeccy`)
- CSS modules with `[local]` naming (no hashing)
- Copies `src/program.tap` → `dist/tap/program.tap`
- Copies `src/jsspeccy/*.js` → `dist/`
- Font Awesome 6 and web fonts handled via file-loader

### Docker Deployment (`docker/`)

- `Dockerfile` — two-stage: Node.js build environment, then nginx production image
- `prepareweb.sh` — generates self-signed SSL certificates
- `entrypoint.sh` — container entrypoint that starts nginx
- Build args: `site_url`, `maintainer_email` (for SSL cert generation)

### Assets

- `assets/*.scr` — ZX Spectrum screen dumps (6912 bytes each) used as splash images for articles. Use `tools/scr2png.py` to convert to PNG (correctly decodes ZX Spectrum pixel addressing and color attributes).
- `assets/*.tap` — game TAP files that are appended to the main tape and can be loaded from BASIC articles via `load "game_name"`.

## Site Content

Personal website of **Vadim Cherenev** (sl@anhot.ru, GitHub: shadowlamer). All content is in English — the author explains this by the lack of a Cyrillic character generator on the ZX Spectrum. The tone is self-ironic.

### Navigation

Two-level menu with descriptions. Controls: up/down arrows — select, Enter — choose, Left — go back, 1–9 — quick select, "0" (Stop) — exit to source code. The menu engine (`menu.bas`) uses partial redraw on cursor change for responsive navigation.

### Screens

**Disclaimer** — shown first on load. Text about the page being written in pure Sinclair BASIC. The word "perversions" is visually struck through via `PLOT`/`DRAW`. Two QR codes: one for the project repository, one for the JSSpeccy emulator.

**About me** — 3 pages of text, preceded by a splash screen (`photo.scr`):
- Introduction: 25+ years of professional experience, 30+ from first helloworld, over a dozen languages
- Full-stack skills: from soldering boards and analog electronics to web services, mobile apps, and SCADA
- Personal: helps startups, can't drive a car or operate a lathe

**Notable projects** — submenu with descriptions, 6 items:

1. **Vending machines** (since 2017, `machine.scr`) — electronics and software for vending machines
2. **LED equipment** (since 2013, `led.scr`) — controllers for LED costumes and props for show business
3. **Web development** (since 2012, `java.scr`) — full-stack hired work
4. **Robot Battle 2025** (`nut.scr`) — combat robot built from a Bigo constructor in 2 weeks for an international championship in Perm
5. **ZX Spectrum games** — submenu with 2 games that can be launched directly from the article:
   - **6.6.6.6** — tech support RPG written in C (SDCC). Article ends with a game menu: Enter to play, Left to return.
   - **7.7.7.7** — dungeon crawler built on 8bitworkshop + Tiled + Furnace
6. **AI experiments** — article about neural networks (DDPM and Stable Diffusion) trained on ZX Spectrum art from zxart.ee, with a link to huggingface.co/shadowlamer

**Contact me** — two blocks with QR codes: email (sl@anhot.ru) and GitHub (shadowlamer).

### How QR Codes Work in Content

The `GENQR(url)` macro (defined in `contact.bas`) calls `tools/qrgen.sh` during M4 preprocessing. The script generates a QR code via `qrencode`, converts it to a byte array that is embedded directly into BASIC code. At runtime, the `@show_qr` procedure writes these bytes via `POKE` directly into the ZX Spectrum video memory.

### How to Add New Content

1. Create `src/bas/user/articles/<name>.bas` — define `@show_<name>` label, article data via `ARTICLE()`, and text blocks via `DATA`
2. Add `include(user/articles/<name>.bas)` in `src/bas/user/articles/projects.bas`
3. Add menu item in `src/bas/user/menuitems.bas` — `DATA "Title", @show_<name>` for an article or `DATA "Title", @items_<name>` for a submenu
4. Optionally place a `.scr` screenshot in `assets/` and reference its name (without extension) in the article's first `DATA` field
5. For playable games: place the game `.tap` in `assets/`, set the article's third `DATA` field to the game name

## Key Technical Notes

- The BASIC menu system uses `DATA`/`READ`/`RESTORE` with pointer arithmetic for hierarchical navigation. Menu items with links `>= @menu_items` are submenus; links below that threshold are subroutine addresses (articles).
- All `@show_*` labels must be included **before** `menuitems.bas` in the build order so their addresses fall below `@menu_items`.
- Sinclair BASIC string variables are limited to a single character + `$` (e.g. `g$`, not `game$`).
- Label names must not contain Sinclair BASIC keywords (e.g. avoid `draw`, `print` in label names).
- Each text page is exactly 20 lines, each line max 32 characters.
- The article engine supports a third `DATA` field for game filenames. If non-empty, a "Play / Back" menu is shown after the last page instead of "Press any key".
- Screen snapshots (.scr files) can be generated with a ZX Spectrum emulator; place them in `assets/`.
