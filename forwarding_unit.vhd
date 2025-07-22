library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity forwarding_unit is
    port (
        RR1, RR2, rs, rt : in std_logic_vector(4 downto 0);
        WR1, WR2          : in std_logic;
        MUX1, MUX2        : out std_logic_vector(1 downto 0)
    );
end forwarding_unit;

architecture Structural of forwarding_unit is

    component equalComparator8
        port (
            A, B : in std_logic_vector(7 downto 0);
            EQ   : out std_logic
        );
    end component;

    signal rs_extended, RR1_extended, RR2_extended, rt_extended : std_logic_vector(7 downto 0);
    signal EQ1, EQ2, EQ3, EQ4 : std_logic;

begin

    -- Extend 5-bit inputs to 8-bit by padding with zeros
    rs_extended <= "000" & rs;
    RR1_extended <= "000" & RR1;
    RR2_extended <= "000" & RR2;
    rt_extended <= "000" & rt;

    -- Instantiate comparators
    COMP1: equalComparator8 port map(rs_extended, RR1_extended, EQ1);
    COMP2: equalComparator8 port map(rs_extended, RR2_extended, EQ2);
    COMP3: equalComparator8 port map(rt_extended, RR1_extended, EQ3);
    COMP4: equalComparator8 port map(rt_extended, RR2_extended, EQ4);

    -- Forwarding logic
    MUX1(1)<=WR1 and EQ1;
    MUX1(0)<=WR2 and EQ2;
    MUX2(1)<=WR1 and EQ3;
    MUX2(0)<=WR2 and EQ4;


end Structural;
