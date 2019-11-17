
10 border 0
20 paper 0
30 ink 7
100 cls
110 let menu = 9010
120 go sub 1010

0999 stop

1000 rem ****** Routines *******

1010 rem ******** Menu *********
1019 let bklink = 0
1020 let cursor = 1
1021 cls
1030 restore menu
1040 read t$, items
1050 ink 4
1060 print at 0, 0; t$
1070 print
1080 for i = 1 to items
1090   read m$, l
1100   ink 7
1110   if i = cursor then ink 1: let link = l
1120   print m$
1130 next i
1140 pause 0
1150 let key = code inkey$
1160 if key = 10 then let cursor = cursor + 1
1170 if key = 11 then let cursor = cursor - 1
1180 if cursor > items then let cursor = items
1190 if cursor < 1 then let cursor = 1
1200 if key = 13 and link > 9000 then let bklink = menu : let menu = link : go to 1020
1210 if key = 13 and link < 9000 then go sub link
1220 if key = 8 and bklink > 9000 then let menu = bklink: let bklink = 0 : go to 1020
1900 go to 1030
1999 return

2000 for i = 1 to 2
2010   load "" screen$
2020   print at 20, 7; " Press any key... "
2030   pause 0
2040 next i
2050 cls
2060 return

2100 ink 7: cls
2101 print "Mary had a little lamb,"
2102 print "whose fleece was white as snow."
2103 print "And everywhere that Mary went,"
2104 print "the lamb was sure to go."
2105 print "It followed her to school one day"
2106 print "which was against the rules."
2107 print "It made the children laugh and play,"
2108 print "to see a lamb at school."
2109 print "And so the teacher turned it out,"
2110 print "but still it lingered near,"
2111 print "And waited patiently about,"
2112 print "till Mary did appear."
2117 print ""
2118 print "Press any key..."
2120 pause 0
2130 cls
2140 return

2200 ink 7: cls
2201 print "Twinkle, twinkle, little star,"
2202 print "How I wonder what you are."
2203 print "Up above the world so high,"
2204 print "Like a diamond in the sky."
2205 print ""
2206 print "When the blazing sun is gone,"
2207 print "When he nothing shines upon,"
2208 print "Then you show your little light,"
2209 print "Twinkle, twinkle, all the night."
2210 print ""
2211 print "Press any key..."
2220 pause 0
2221 cls
2230 return

9000 rem ****** Menu data ******
9001 rem Format:
9002 rem Title, Num_items
9003 rem Subtitle1, link
9004 rem Subtitle2, link
9005 rem ...
9006 rem
9007 rem link > 9K -> subitem
9008 rem link < 9K -> go sub

9010 data "Make your choice, stranger!", 2
9011 data "Pictures", 2000
9012 data "Texts", 9030

9030 data "Choose text, stranger!", 2
9031 data "Mary Had a Little Lamb", 2100
9032 data "Twinkle Twinkle Little Star", 2200
