-- Polytechnic School of the University of Sao Paulo
-- Department of Digital Systems and Computational Engineering 
-- Digital Laboratory A - Exp. 6 
-- Functional description of n-bits Shift Register by VHDL
-- Lucas Penna Saraiva and Stefan R. Raposo

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use ieee.std_logic_unsigned.all;


entity shift_register is

-- N is the number of bits of the Shift Register

	generic( N : natural := 7);

	port ( Reset	        : in  std_logic;
			 Clock           : in  std_logic;
			 Parallel_Input  : in  std_logic_vector (N-1 downto 0);
			 Serial_Output   : out std_logic
			);
			
end shift_register;



architecture Behaviour of shift_register is
	
	-- signal
	
	signal auxiliar_input  : std_logic_vector(N-1 downto 0);

	signal bit_control     : integer := 0;
	
	signal auxiliar_output : std_logic;
	
	-- description
	
	begin
	
	-- Shift Process
	
	process(Clock)
	
	begin
	
		if reset = '1' then
		
			auxiliar_input <= (others=> '0');
			
		else
			
			auxiliar_input <= Parallel_Input;
			
		end if;

		-- for each rising edge clock, shift forward one bit
		
		if rising_edge(Clock) then
		
			if bit_control < N then
		
				auxiliar_output <= auxiliar_input(bit_control);
				
				bit_control <= bit_control + 1;
			
			else
	
				auxiliar_output <= auxiliar_input(0);
				bit_control <= 1;
			
			end if;
				
		end if;
		
	end process;
		
	Serial_Output <= auxiliar_output;

end Behaviour;	

-- https://es.wikibooks.org/wiki/Programación_en_VHDL/Arquitectura

			
