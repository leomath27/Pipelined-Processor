-- Copyright (C) 1991-2013 Altera Corporation
-- Your use of Altera Corporation's design tools, logic functions 
-- and other software and tools, and its AMPP partner logic 
-- functions, and any output files from any of the foregoing 
-- (including device programming or simulation files), and any 
-- associated documentation or information are expressly subject 
-- to the terms and conditions of the Altera Program License 
-- Subscription Agreement, Altera MegaCore Function License 
-- Agreement, or other applicable license agreement, including, 
-- without limitation, that your use is for the sole purpose of 
-- programming logic devices manufactured by Altera and sold by 
-- Altera or its authorized distributors.  Please refer to the 
-- applicable agreement for further details.

-- PROGRAM		"Quartus II 64-Bit"
-- VERSION		"Version 13.1.0 Build 162 10/23/2013 SJ Web Edition"
-- CREATED		"Sun Mar 09 19:45:25 2025"

LIBRARY ieee;
USE ieee.std_logic_1164.all; 

LIBRARY work;

ENTITY ALUControl IS 
	PORT
	(
		ALUop :  IN  STD_LOGIC_VECTOR(1 DOWNTO 0);
		func :  IN  STD_LOGIC_VECTOR(5 DOWNTO 0);
		Operation :  OUT  STD_LOGIC_VECTOR(2 DOWNTO 0)
	);
END ALUControl;

ARCHITECTURE bdf_type OF ALUControl IS 

SIGNAL	Operation_ALTERA_SYNTHESIZED :  STD_LOGIC_VECTOR(2 DOWNTO 0);
SIGNAL	SYNTHESIZED_WIRE_0 :  STD_LOGIC;
SIGNAL	SYNTHESIZED_WIRE_1 :  STD_LOGIC;
SIGNAL	SYNTHESIZED_WIRE_2 :  STD_LOGIC;
SIGNAL	SYNTHESIZED_WIRE_3 :  STD_LOGIC;


BEGIN 



SYNTHESIZED_WIRE_0 <= func(0) OR func(3);


Operation_ALTERA_SYNTHESIZED(0) <= ALUop(1) AND SYNTHESIZED_WIRE_0;


SYNTHESIZED_WIRE_1 <= ALUop(1) AND func(1);


Operation_ALTERA_SYNTHESIZED(2) <= SYNTHESIZED_WIRE_1 OR ALUop(0);


Operation_ALTERA_SYNTHESIZED(1) <= SYNTHESIZED_WIRE_2 OR SYNTHESIZED_WIRE_3;


SYNTHESIZED_WIRE_3 <= NOT(ALUop(1));



SYNTHESIZED_WIRE_2 <= NOT(func(2));


Operation <= Operation_ALTERA_SYNTHESIZED;

END bdf_type;