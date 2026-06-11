# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Project Overview

My Cyberpunk is a personal website that runs entirely inside a **ZX Spectrum emulator** (JSSpeccy) in the browser. The site's content and navigation are written in **Sinclair BASIC**, compiled to a `.tap` tape file, and loaded by the emulator at runtime. The result is an authentic retrocomputing experience rendered in a modern web page.

## Build Commands

```bash
npm start              # Dev server with hot reload (webpack-dev-server)
npm run make-tape      # Compile BASIC sources → src/program.tap
npm run build          # Production webpack build → dist/
npm run docker:build   # Build dist/ then create Docker image (nginx + SSL)
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

### Webpack Build (`webpack.config.js`)

- Babel transpiles JS (excluding `node_modules` and `jsspeccy`)
- CSS modules with `[local]` naming (no hashing)
- Copies `src/program.tap` → `dist/tap/program.tap`
- Copies `src/jsspeccy/*.js` → `dist/`
- Font Awesome and web fonts handled via file-loader

### Virtual Keyboard

`src/index.js` maps on-screen buttons to Spectrum key events using `document.onkeydown`/`onkeyup`. Key bindings are defined in the `keyCodes` object and correspond to `KEY_*` constants in `src/bas/engine/settings.bas`.

### Docker Deployment (`docker/`)

- `Dockerfile` — two-stage: Node.js 14 build environment, then nginx production image
- `prepareweb.sh` — generates self-signed SSL certificates
- `entrypoint.sh` — container entrypoint that starts nginx
- `cyberpunk.yml` — Docker Compose configuration
- Build args: `site_url`, `maintainer_email` (for SSL cert generation)

### Assets

`assets/*.scr` — ZX Spectrum screen dumps (6912 bytes each) used as splash images for articles. Loaded into the TAP file by `jsbin2tap`.

Для просмотра `.scr`-файлов вне эмулятора используется `tools/scr2png.py` — конвертер на Python (Pillow), корректно декодирующий пиксельную адресацию ZX Spectrum (third/row/line/col) и атрибуты цвета (ink/paper на ячейку 8×8).

## Site Content

Персональная страница **Вадима Черенева** (sl@anhot.ru, GitHub: shadowlamer). Весь контент на английском — автор объясняет это отсутствием кириллического ПЗУ у ZX Spectrum. Тон текстов — самоироничный.

### Навигация

Двухуровневое меню. Управление: стрелки вверх/вниз — выбор, Enter — переход, влево — возврат, цифры 1–9 — быстрый выбор, «0» (Stop) — выход в исходный код.

### Экраны

**Заставка (disclaimer)** — показывается первым при загрузке. Текст о том, что страница написана на чистом Sinclair BASIC. Слово "perversions" визуально перечёркнуто через `PLOT`/`DRAW`. Два QR-кода: на репозиторий проекта и на эмулятор JSSpeccy.

**About me** — 3 страницы текста, перед которыми показывается заставка (`photo.scr`):
- `photo.scr` — дизированное портретное фото автора (голова и плечи), стилизованное под монохромную графику ZX Spectrum
- Знакомство: 20+ лет профессионального опыта, 25+ от первого helloworld, больше десятка языков
- Full-stack навыки: от пайки плат и аналоговой техники до web-сервисов, мобильных приложений и SCADA
- Личное: помогает стартапам, не умеет водить машину и включать токарный станок

**Notable projects** — подменю с тремя проектами:

1. **Vending machines** (с 2017, `machine.scr`) — электроника и ПО для вендинговых аппаратов: оплата наличными/безналом, бесконтактные карты, удалённый мониторинг, личный кабинет. Тысячи устройств в сети. Заставка: стилизованная иллюстрация вендингового аппарата — вертикальная конструкция с горизонтальными рядами и текстовым блоком.
2. **LED equipment** (с 2013, `led.scr`) — контроллеры для LED-костюмов и реквизита (пои, сферы) для шоу-бизнеса. Синхронизация с музыкой: от DTMF до MIDI/ArtNet по WiFi. Заставка: сцена LED-перформанса — вертикальные тёмные полосы (исполнители/устройства) с центральной областью свечения.
3. **Web development** (с 2012, `java.scr`) — full-stack по найму. Backend: Java/Spring. Frontend: GWT/Flex/JS/Angular. Storage: JDBC/Hibernate/Mongo/Elasticsearch. Заставка: абстрактная компоновка — кодоподобный текст слева, табличная сетка справа.

**Contact me** — три блока с QR-кодами: email (sl@anhot.ru), GitHub (shadowlamer), LinkedIn (shadowlamer).

### Как работает QR-код в контенте

Макрос `GENQR(url)` (определён в `contact.bas`) вызывает `tools/qrgen.sh` на этапе M4-препроцессинга. Скрипт генерирует QR через `qrencode`, преобразует в массив байтов, который встраивается прямо в BASIC-код. Во время выполнения процедура `@show_qr` пишет эти байты через `POKE` напрямую в видеопамять ZX Spectrum.

### Как добавить новый контент

1. Создать `src/bas/user/articles/<name>.bas` — определить метку `@show_<name>`, данные статьи через `ARTICLE()` и текстовые блоки через `DATA`
2. Добавить `include(user/articles/<name>.bas)` в `src/bas/user/user.bas`
3. Добавить пункт меню в `src/bas/user/menuitems.bas` — `DATA "Название", @show_<name>` (для подменю) или `DATA "Название", @items_<name>` с новым блоком данных
4. При необходимости — положить `.scr`-скриншот в `assets/` и указать его имя в первом `DATA` статьи

## Key Technical Notes

- The BASIC menu system (`src/bas/engine/menu.bas`) uses `DATA`/`READ`/`RESTORE` with pointer arithmetic for hierarchical navigation. Menu items with links `>= @menu_items` are submenus; links below that threshold are subroutine addresses (articles).
- Screen snapshots (.scr files) can be generated with a ZX Spectrum emulator; place them in `assets/`.
