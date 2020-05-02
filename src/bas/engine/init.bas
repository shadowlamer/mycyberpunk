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
