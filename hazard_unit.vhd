library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity hazard_unit is
    port (
        rt, rs, Rt_IDEX  : in std_logic_vector(4 downto 0);
        MemRead_IDEX      : in std_logic;
        Selector            : out std_logic;
		  PCWrite : out std_logic;
		  IFID_Write : out std_logic
    );
end hazard_unit;

architecture Structural of hazard_unit is

    component equalComparator8
        port (
            A, B : in std_logic_vector(7 downto 0);
            EQ   : out std_logic
        );
    end component;

    signal rt_extended, rs_extended, Rt_IDEX_extended : std_logic_vector(7 downto 0);
    signal EQ1, EQ2 : std_logic;

begin

    -- Extend 5-bit inputs to 8-bit by padding with zeros
    rt_extended(7 downto 5) <= "000";
    rt_extended(4 downto 0) <= rt;

    rs_extended(7 downto 5) <= "000";
    rs_extended(4 downto 0) <= rs;

    Rt_IDEX_extended(7 downto 5) <= "000";
    Rt_IDEX_extended(4 downto 0) <= Rt_IDEX;

    -- Instantiate comparators
    COMP1: equalComparator8 port map(rt_extended, Rt_IDEX_extended, EQ1);
    COMP2: equalComparator8 port map(rs_extended, Rt_IDEX_extended, EQ2);

    -- Hazard detection logic
    Selector <= MemRead_IDEX and (EQ1 or EQ2);
	 
	 PCWrite <= not( MemRead_IDEX and (EQ1 or EQ2));
	 IFID_Write <= not( MemRead_IDEX and (EQ1 or EQ2));

end Structural;
