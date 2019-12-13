define(MENU_HELP_POSITION, 16)

rem ******** Menu *********
@main_menu:
    let pLink = 0
    let pBkLink = 0
    let cursor = 1
    let pItem = @items_main
    cls
    @menu_loop:
        restore pItem
        read t$, nItems
        print at 0, 0; t$
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
        pause 0
        let key = code inkey$
        if key = KEY_DOWN then \
            let cursor = cursor + 1
        if key = KEY_UP then \
            let cursor = cursor - 1
        if cursor > nItems then \
            let cursor = nItems
        if cursor < 1 then \
            let cursor = 1
        if key = KEY_FORWARD and pLink >= @menu_items then \
            let pBkLink = pItem :\
            let pItem = pLink :\
            let cursor = 1 :\
            cls
        if key = KEY_FORWARD and pLink < @menu_items then \
            go sub pLink :\
            cls
        if key = KEY_BACKWARD and pBkLink >= @menu_items then \
            let pItem = pBkLink :\
            let pBkLink = 0 :\
            let cursor = 1 :\
            cls
        if key = KEY_STOP then \
            return
    go to @menu_loop
return

@text_help:
data 5
data "Menu controls:"
data ""
data "\u/\d, Up/Down - select item,"
data "\r,   Enter   - choose item,"
data "\l,   Left    - return"
