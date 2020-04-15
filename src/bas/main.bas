# Set line number increment to 1 in zmakebas. Data pointer manipulations depends on this.

define(VERSION, "V19.12.14")
define(KEY_DOWN,     10)
define(KEY_UP,       11)
define(KEY_FORWARD,  13)
define(KEY_BACKWARD, 8)
define(KEY_STOP,     48)

define(DEFAULT_PAPER, 0)
define(DEFAULT_INK, 7)
define(MENU_SELECTED_INK, 4)
define(INFO_INK, 4)

define(LAST_SCREEN_LINE, 21)

go sub @init
go sub @show_disclaimer
go sub @main_menu
stop

rem ******** Init *********
@init:
    bright 0: flash 0: border DEFAULT_PAPER: paper DEFAULT_PAPER: ink DEFAULT_INK
    cls
    print VERSION; " Loading";
    go sub @udg_setup
    cls
return

include(cyberpunk.bas)

include(disclaimer.bas)
include(mycontacts.bas)
include(projects.bas)

rem ****** Menu data ******
@menu_items:

@items_main:
data "What do you want to know?", 3
data "About me",            @show_about
data "Notable projects",    @items_projects
data "Contact me",          @show_contacts

@items_projects:
data "Notable projects", 3
data "Vending machines (since 2017)", @show_machine
data "LED equipment    (since 2013)", @show_led
data "Web development  (since 2012)", @show_java
