rem ****** Setup UDG ******
@udg_setup:
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
return

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
