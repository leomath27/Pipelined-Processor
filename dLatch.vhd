library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
entity d_latch is
    Port ( D : in STD_LOGIC;
           EN : in STD_LOGIC;
           Q : out STD_LOGIC);
end d_latch;

architecture Structural of d_latch is
    signal s, r, q_internal, q_not_internal : STD_LOGIC;
begin

    s <= EN nand D;
    r <= EN nand (not D);
    q_internal <= s nand q_not_internal;
    q_not_internal <= r nand q_internal;

    Q <= q_internal;

end Structural;
