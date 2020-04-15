@show_disclaimer:
    ARTICLE(@article_discl)
return

@article_discl:
data "", 1
data @text_hello

@text_hello:
data 12
data "This page is written in pure"
data "Sinclair BASIC and run in a"
data "living ZX Spectrum emulator."
data "You can press ""0"" or \s on"
data "virtual keypad to see source."
data "However modern technologies such"
data "as JS or Docker is used for its"
data "work. Yes, I know a lot about"
data "perversions programming. Enjoy."
data "sub", @disc_strike
data "\*", 10, @contact_repo
data "\*", 16, @contact_jsspeccy


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

@disc_strike:
    plot 2, 105: draw 84, 4
    return