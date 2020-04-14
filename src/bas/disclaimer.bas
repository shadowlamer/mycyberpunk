@show_disclaimer:
rem *** Show disclaimer ***
    cls
    TEXT(@text_hello)
    plot 2, 105: draw 84, 4
    let contactPos = 10
    let pContact = @contact_repo
    go sub @show_contact
    let contactPos = 16
    let pContact = @contact_jsspeccy
    go sub @show_contact
    go sub @wait
return

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

@contact_repo:
data \
    "Full source of this page",\
    "available at",\
    "https://github.com",\
    "   /shadowlamer/mycyberpunk",\
    GENQR(https://github.com/shadowlamer/mycyberpunk)

@contact_jsspeccy:
data \
    "Source of emulator",\
    "available at",\
    "https://github.com",\
    "          /gasman/jsspeccy2",\
    GENQR(https://github.com/gasman/jsspeccy2)
