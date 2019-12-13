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
