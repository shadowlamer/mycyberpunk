#!/usr/bin/env python3
"""Convert ZX Spectrum .scr screenshots to PNG images."""

import sys
from pathlib import Path
from PIL import Image

# ZX Spectrum standard palette (8 colors)
PALETTE = [
    (0, 0, 0),        # 0: Black
    (0, 0, 215),      # 1: Blue
    (215, 0, 0),      # 2: Red
    (215, 0, 215),    # 3: Magenta
    (0, 215, 0),      # 4: Green
    (0, 215, 215),    # 5: Cyan
    (215, 215, 0),    # 6: Yellow
    (215, 215, 215),  # 7: White
]

SCREEN_WIDTH = 256
SCREEN_HEIGHT = 192
ATTR_OFFSET = 6144
SCR_SIZE = 6912


def pixel_address(x, y):
    """Calculate byte offset and bit position for pixel at (x, y)."""
    third = y // 64
    row = (y % 64) // 8
    line = y % 8
    col = x // 8
    byte_offset = third * 2048 + row * 256 + line * 32 + col
    bit = 7 - (x % 8)
    return byte_offset, bit


def attr_address(x, y):
    """Calculate attribute byte offset for character cell at (x, y)."""
    row = y // 8
    col = x // 8
    return ATTR_OFFSET + row * 32 + col


def scr_to_image(scr_path):
    """Convert a .scr file to a PIL Image."""
    data = Path(scr_path).read_bytes()
    if len(data) < SCR_SIZE:
        raise ValueError(f"File too small: {len(data)} bytes, expected {SCR_SIZE}")

    img = Image.new('RGB', (SCREEN_WIDTH, SCREEN_HEIGHT))
    pixels = img.load()

    for y in range(SCREEN_HEIGHT):
        for x in range(SCREEN_WIDTH):
            byte_off, bit = pixel_address(x, y)
            pixel_set = (data[byte_off] >> bit) & 1

            attr = data[attr_address(x, y)]
            ink = attr & 0x07
            paper = (attr >> 3) & 0x07

            if pixel_set:
                pixels[x, y] = PALETTE[ink]
            else:
                pixels[x, y] = PALETTE[paper]

    return img


def main():
    if len(sys.argv) < 2:
        print(f"Usage: {sys.argv[0]} <file.scr> [file2.scr ...]")
        sys.exit(1)

    for scr_path in sys.argv[1:]:
        scr = Path(scr_path)
        if not scr.exists():
            print(f"File not found: {scr_path}")
            continue

        img = scr_to_image(scr)
        out_path = scr.with_suffix('.png')
        img.save(out_path)
        print(f"{scr.name} -> {out_path}")


if __name__ == '__main__':
    main()
