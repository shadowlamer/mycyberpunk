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
    for b = 1 to lines
        restore pText + b
        read l$
        PREVENT_SCROLL
        if l$ = "\*" then goto @text_contact
        if l$ = "sub" then goto @text_sub
@text_line:
        print l$
        goto @skip_extra
@text_contact:
        read contactPos
        read pContact
        go sub @show_contact
        goto @skip_extra
@text_sub:
        read pSub
        go sub pSub
        goto @skip_extra
@skip_extra:
    next b
return

@show_article:
rem ***** Show article *****
    cls
    restore pArticle
    read i$
    if i$ = "" then goto @skip_image
    load i$ screen$
    pause ARTICLE_SCROLL_PAUSE
    let key = code inkey$
    if key = KEY_BACKWARD then return;
    go sub @prescroll
@skip_image:
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
