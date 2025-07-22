library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity asyncEightBitRegister is
    Port (
        D     : in  STD_LOGIC_VECTOR(7 downto 0);
        EN    : in  STD_LOGIC;
        RESET : in  STD_LOGIC;  -- Added Reset
        Q     : out STD_LOGIC_VECTOR(7 downto 0)
    );
end asyncEightBitRegister;

architecture Structural of asyncEightBitRegister is

    component d_latch is
        Port (
            D  : in  STD_LOGIC;
            EN : in  STD_LOGIC;
            Q  : out STD_LOGIC
        );
    end component;

    signal D_internal : STD_LOGIC_VECTOR(7 downto 0); -- Signal for mux logic

	 signal Enable : Std_LOGIC;
begin

    -- Mux logic to force '0' during reset
    D_internal <= (others => '0') when RESET = '1' else D;
	 Enable <= RESET or EN;
	 
    -- D-Latch instantiation
    latch0: d_latch port map (D => D_internal(0), EN => Enable, Q => Q(0));
    latch1: d_latch port map (D => D_internal(1), EN => Enable, Q => Q(1));
    latch2: d_latch port map (D => D_internal(2), EN => Enable, Q => Q(2));
    latch3: d_latch port map (D => D_internal(3), EN => Enable, Q => Q(3));
    latch4: d_latch port map (D => D_internal(4), EN => Enable, Q => Q(4));
    latch5: d_latch port map (D => D_internal(5), EN => Enable, Q => Q(5));
    latch6: d_latch port map (D => D_internal(6), EN => Enable, Q => Q(6));
    latch7: d_latch port map (D => D_internal(7), EN => Enable, Q => Q(7));

end Structural;
