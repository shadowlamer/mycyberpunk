
border 0
paper 0
ink 7
cls
let menu = @menu_main
go to @menu_start

stop

rem ****** Routines *******

@menu_start:
rem ******** Menu *********
let bklink = 0
@menu_loop_item:
let cursor = 1
cls
@menu_loop:
restore menu
read t$, items
ink 4
print at 0, 0; t$
print
for i = 1 to items
  read m$, l
  ink 7
  if i = cursor then ink 1: let link = l
  print m$
next i
pause 0
let key = code inkey$
if key = 10 then let cursor = cursor + 1
if key = 11 then let cursor = cursor - 1
if cursor > items then let cursor = items
if cursor < 1 then let cursor = 1
if key = 13 and link > @menu then \
    let bklink = menu :\
    let menu = link :\
    go to @menu_loop_item
if key = 13 and link < @menu then go sub link
if key = 8 and bklink > @menu then \
    let menu = bklink :\
    let bklink = 0 :\
    go to @menu_loop_item
go to @menu_loop

@pictures:
for i = 1 to 2
    load "" screen$
    print at 20, 7; " Press any key... "
    pause 0
next i
cls
return

@lamb:
ink 7: cls
print "Mary had a little lamb,"
print "whose fleece was white as snow."
print "And everywhere that Mary went,"
print "the lamb was sure to go."
print "It followed her to school one day"
print "which was against the rules."
print "It made the children laugh and play,"
print "to see a lamb at school."
print "And so the teacher turned it out,"
print "but still it lingered near,"
print "And waited patiently about,"
print "till Mary did appear."
print ""
print "Press any key..."
pause 0
cls
return

@star:
ink 7: cls
print "Twinkle, twinkle, little star,"
print "How I wonder what you are."
print "Up above the world so high,"
print "Like a diamond in the sky."
print ""
print "When the blazing sun is gone,"
print "When he nothing shines upon,"
print "Then you show your little light,"
print "Twinkle, twinkle, all the night."
print ""
print "Press any key..."
pause 0
cls
return

@menu:
rem ****** Menu data ******
# Format:
# Title, Num_items
# Subtitle1, link
# Subtitle2, link
# ...
#
# link > @menu -> subitem
# link < @menu -> go sub

@menu_main:
data "Make your choice, stranger!", 2
data "Pictures", @pictures
data "Texts", @menu_texts

@menu_texts:
data "Choose text, stranger!", 2
data "Mary Had a Little Lamb", @star
data "Twinkle Twinkle Little Star", @lamb
