
10  border 0
20  paper 0
30  ink 7
40 load "" screen$
50 pause 0
60 load "" screen$
70 pause 0
100 cls
110 let menu = 9000
120 go sub 1000

0999 stop

1000 rem Menu
1010 let cursor = 1
1020 restore menu
1030 read t$, items
1031 ink 4
1032 print at 0, 0; t$
1033 print
1050 for i = 1 to items
1060   read m$, link
1062   if i = cursor then ink 1
1063   if i <> cursor then ink 4
1080   print m$
1090 next i
1100 pause 0
1110 let key = code inkey$
1120 if key = 10 then let cursor = cursor + 1
1130 if key = 11 then let cursor = cursor - 1
1140 if cursor > items then let cursor = items
1150 if cursor < 1 then let cursor = 1
1900 go to 1020
1999 return

9000 data "This is sample menu", 3
9001 data "Item1", 0
9002 data "Item2", 0
9003 data "Item3", 0

