define(MENU_HELP_POSITION, 16)

rem ******** Menu *********
@main_menu:
    let pLink = 0
    let pBkLink = 0
    let cursor = 1
    let pItem = @items_main
    let r = 1
    @menu_loop:
        if r = 1 then \
            cls :\
            go sub @m_full :\
            let r = 0
        pause 0
        let key = code inkey$
        let prev = cursor
        if inkey$ >= "1" and inkey$ <= "9" then \
           let cursor = key - code "0"
        if key = KEY_DOWN then \
            let cursor = cursor + 1
        if key = KEY_UP then \
            let cursor = cursor - 1
        if cursor > nItems then \
            let cursor = nItems
        if cursor < 1 then \
            let cursor = 1
        if cursor <> prev then \
            go sub @m_sel
        if key = KEY_FORWARD and pLink >= @menu_items then \
            let pBkLink = pItem :\
            let pItem = pLink :\
            let cursor = 1 :\
            let r = 1
        if key = KEY_FORWARD and pLink < @menu_items then \
            go sub pLink :\
            let r = 1
        if key = KEY_BACKWARD and pBkLink >= @menu_items then \
            let pItem = pBkLink :\
            let pBkLink = 0 :\
            let cursor = 1 :\
            let r = 1
        if key = KEY_STOP then \
            return
    go to @menu_loop
return

@m_full:
    restore pItem
    read t$, nItems
    print at 0, 0; ink MENU_SELECTED_INK; t$
    read dL
    print
    for d = 1 to dL
        read d$
        print d$
    next d
    print
    for i = 1 to nItems
        read m$, sublink
        if i = cursor then \
            let pLink = sublink :\
            print ink MENU_SELECTED_INK; i; ".>"; m$
        if i <> cursor then \
            print i; ". "; m$
    next i
    print at MENU_HELP_POSITION, 0
    TEXT(@text_help)
return

@m_sel:
    restore pItem
    read t$, nItems
    read dL
    for d = 1 to dL
        read d$
    next d
    for i = 1 to nItems
        read m$, sublink
        if i = prev then \
            print at dL + 2 + i, 0; i; ". "; m$
        if i = cursor then \
            let pLink = sublink :\
            print at dL + 2 + i, 0; ink MENU_SELECTED_INK; i; ".>"; m$
    next i
return

@text_help:
data 5
data "Menu controls:"
data ""
data "\u/\d, Up/Down - select item,"
data "\r,   Enter   - choose item,"
data "\l,   Left    - return"
