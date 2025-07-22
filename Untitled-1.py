def hex_to_binary_groups(hex_value):
    # Convert hex to 32-bit binary string
    binary_str = format(int(hex_value, 16), '032b')
    
    # Split into groups based on bit positions and convert to decimal
    groups = {
        '[31-26]': int(binary_str[0:6], 2),
        '[25-21]': int(binary_str[6:11], 2),
        '[20-16]': int(binary_str[11:16], 2),
        '[15-11]': int(binary_str[16:21], 2),
        '[10-6]': int(binary_str[21:26], 2),
        '[5-0]': int(binary_str[26:32], 2),
        'offset': int(binary_str[16:32], 2)  # Extract the offset from bits [7..0] and sign-extend
    }
    
    # Identify instruction type
    opcode = groups['[31-26]']
    instruction = "Unknown"
    rs = rt = rd = shamt = funct = offset = None
    funct_op = None  # Variable to hold the mapped funct operation
    
    if opcode == 35:
        instruction = "lw"
        rs = groups['[25-21]']
        rt = groups['[20-16]']
        offset = groups['offset']
        # Handle the signed binary offset (sign extension)
        if offset >= 0x8000:  # If the offset is in the negative range
            offset -= 0x10000  # Apply 16-bit sign extension for signed numbers
    elif opcode == 43:
        instruction = "sw"
        rs = groups['[25-21]']
        rt = groups['[20-16]']
        offset = groups['offset']
        # Handle the signed binary offset (sign extension)
        if offset >= 0x8000:  # If the offset is in the negative range
            offset -= 0x10000  # Apply 16-bit sign extension for signed numbers
    elif opcode == 0:
        instruction = "R-type"
        # Extract R-type instruction fields
        rs = groups['[25-21]']
        rt = groups['[20-16]']
        rd = groups['[15-11]']
        shamt = groups['[10-6]']
        funct = groups['[5-0]'] & 0xF  # Only the 4 least significant bits (funct[3..0])
        
        # Map funct value to the corresponding operation
        if funct == 0b0100:
            funct_op = "AND"
        elif funct == 0b0101:
            funct_op = "OR"
        elif funct == 0b0000:
            funct_op = "ADD"
        elif funct == 0b0010:
            funct_op = "SUBTRACT"
        elif funct == 0b1010:
            funct_op = "SET-ON-LESS-THAN"
        else:
            funct_op = "Unknown"
    elif opcode == 4:
        instruction = "beq"
        rs = groups['[25-21]']
        rt = groups['[20-16]']
        offset = groups['offset']
        # Handle the signed binary offset (sign extension) for branch
        if offset >= 0x8000:  # If the offset is in the negative range
            offset -= 0x10000  # Apply 16-bit sign extension for signed numbers
        offset *= 4  # Multiply by 4 to get the byte offset
    elif opcode == 2:
        instruction = "Jump"
    
    return groups, instruction, rs, rt, rd, shamt, funct, funct_op, offset
while True:
    # Example usage
    hex_value = input("Enter 8-character hex value: ")
    groups, instruction, rs, rt, rd, shamt, funct, funct_op, offset = hex_to_binary_groups(hex_value)

    # Print the groups
    # for key, value in groups.items():
        # print(f"{key}: {value}")
        
    # Print the instruction type
    # print(f"Instruction Type: {instruction}")

    # If it's an R-type, also print in the rs FUNCTION rt => rd format
    if instruction == "R-type":
        # print(f"{rs} {funct_op} {rt} => {rd}")
        print(f"{funct_op}, ${rd}, ${rs}, ${rt}")

    # If it's an lw instruction, print the details including the offset
    if instruction == "lw":
        # print(f"rs: {rs}")
        # print(f"rt: {rt}")
        # print(f"Offset: {offset}")
        print(f"lw, ${rt}, {offset}(${rs})")

    # If it's a sw instruction, print the details including the offset
    if instruction == "sw":
        # print(f"rs: {rs}")
        # print(f"rt: {rt}")
        # print(f"Offset: {offset}")
        print(f"sw, ${rt}, {offset}(${rs})")

    # If it's a beq instruction, print the branch details
    if instruction == "beq":
        print(f"beq ${rs}, ${rt}, {offset}")
