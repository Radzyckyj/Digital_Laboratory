-- Polytechnic School of the University of Sao Paulo
-- Department of Digital System and Computer Engineering
-- Digital Laboratory A - Exp. 6 
-- VHDL structural description of Manchester Encoder IEEE 802.3 Standard
-- Lucas Penna Saraiva and Stefan R. Raposo

-- Notice that there are two patterns of Manchester Encoding. Here, we adopted the IEEE 802.3 paterrn, as recommended on the exercise.
-- The IEEE 802.3 define the Manchester Encoding as the "original data XOR clock"

library ieee;
use ieee.std_logic_1164.all;

entity Manchester_Serial_Encoder is

	port ( Serial_Input  : in std_logic;
			 Clock         : in std_logic;
			 Serial_Output : out std_logic
			 );
			
end Manchester_Serial_Encoder;

Architecture Behaviour of Manchester_Serial_Encoder is

	begin
		-- signal
		
		-- combinational structure
		
		Serial_Output <= Serial_Input xor Clock;
		
end Behaviour;