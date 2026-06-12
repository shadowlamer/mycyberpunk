rem ****** Menu data ******
@menu_items:

@items_main:
data "What do you want to know?", 3, 2
data "30+ years of experience."
data "Just for fun."
data "About me",            @show_about
data "Notable projects",    @items_projects
data "Contact me",          @show_contacts

@items_projects:
data "Notable projects", 6, 2
data "Things I've built or helped"
data "build over the years."
data "Vending machines (since 2017)", @show_machine
data "LED equipment (since 2013)",    @show_led
data "Web development (since 2012)",  @show_java
data "Robot Battle 2025",             @show_nut
data "ZX Spectrum games",             @items_zxgames
data "AI experiments",                @show_zxai

@items_zxgames:
data "ZX Spectrum games", 2, 2
data "Games written in C for the"
data "ZX Spectrum platform."
data "6.6.6.6 Tech support RPG",  @show_6666
data "7.7.7.7 Dungeon crawler",   @show_7777
