LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

ENTITY decoder3to8 IS
    PORT(
        i_addr : IN  STD_LOGIC_VECTOR(2 DOWNTO 0);  -- 3-bit input address
        o_dec  : OUT STD_LOGIC_VECTOR(7 DOWNTO 0)  -- 8-bit one-hot output
    );
END decoder3to8;

ARCHITECTURE structural OF decoder3to8 IS
    TYPE decoder_array IS ARRAY (0 TO 7) OF STD_LOGIC_VECTOR(2 DOWNTO 0);
    CONSTANT decoder_map : decoder_array := (
        "000", "001", "010", "011",
        "100", "101", "110", "111"
    );
BEGIN
    GEN_DECODE: FOR i IN 0 TO 7 GENERATE
        o_dec(i) <= '1' WHEN i_addr = decoder_map(i) ELSE '0';
    END GENERATE GEN_DECODE;
END structural;
