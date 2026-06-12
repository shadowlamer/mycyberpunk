# My Cyberpunk

Personal website written in Sinclair BASIC that runs inside a ZX Spectrum
emulator (JSSpeccy) in the browser.

### Build & Run

```bash
npm start              # Dev server with hot reload
npm run make-tape      # Compile BASIC sources → src/program.tap
npm run build          # Production webpack build → dist/
npm run docker:build   # Full build + Docker image (nginx + SSL)
```

**Tape compilation prerequisites:**
```bash
sudo apt install zmakebas m4
```

### Docker parameters

| Parameter              | Description                |
| ---------------------- |:---------------------------|
| site_url               | Deploying URL              |
| maintainer_email       | Email to generate SSL key  |

Self-signed certificate for nginx is generated during build. Key generation
requires entropy — install `haveged` to speed up the build:
```bash
sudo apt-get install haveged
sudo service haveged start
```

### Project Structure

```
src/bas/engine/    — Reusable engine: menu, articles, contacts, UDG
src/bas/user/      — Site content: articles, menus, disclaimer
assets/            — ZX Spectrum screen dumps (.scr) and game tapes (.tap)
tools/             — Build scripts (maketape.sh, qrgen.sh, scr2png.py)
```

### BASIC Programming Guide

The BASIC sources are preprocessed by M4 (`include`, `define` macros) and then
compiled by `zmakebas` into a TAP file. Line increment is 1 (`-i 1`), which
data pointer arithmetic depends on.

#### How to Add a New Article

1. Create `src/bas/user/articles/<name>.bas`:

```basic
@show_myarticle:
    ARTICLE(@article_myarticle)
return

@article_myarticle:
data "myscreen", 1, ""
data @text_myarticle_1

@text_myarticle_1:
data 20
data "Line of text (max 32 chars)"
data "Another line"
...
```

Article data fields: `<screen.scr name>, <pages>, <game name>`. Empty strings
mean no splash screen or no game. Each text page is exactly 20 lines, each
line up to 32 characters.

2. Add include in `src/bas/user/articles/projects.bas`:

```basic
include(user/articles/myarticle.bas)
```

3. Add menu item in `src/bas/user/menuitems.bas`:

```basic
data "My Article", @show_myarticle
```

For a submenu, point to a data block instead:
```basic
data "My Section", @items_mysection
```

#### Menu Data Format

```basic
@items_<name>:
data "Menu Title", <item_count>, <desc_line_count>
data "Description line 1"
data "Description line 2"
data "Item 1 name", @show_article1
data "Item 2 name", @items_submenu
```

Links `>= @menu_items` are submenus. Links below are article subroutines.
All `@show_*` labels must be included before `menuitems.bas` in the build order.

#### Special Text Markers

Inside text blocks, these markers trigger special behavior:

- `"\*"` — insert contact block (next data: position, contact pointer)
- `"sub"` — call subroutine (next data: subroutine pointer)

#### Key Constants

| Constant              | Value | Meaning                    |
| --------------------- |:-----:|:---------------------------|
| KEY_UP                |  11   | Up arrow                  |
| KEY_DOWN              |  10   | Down arrow                |
| KEY_FORWARD           |  13   | Enter / Right arrow       |
| KEY_BACKWARD          |   8   | Left arrow                |
| KEY_STOP              |  48   | Stop / 0 key              |
| MENU_SELECTED_INK     |   4   | Highlighted item color    |
| DEFAULT_INK           |   7   | Default text color (white)|

#### M4 Macros

| Macro                  | Description                                |
| ---------------------- |:-------------------------------------------|
| `ARTICLE(ptr)`         | Display article with splash/game support   |
| `TEXT(ptr)`            | Display text block                         |
| `GENQR(url)`           | Generate QR code at compile time           |
| `PREVENT_SCROLL`       | Disable automatic screen scrolling         |

#### Naming Conventions

| Pattern              | Purpose                          |
| -------------------- |:---------------------------------|
| `@show_<name>`       | Article entry point (gosub)      |
| `@article_<name>`    | Article data definition          |
| `@text_<name>`       | Text block data definition       |
| `@items_<name>`      | Menu data definition             |
| `@contact_<name>`    | Contact block data definition    |

#### Restrictions

- Sinclair BASIC string variables: single character + `$` (e.g. `g$`, not `game$`)
- Label names must not contain Sinclair BASIC keywords (e.g. avoid `draw`, `print`)
- Each text line: max 32 characters
- Each text page: exactly 20 lines

### Acknowledgments

This project was edited with the assistance of an AI agent.
