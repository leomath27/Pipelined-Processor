library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity EdgeDetector is
    Port (
        din   : in  STD_LOGIC;  -- Input signal
        dout  : out STD_LOGIC   -- Edge detection output
    );
end EdgeDetector;

architecture Behavioral of EdgeDetector is
begin

    process
    begin
        wait until rising_edge(din);
        dout <= '1';
        wait for 20 ns;
        dout <= '0';

        wait until falling_edge(din);
        dout <= '1';
        wait for 20 ns;
        dout <= '0';
    end process;

end Behavioral;
