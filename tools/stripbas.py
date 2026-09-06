#!/usr/bin/env python3
"""Strip BASIC program blocks from TAP files, keeping only CODE blocks."""
import struct, sys

def strip_basic(input_file, output_file):
    with open(input_file, 'rb') as f:
        data = f.read()
    out = bytearray()
    pos = 0
    skip_data = False
    while pos < len(data):
        if pos + 2 > len(data):
            break
        block_len = struct.unpack('<H', data[pos:pos+2])[0]
        block = data[pos+2:pos+2+block_len]
        # Check if this is a BASIC header (flag=0, type=0)
        if len(block) >= 2 and block[0] == 0 and block[1] == 0:
            skip_data = True
            pos += 2 + block_len
            continue
        if skip_data:
            skip_data = False
            pos += 2 + block_len
            continue
        out += data[pos:pos+2+block_len]
        pos += 2 + block_len
    with open(output_file, 'wb') as f:
        f.write(out)

if __name__ == '__main__':
    strip_basic(sys.argv[1], sys.argv[2])
