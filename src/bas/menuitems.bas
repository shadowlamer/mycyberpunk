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
