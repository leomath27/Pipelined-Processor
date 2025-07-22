library ieee;
use ieee.std_logic_1164.all;

entity equalComparator8 is
    port (
        A, B    : in std_logic_vector(7 downto 0);
        EQ       : out std_logic
    );
end equalComparator8;

architecture structural of equalComparator8 is
    signal eq_bits : std_logic_vector(7 downto 0);
begin

    -- Bitwise comparison using simple logic
    GEN_EQ: for i in 0 to 7 generate
        eq_bits(i) <= '1' when A(i) = B(i) else '0';
    end generate;

    -- Combine all results using AND gate
    EQ <= eq_bits(0) and eq_bits(1) and eq_bits(2) and eq_bits(3) and
          eq_bits(4) and eq_bits(5) and eq_bits(6) and eq_bits(7);

end structural;
