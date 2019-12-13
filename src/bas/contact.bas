define(SCREEN_START, 16384)
define(SCREEN_CHAR_WIDTH, 32)

@show_contact:
rem ****** Contact *******
  restore pContact
  for i = 0 to 3
    read s$
    print at contactPos + i, 0; ink DEFAULT_INK; paper DEFAULT_PAPER; "     "; s$
  next i
  go sub @show_qr
return

@show_qr:
rem ****** QR code *******
  let third = int (contactPos / 8)
  let row = (contactPos - third * 8)
  let base = SCREEN_START + third * 2048 + row * SCREEN_CHAR_WIDTH
  for y=0 to 3
    let pos = base + y * SCREEN_CHAR_WIDTH
    for l = 0 to 7
        for x=0 to 3
            read byte
            poke pos, byte
            let pos = pos + 1
        next x
        let pos = pos + 252
    next l
  next y
return

