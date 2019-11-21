# Set line number increment to 1 in zmakebas. Data pointer manipulations depends on this.

go sub @init
go sub @show_disclaimer
go sub @main_menu
stop

@init:
rem ******** Init *********
    bright 0: flash 0: border 0: paper 0: ink 7
    cls
    print "Loading";
rem ****** Setup UDG ******
    restore @udg
    read num
    for n = 1 to num
        read c$
        for i = 0 to 7
            read byte
            poke usr c$ + i, byte
        next i
        print ".";
    next n
    cls
return

@main_menu:
rem ******** Menu *********
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
                print ink 4; i; ".>"; m$
            if i <> cursor then \
                print i; ". "; m$
        next i
        let pText = @text_help
        print at 16, 0
        go sub @show_text
        pause 0
        let key = code inkey$
        if key = 10 then \
            let cursor = cursor + 1
        if key = 11 then \
            let cursor = cursor - 1
        if cursor > nItems then \
            let cursor = nItems
        if cursor < 1 then \
            let cursor = 1
        if key = 13 and pLink > @menu_items then \
            let pBkLink = pItem :\
            let pItem = pLink :\
            let cursor = 1 :\
            cls
        if key = 13 and pLink < @menu_items then \
            go sub pLink :\
            cls
        if key = 8 and pBkLink > @menu_items then \
            let pItem = pBkLink :\
            let pBkLink = 0 :\
            let cursor = 1 :\
            cls
        if key = 48 then \
            return
    go to @menu_loop
return

@show_contact:
rem ****** Contact *******
  restore pContact
  for i = 0 to 3
    read s$
    print at contactPos + i,0; ink 7; paper 0; "     "; s$
  next i
  go sub @show_qr
return

@show_qr:
rem ****** QR code *******
  let third = int (contactPos / 8)
  let row = (contactPos - third * 8)
  let base = 16384 + third * 2048 + row * 32
  for y=0 to 3
    let pos = base + y * 32
    for l = 0 to 7
        for x=0 to 3
            read byte
            poke pos, byte
            let pos = pos + 1
        next x
        let pos = pos + 252
    next l
  next y
return

@prescroll:
rem ****** Prescroll ******
    print at 21,0;
    for i = 1 to 4
        POKE 23692,255
        print ""
    next i
return

@wait:
rem ******** Wait *********
    print ""
    print at 21,0; ink 4; "Press any key...                "
    pause 0
    print at 21,0; ink 7; "                                "
return

@show_text:
rem ****** Show text ******
    restore pText
    read lines
    for i = 1 to lines
        read l$
        POKE 23692,255
        print l$
    next i
return

@show_article:
rem ***** Show article *****
    cls
    restore pArticle
    read i$
    load i$ screen$
    pause 20 * 5
    let key = code inkey$
    if key = 8 then return;
    go sub @prescroll
    read pages
    for p = 1 to pages
        restore pArticle + p
        read pText
        go sub @show_text
        go sub @wait
        let key = code inkey$
        if key = 8 then return;
    next p
return

@show_disclaimer:
rem *** Show disclaimer ***
    cls
    let pText = @text_hello
    go sub @show_text
    plot 2, 105: draw 84, 4
    let contactPos = 10
    let pContact = @contact_repo
    go sub @show_contact
    let contactPos = 16
    let pContact = @contact_jsspeccy
    go sub @show_contact
    go sub @wait
return

@show_contacts:
rem **** Show contacts ****
    cls
    print ink 4; "My contacts"
    let contactPos = 4
    let pContact = @contact_email
    go sub @show_contact
    let contactPos = 10
    let pContact = @contact_github
    go sub @show_contact
    let contactPos = 16
    let pContact = @contact_linkedin
    go sub @show_contact
    go sub @wait
return

@show_about:
rem ****** Show about *****
    let pArticle = @article_about
    go sub @show_article
return

rem **** Show projects ****
@show_proj1:
    let pArticle = @article_proj1
    go sub @show_article
return
@show_proj2:
    let pArticle = @article_proj2
    go sub @show_article
return
@show_proj3:
    let pArticle = @article_proj3
    go sub @show_article
return

@menu_items:
rem ****** Menu data ******

@items_main:
data "What do you want to know?", 3
data "About me",            @show_about
data "Notable projects",    @items_projects
data "Contact me",          @show_contacts

@items_projects:
data "Notable projects", 3
data "Vending machines (since 2017)", @show_proj1
data "Led equipment    (since 2013)", @show_proj2
data "Web development  (since 2012)", @show_proj3


rem **** Contacts data ****

@contact_repo:
data \
    "Full source of this page",\
    "available at",\
    "https://github.com",\
    "   /shadowlamer/mycyberpunk",\
    255,255,255,255,255,255,255,255,255,255,255,255,240,22,76,7,247,217,213,247,244,93,13,23,\
    244,95,21,23,244,90,181,23,247,221,117,247,240,21,84,7,255,244,143,255,242,88,213,247,247,\
    99,126,15,249,68,130,183,248,184,108,135,247,138,20,247,244,51,203,111,243,94,9,7,246,246,\
    236,151,246,73,208,79,255,242,55,79,240,30,245,119,247,223,71,103,244,81,0,103,244,81,197,\
    231,244,93,67,7,247,211,222,71,240,21,147,183,255,255,255,255,255,255,255,255,255,255,255,\
    255,255,255,255,255

@contact_jsspeccy:
data \
    "Source of emulator",\
    "available at",\
    "https://github.com",\
    "          /gasman/jsspeccy2",\
    255,255,255,255,255,255,255,255,255,255,255,255,240,27,28,7,247,214,45,247,244,80,93,23,244,\
    88,237,23,244,87,165,23,247,210,173,247,240,21,84,7,255,243,119,255,242,205,132,79,243,100,\
    161,247,244,65,247,231,245,111,147,127,247,87,65,167,253,164,52,151,246,215,92,87,251,107,\
    19,111,240,156,128,31,255,247,199,55,240,17,165,39,247,216,183,31,244,94,80,55,244,86,58,31,\
    244,92,22,87,247,214,33,191,240,22,198,231,255,255,255,255,255,255,255,255,255,255,255,255,\
    255,255,255,255

@contact_email:
data \
    "My email: sl\@anhot.ru",\
    "",\
    "",\
    "",\
    255,255,255,255,255,255,255,255,255,255,255,255,240,27,188,7,247,210,13,247,244,88,229,23,\
    244,82,133,23,244,93,85,23,247,213,165,247,240,21,84,7,255,255,119,255,240,65,26,175,240,\
    227,210,159,255,90,76,103,242,104,202,103,243,10,249,23,243,229,55,223,245,203,138,39,245,\
    177,52,103,244,13,80,79,255,247,231,127,240,18,117,39,247,218,215,119,244,84,224,7,244,87,\
    25,71,244,87,141,215,247,213,37,55,240,19,93,71,255,255,255,255,255,255,255,255,255,255,\
    255,255,255,255,255,255

@contact_github:
data \
    "My GitHub profile:         ",\
    "https://github.com         ",\
    "               /shadowlamer",\
    "",\
    255,255,255,255,255,255,255,255,255,255,255,255,240,22,76,7,247,209,53,247,244,92,45,23,244,\
    93,189,23,244,80,253,23,247,214,253,247,240,21,84,7,255,244,111,255,241,145,176,103,250,113,\
    180,167,243,22,203,151,241,227,194,191,245,194,20,247,251,47,40,231,241,219,45,151,252,118,\
    70,63,241,133,144,111,255,243,183,119,240,24,245,119,247,209,167,111,244,90,32,119,244,91,\
    111,79,244,85,10,39,247,212,80,127,240,23,147,183,255,255,255,255,255,255,255,255,255,255,\
    255,255,255,255,255,255

@contact_linkedin:
data \
    "My LinkedIn profile:       ",\
    "https://linkedin.com/in    1",\
    "               /shadowlamer",\
    "",\
    255,255,255,255,255,255,255,255,255,255,255,255,240,22,28,7,247,217,157,247,244,93,29,23,244,\
    95,37,23,244,90,253,23,247,221,85,247,240,21,84,7,255,244,151,255,242,88,245,247,243,171,14,\
    15,246,68,170,183,253,224,65,135,243,90,109,247,244,39,135,111,240,146,107,7,245,170,218,151,\
    244,203,32,79,255,244,39,79,240,24,85,119,247,219,7,103,244,82,128,127,244,82,81,231,244,88,\
    127,7,247,209,232,71,240,20,51,183,255,255,255,255,255,255,255,255,255,255,255,255,255,255,\
    255,255

rem ******** Texts ********

@text_hello:
data 9
data "This page is written in pure"
data "Sinclair BASIC and run in a"
data "living ZX Spectrum emulator."
data "You can press ""0"" or \s on"
data "virtual keypad to see source."
data "However modern technologies such"
data "as JS or Docker is used for its"
data "work. Yes, I know a lot about"
data "perversions programming. Enjoy."

@text_about1:
data 20
data "This is me on a photo."
data "My name is Vadim Cherenev and"
data "I am a bad programmer."
data "I can program equally badly in"
data "any language from brainf**k to"
data "prolog. If you count the"
data "languages for which I was paid"
data "for development, there will be"
data "more than a dozen. If you accept"
data "dialects (such as JavaScript,"
data "TypeScript, ActionScript) as"
data "separate languages you can"
data "multiply this number by two."
data "If you count pet-projects and"
data "helloworlds, you can multiply by"
data "two more."
data "I have 20+ years of development"
data "experience from the first salary"
data "and 25+ years from the first"
data "helloworld."

@text_about2:
data 20
data "I am able to full stack. And try"
data "to constantly expand the"
data "boundaries of this concept"
data "I can assemble a computing"
data "device (I probably can assemble"
data "the CPU myself but have"
data "not tried). I can program it,"
data "connect with other devices,"
data "connect to the Internet (it"
data "seems called ""IoT"" now). I can"
data "write web-service (front, back),"
data "mobile application, the upper"
data "level of SCADA system. I can"
data "assemble an analog device,"
data "sensor or power supply. I can"
data "start production or development"
data "process. With any luck, all this"
data "will even work."
data "As a bonus I can weld the case"
data "or write some documentation."

@text_about3:
data 20
data "I can help with the technical"
data "part of your startup, provided"
data "that you are smart enough to"
data "replace me with a team of good"
data "developers on time."
data "I have experience in teamwork"
data "and independent work"
data "I do not know how to turn"
data "on a lathe and drive a car."
data "I do not know English. I wrote"
data "this text in English only"
data "because ZX Spectrum has no"
data "cyrillic character generator"
data "and I was too lazy to program"
data "it. Thanks Google Translate."
data "What is my mission? Perhaps"
data "to satisfy my own curiosity"
data "at the expense of others."
data "Feel free to contact me if you"
data "are interested."

@text_proj1_1:
data 20
data "One small but proud vending"
data "machine manufacturer company"
data "asked to develop electronics"
data "and software for their machines."
data "I designed it, made prototypes,"
data "and helped launch production."
data "The equipment allows you to sell"
data "for cash and bank transfer,"
data "accepts contactless cards and"
data "allows you to connect terminals"
data "of two famous banks."
data "There is a remote monitoring."
data "Users can manage their devices"
data "through personal account."
data "Today, there are several"
data "thousand devices connected to"
data "the network, hundreds of users,"
data "dozens of new connections per"
data "month. One person manages"
data "technical support."

@text_proj2_1:
data 20
data "By request of representatives"
data "of the local show business, I"
data "developed a series of devices"
data "for LED equipment controlling."
data "The controllers are mainly "
data "oriented to use in LED suits"
data "and can work both with"
data "individual LEDs, LED stripes and"
data "matrices of various addressable"
data "LEDs. An important task in the"
data "development of such controllers"
data "is synchronization with music."
data "Devices have evolved"
data "sequentially from using DTMF"
data "sequences built into music to"
data "support MIDI and ArtNet"
data "protocols over WiFi."
data "Also, several controller models"
data "were developed for LED props,"
data "poi, luminous orbs, etc."

@text_proj3_1:
data 20
data "Managed to work as a hired"
data "full-stack developer in several"
data "projects. "
data "Used on the back-end:"
data "  Java, Spring, Spring Boot"
data "On the front-end"
data "  GWT, Flex, pure JavaScript,"
data "  AngularJS/Angular2"
data "For persistent storage:"
data "  JDBC, JPA, Hibernate, various"
data "  RDBs, Mongo, Elasticsearch"
data "Gained experience in teamwork,"
data "daily visits to the office, "
data "using collaboration tools."
data "Realized the value of testers"
data "and project managers."
data "I apply the acquired knowledge"
data "and experience when I need to"
data "develop a web service. This page"
data "for example."

@text_help:
data 5
data "Menu controls:"
data ""
data "\u/\d, Up/Down - select item,"
data "\r,   Enter   - choose item,"
data "\l,   Left    - return"

rem ****** Articles *******

@article_about:
data "photo", 3
data @text_about1
data @text_about2
data @text_about3

@article_proj1:
data "machine", 1
data @text_proj1_1

@article_proj2:
data "led", 1
data @text_proj2_1

@article_proj3:
data "java", 1
data @text_proj3_1

rem ****** UDG data *******

@udg:
data 5
# Stop button
data "S",60,66,129,153,153,129,66,60
# Up arrow
data "U",0,16,56,84,16,16,16,0
# Down arrow
data "D",0,8,8,8,42,28,8,0
# Left arrow
data "L",0,0,18,54,126,54,18,0
# Right arrow
data "R",0,0,72,108,126,108,72,0
