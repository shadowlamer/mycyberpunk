define(ARTICLE,
    let pArticle = $1
    go sub @show_article
)

define(TEXT,
        let pText = $1
        go sub @show_text
)

define(PREVENT_SCROLL, `POKE 23692,255')
define(PRESCROLL_LINES, 4)
define(ARTICLE_SCROLL_PAUSE, 100)

@prescroll:
rem ****** Prescroll ******
    print at LAST_SCREEN_LINE, 0;
    for i = 1 to PRESCROLL_LINES
        PREVENT_SCROLL
        print ""
    next i
return

@wait:
rem ******** Wait *********
    print ""
    print at LAST_SCREEN_LINE,0; ink INFO_INK; "Press any key...                "
    pause 0
    print at LAST_SCREEN_LINE,0; ink DEFAULT_INK; "                                "
return

@show_text:
rem ****** Show text ******
    restore pText
    read lines
    for i = 1 to lines
        read l$
        PREVENT_SCROLL
        print l$
    next i
return

@show_article:
rem ***** Show article *****
    cls
    restore pArticle
    read i$
    load i$ screen$
    pause ARTICLE_SCROLL_PAUSE
    let key = code inkey$
    if key = KEY_BACKWARD then return;
    go sub @prescroll
    read pages
    for p = 1 to pages
        restore pArticle + p
        read pText
        go sub @show_text
        go sub @wait
        let key = code inkey$
        if key = KEY_BACKWARD then return;
    next p
return
