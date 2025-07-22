import re

def assemble_instruction(instruction):
    # Remove comments (everything after a semicolon) and extra spaces
    instruction = instruction.split(';')[0].strip()

    # lw instruction: lw $rt, offset optionally followed by ( $rs )
    if instruction.startswith('lw'):
        match = re.match(r"lw\s+\$(\d+),\s*(-?\d+)(?:\s*\(\s*\$(\d+)\s*\))?", instruction)
        if match:
            rt = int(match.group(1))
            offset = int(match.group(2))
            # If base register is not provided, assume $0
            rs = int(match.group(3)) if match.group(3) is not None else 0
            # Opcode for lw is 35 (0x23)
            machine_code = (35 << 26) | (rs << 21) | (rt << 16) | (offset & 0xFFFF)
        else:
            raise ValueError("Invalid lw instruction format")
    
    # sw instruction: sw $rt, offset optionally followed by ( $rs )
    elif instruction.startswith('sw'):
        match = re.match(r"sw\s+\$(\d+),\s*(-?\d+)(?:\s*\(\s*\$(\d+)\s*\))?", instruction)
        if match:
            rt = int(match.group(1))
            offset = int(match.group(2))
            rs = int(match.group(3)) if match.group(3) is not None else 0
            # Opcode for sw is 43 (0x2B)
            machine_code = (43 << 26) | (rs << 21) | (rt << 16) | (offset & 0xFFFF)
        else:
            raise ValueError("Invalid sw instruction format")
    
    # add instruction: add $rd, $rs, $rt
    elif instruction.startswith('add'):
        match = re.match(r"add\s+\$(\d+),\s*\$(\d+),\s*\$(\d+)", instruction)
        if match:
            rd = int(match.group(1))
            rs = int(match.group(2))
            rt = int(match.group(3))
            # R-type: opcode = 0, funct for add is 32 (0x20)
            machine_code = (0 << 26) | (rs << 21) | (rt << 16) | (rd << 11) | (0 << 6) | 32
        else:
            raise ValueError("Invalid add instruction format")
    
    # sub instruction: sub $rd, $rs, $rt
    elif instruction.startswith('sub'):
        match = re.match(r"sub\s+\$(\d+),\s*\$(\d+),\s*\$(\d+)", instruction)
        if match:
            rd = int(match.group(1))
            rs = int(match.group(2))
            rt = int(match.group(3))
            # R-type: opcode = 0, funct for sub is 34 (0x22)
            machine_code = (0 << 26) | (rs << 21) | (rt << 16) | (rd << 11) | (0 << 6) | 34
        else:
            raise ValueError("Invalid sub instruction format")
    
    # or instruction: or $rd, $rs, $rt
    elif instruction.startswith('or'):
        match = re.match(r"or\s+\$(\d+),\s*\$(\d+),\s*\$(\d+)", instruction)
        if match:
            rd = int(match.group(1))
            rs = int(match.group(2))
            rt = int(match.group(3))
            # R-type: opcode = 0, funct for or is 37 (0x25)
            machine_code = (0 << 26) | (rs << 21) | (rt << 16) | (rd << 11) | (0 << 6) | 37
        else:
            raise ValueError("Invalid or instruction format")
    
    # beq instruction: beq $rs, $rt, offset (offset in bytes in assembly)
    elif instruction.startswith('beq'):
        match = re.match(r"beq\s+\$(\d+),\s*\$(\d+),\s*(-?\d+)", instruction)
        if match:
            rs = int(match.group(1))
            rt = int(match.group(2))
            offset_in_bytes = int(match.group(3))
            # Convert byte offset to word offset
            word_offset = offset_in_bytes // 4
            # Opcode for beq is 4 (0x4)
            machine_code = (4 << 26) | (rs << 21) | (rt << 16) | (word_offset & 0xFFFF)
        else:
            raise ValueError("Invalid beq instruction format")
    
    # jump instruction: j or jump target
    elif instruction.startswith('j'):
        match = re.match(r"j(?:ump)?\s+(\d+)", instruction)
        if match:
            target = int(match.group(1))
            # Opcode for jump is 2 (0x2)
            machine_code = (2 << 26) | (target & 0x3FFFFFF)
        else:
            raise ValueError("Invalid jump instruction format")
    
    else:
        raise ValueError("Unsupported instruction type")
    
    # Return machine code as an 8-character hexadecimal string
    return format(machine_code, '08X')


# Run in an infinite loop:
if __name__ == "__main__":
    while True:
        try:
            instruction = input("Enter the assembly instruction: ").strip()
            if instruction == "":
                continue  # Skip empty input
            machine_code = assemble_instruction(instruction)
            print(f"Machine code: {machine_code}")
        except ValueError as e:
            print(f"Error: {e}")
