LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;

ENTITY mux2to1_8bit IS
    PORT(
        i0, i1   : IN  STD_LOGIC_VECTOR(7 DOWNTO 0);
        s        : IN  STD_LOGIC;
        o_data   : OUT STD_LOGIC_VECTOR(7 DOWNTO 0)
    );
END mux2to1_8bit;

ARCHITECTURE struct OF mux2to1_8bit IS
BEGIN
    o_data <= i0 WHEN s = '0' ELSE i1;
END struct;
