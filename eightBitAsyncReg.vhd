LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

ENTITY eightBitAsyncReg IS
    PORT(
        i_d      : IN  STD_LOGIC_VECTOR(7 DOWNTO 0);
        i_enable : IN  STD_LOGIC;
        o_q      : OUT STD_LOGIC_VECTOR(7 DOWNTO 0);
        o_qBar   : OUT STD_LOGIC_VECTOR(7 DOWNTO 0)
    );
END eightBitAsyncReg;

ARCHITECTURE structural OF eightBitAsyncReg IS
    COMPONENT D_LATCH
        PORT(
            i_d      : IN  STD_LOGIC;
            i_enable : IN  STD_LOGIC;
            o_q      : OUT STD_LOGIC;
            o_qBar   : OUT STD_LOGIC
        );
    END COMPONENT;

BEGIN
    REG0: D_LATCH
        PORT MAP(
            i_d      => i_d(0),
            i_enable => i_enable,
            o_q      => o_q(0),
            o_qBar   => o_qBar(0)
        );

    REG1: D_LATCH
        PORT MAP(
            i_d      => i_d(1),
            i_enable => i_enable,
            o_q      => o_q(1),
            o_qBar   => o_qBar(1)
        );

    REG2: D_LATCH
        PORT MAP(
            i_d      => i_d(2),
            i_enable => i_enable,
            o_q      => o_q(2),
            o_qBar   => o_qBar(2)
        );

    REG3: D_LATCH
        PORT MAP(
            i_d      => i_d(3),
            i_enable => i_enable,
            o_q      => o_q(3),
            o_qBar   => o_qBar(3)
        );

    REG4: D_LATCH
        PORT MAP(
            i_d      => i_d(4),
            i_enable => i_enable,
            o_q      => o_q(4),
            o_qBar   => o_qBar(4)
        );

    REG5: D_LATCH
        PORT MAP(
            i_d      => i_d(5),
            i_enable => i_enable,
            o_q      => o_q(5),
            o_qBar   => o_qBar(5)
        );

    REG6: D_LATCH
        PORT MAP(
            i_d      => i_d(6),
            i_enable => i_enable,
            o_q      => o_q(6),
            o_qBar   => o_qBar(6)
        );

    REG7: D_LATCH
        PORT MAP(
            i_d      => i_d(7),
            i_enable => i_enable,
            o_q      => o_q(7),
            o_qBar   => o_qBar(7)
        );
				
	
END structural;