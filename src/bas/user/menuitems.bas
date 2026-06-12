rem ****** Menu data ******
@menu_items:

@items_main:
data "What do you want to know?", 4, 2
data "30+ years of experience."
data "Just for fun."
data "About me",            @show_about
data "Notable projects",    @items_projects
data "ZX Spectrum",         @items_zx
data "Contact me",          @show_contacts

@items_projects:
data "Notable projects", 3, 2
data "Things I've built or helped"
data "build over the years."
data "Vending machines (since 2017)", @show_machine
data "LED equipment    (since 2013)", @show_led
data "Web development  (since 2012)", @show_java

@items_zx:
data "ZX Spectrum", 3, 2
data "Games and experiments for"
data "the ZX Spectrum platform."
data "6.6.6.6 Tech support RPG",  @show_6666
data "7.7.7.7 Dungeon crawler",   @show_7777
data "Neural ZX Spectrum art",    @show_zxai
