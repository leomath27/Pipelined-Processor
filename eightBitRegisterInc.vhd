library ieee;
use ieee.std_logic_1164.all;


ENTITY eightBitRegisterInc IS
    PORT(
        i_Value      : IN  STD_LOGIC_VECTOR(7 downto 0);
        clk          : IN  STD_LOGIC;
        reset_bar        : IN  STD_LOGIC;
		  en				: IN  STD_LOGIC;
        o_Value      : OUT STD_LOGIC_VECTOR(7 downto 0)
    );
END eightBitRegisterInc;

ARCHITECTURE structural OF eightBitRegisterInc IS

signal current_state: std_logic_vector(7 downto 0);
signal next_state: std_logic_vector(7 downto 0);
signal mux_to_dff: std_logic_vector(7 downto 0);
signal enabled: std_logic_vector(7 downto 0);
signal load : std_logic;

BEGIN
	 load <='1';
    GEN_BITS: FOR i IN 0 TO 7 GENERATE
        enabled(i) <= en;
        LOAD_MUX: ENTITY work.mux2
            PORT MAP(
                sel  => load,
                a => next_state(i),        -- Normal shift/hold path
                b => i_Value(i),              -- Parallel load
                y => mux_to_dff(i)
            );

        BIT_FF: ENTITY work.enardFF_2
            PORT MAP(
                i_resetBar => reset_bar,
                i_d        => mux_to_dff(i),
                i_enable   => enabled(i),
                i_clock    => clk,
                o_q        => current_state(i),
                o_qBar     => OPEN
            );
    END GENERATE;
	 
	 next_state <= current_state;
    o_Value <= current_state;

END structural;
